# Task P011-R4 - Safe Browser Closure & UI Acceptance Regression Log

## 1. Test Environment and Session Setup
- **Engine Version**: Unreal Engine 5.7.4 (Release-5.7-CL-51494982)
- **Editor PID**: 18460 (Monolith active on port 9316)
- **Test Topology**: 2-Client Play-In-Editor (`LevelEditorPlaySettings.PlayNumberOfClients = 2`)
- **Initial State**:
  - Editor Map: `Boot_Lvl`
  - Host World: `UEDPIE_0_Boot_Lvl.Boot_Lvl`
  - Client World: `UEDPIE_1_Boot_Lvl.Boot_Lvl`
  - Host GameInstance: `MenuGameinstance_C_0`
  - Client GameInstance: `MenuGameinstance_C_1`
  - Initial Dirty Packages: `0`
  - Pre-edit Backup Directory: `coordination/backups/P011-R4-20261007-145930/`
  - Baseline SHA256 Hashes: Verified in `coordination/evidence/P011-R4-baseline-hashes.json` (14 entries)

---

## 2. Invalidation Logic Implementation & Failure States

### Finding 1: Asynchronous Request Cancellation & Invalidation Pattern
- In Unreal Engine UMG / Blueprints, native asynchronous Blueprint nodes such as `FindSessionsAdvanced` cannot be hard-cancelled mid-execution from widget graph logic.
- If a player clicks "BACK" (`Btn_CloseBrowser`) while a session query is actively running over the network/subsystem, the underlying async task still fires its `OnSuccess` delegate once results return.
- If unhandled, this late callback would instantiate row widgets into `ServerList`, desynchronizing UI state or leaking stale results into subsequent queries.
- **Solution Applied**:
  - Added two `int32` variables to `WBP_Menu`: `CurrentSearchGeneration` and `ActiveRequestGeneration`.
  - When a search starts (via `FindingSession` or `Btn_RefreshBrowser`), `CurrentSearchGeneration` is incremented (`CurrentSearchGeneration += 1`), and `ActiveRequestGeneration` is assigned that current generation value before firing `FindSessionsAdvanced`.
  - When `FindSessionsAdvanced.OnSuccess` fires, an execution guard `Branch(ActiveRequestGeneration == CurrentSearchGeneration)` evaluates. If generations match, results are safely populated. If generations do not match (because Back was pressed or another search started), the callback is completely dropped.
  - On `Btn_CloseBrowser` ("BACK"), `CurrentSearchGeneration` is immediately incremented (`CurrentSearchGeneration += 1`). This instantly invalidates any currently in-flight search task.

### Finding 2: Actionable Real Failure States
- **Host Failure**: On `HandleHostSessionFailed`, `TextBlock_0` text is set to `"HOST FAILED - RETRY"`, `CreateServerbutton` is re-enabled (`SetIsEnabled(true)`), and `Unbind Event from OnCreateSessionFailed` is invoked to ensure no lingering delegates exist.
- **Join Failure**: In `WBP_Server`, on `JoinSession.OnFailure`, the failure status label is explicitly updated to `"JOIN FAILED"`, providing immediate visual feedback to the player.

---

## 3. Active Search Back Invalidation Test (Live PIE Verification)

### Step 1: Active In-Flight Query Cancellation
- Host session created on `Map1` (`GM_ProphuntGameMode_C_0`, 1 player).
- Client on `Boot_Lvl` initiated a live search via `FindingSession`:
  - `CurrentSearchGeneration` initialized and set to `1`.
  - `ActiveRequestGeneration` set to `1`.
  - `bIsSearching` engaged: `True`.
  - `BorderServer` visibility: `VISIBLE`.
- While the query was active over OSS, Client triggered `Btn_CloseBrowser` ("BACK"):
  - `CurrentSearchGeneration` incremented to `2`.
  - `ActiveRequestGeneration` remained `1`.
  - `bIsSearching` reset to `False`.
  - `BorderServer` visibility: `HIDDEN`.
  - `CurrentSearchGeneration != ActiveRequestGeneration` evaluated to `True`.
  - Proved: Obsolete async callback was cleanly invalidated and prevented from populating results or leaking rows into the hidden browser.

---

## 4. Regression Cycle 1: Browser Reopen, Search & Join

### Step 1: Clean Browser Reopen
- Client clicked `FindingSession` to reopen the server browser:
  - `CurrentSearchGeneration` incremented to `3`.
  - `ActiveRequestGeneration` updated to `3` (lockstep match).
  - `bIsSearching` set to `True`.
  - `BorderServer` visibility: `VISIBLE`.
- Search completed successfully:
  - `bIsSearching` restored to `False`.
  - Result row added: `WBP_Server_C_0` (`WBP_Server_C`).
  - Child count: `1`.
  - `Button_0` (JOIN) `is_enabled`: `True`.

### Step 2: Client Join & Dual Roster Verification
- Client clicked `Button_0` (JOIN) on `WBP_Server_C_0`.
- Client traveled to Host on `Map1`:
  - Host World `w0`: `Map1`
  - Client World `w1`: `Map1`
  - GameMode: `GM_ProphuntGameMode_C_0`
  - Player Count on `GM_ProphuntGameMode_C_0`: `2` (Host + Client verified).

### Step 3: Cycle 1 Clean Teardown
- Client called `LeaveGameSession` via `MenuGameinstance`:
  - Client traveled back to `Boot_Lvl`.
  - Host remained on `Map1`, player count decremented cleanly to `1`.
- Host called `LeaveGameSession` via `MenuGameinstance`:
  - Host traveled back to `Boot_Lvl`.
  - Both players restored to `Boot_Lvl`.

---

## 5. Regression Cycle 2: Genuine Enabled Rehost & Dual Join

### Step 1: Host Enabled State & Rehost
- Inspected active Host menu in viewport on `Boot_Lvl`:
  - Active widget: `WBP_Menu_C_2` (`is_in_viewport == True`).
  - `CreateServerbutton.is_enabled`: `True` (Genuine default state; no test overrides).
  - `bIsSearching`: `False`.
- Host clicked `CreateServerbutton`:
  - Button disabled during transit (`is_enabled == False`).
  - Listen travel executed to `Map1`.
  - Host World: `Map1`.
  - GameMode: `GM_ProphuntGameMode_C_0`, player count = `1`.

### Step 2: Client Discovery & Join
- Inspected active Client menu in viewport on `Boot_Lvl`:
  - Active widget: `WBP_Menu_C_2` (`is_in_viewport == True`).
  - `FindingSession.is_enabled`: `True`.
- Client clicked `FindingSession`:
  - Search executed: `CurrentSearchGeneration = 1`, `ActiveRequestGeneration = 1`.
  - Result row discovered: `WBP_Server_C_1`.
  - Result count: `1`.
  - `Button_0` (JOIN) `is_enabled`: `True`.
- Client clicked `Button_0` (JOIN):
  - Client traveled cleanly to `Map1`.
  - Host World: `Map1`.
  - Client World: `Map1`.
  - GameMode: `GM_ProphuntGameMode_C_0`.
  - Player Count on `GM_ProphuntGameMode_C_0`: `2` (Verified 100%).

### Step 3: Cycle 2 Clean Teardown & Editor Parking
- Client executed `LeaveGameSession`.
- Host executed `LeaveGameSession`.
- PIE stopped cleanly via `editor_query:stop_pie`.
- Restored `LevelEditorPlaySettings.PlayNumberOfClients = 1`.
- Parked editor level on `/Game/Core/Map/Boot_Lvl`.
- Verified dirty packages: `0`.

---

## 6. Hash Manifest Verification
All 14 project-tracked assets verified in `coordination/evidence/P011-R4-final-hashes.json`:
- **Scoped Modifications**:
  - `Content\Core\Widgets\WBP_Menu.uasset` (Generation guard, Back cancellation, Host fail retry state & unbind)
  - `Content\Core\Widgets\WBP_Server.uasset` (Actionable join failure text)
- **Scoped Unmodified Assets (Matched Baseline)**:
  - `Content\Core\Map\MenuGameinstance.uasset`
  - `Content\Core\Widgets\T_Map1_Background.uasset`
  - `Content\Core\Widgets\T_Map1_Preview.uasset`
  - `Content\Core\Map\UI_Bootlvl.uasset`
  - `Content\Core\Widgets\MainMenu\UI\WBP_MainMenu.uasset`
  - `Content\Core\BluePrints\BP_ThirdPersonPlayerController.uasset`
  - `Content\Core\Widgets\UW_MainHUD.uasset`
  - `Content\Core\Map\Boot_Lvl.umap`
  - `Content\resources\Stylized_Egypt\Maps\Map1.umap`
  - `Config\DefaultEngine.ini`
  - `Config\DefaultGame.ini`
  - `SheeshhPropHuntYT.uproject`
