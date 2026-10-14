# Task P011-R5 - Serialized Search Request & Join Duplicate Guard Regression Log

## 1. Environment and Initial State
- **Engine Version**: Unreal Engine 5.7.4 (Release-5.7-CL-51494982)
- **Editor PID**: 18460 (Monolith active on port 9316)
- **Test Topology**: 2-Client Play-In-Editor (`LevelEditorPlaySettings.PlayNumberOfClients = 2`)
- **Initial State**:
  - Initial Map: `Boot_Lvl`
  - Pre-edit Backup Directory: `coordination/backups/P011-R5-20261007-161616/`
  - Baseline SHA256 Hashes: Verified in `coordination/evidence/P011-R5-baseline-hashes.json` (14 entries)
  - Initial Dirty Packages: `0`

---

## 2. Root Cause Analysis & Architecture Adjustments

### Issue 1: Asynchronous Search Request Serialization and Single-Outstanding Ownership
- **Previous Defect (P011-R4)**:
  - On `Btn_CloseBrowser` ("BACK"), `bIsSearching` was reset to `false` and controls were prematurely re-enabled while the underlying OSS async task (`FindSessionsAdvanced`) was still executing.
  - Reopening the browser immediately allowed a second search request to start, overlapping OSS queries and overwriting `ActiveRequestGeneration`.
  - In `OnSuccess`, the equality check lacked completion cleanup on the mismatch (`else`) branch, and `OnFailure` had no generation guard.
- **Correction Applied in `WBP_Menu.uasset`**:
  - **Retained Request Ownership Across Back**: `Btn_CloseBrowser` ("BACK") now only sets `BorderServer` visibility to `HIDDEN` and increments `CurrentSearchGeneration += 1` to invalidate presentation and mark any in-flight results obsolete. It **does NOT** reset `bIsSearching = false` or re-enable buttons.
  - **Serialized Single-Outstanding-Search Contract**: `FindingSession` and `Btn_RefreshBrowser` branch on `bIsSearching`. While a search is active, reopening the browser presents the UI without launching duplicate OSS requests or overwriting active tokens.
  - **Both Completion Paths Release Ownership**: Both `OnSuccess` (loop complete or mismatch) and `OnFailure` funnel through the completion cleanup node (`SetIsEnabled(true)` on buttons and `Set bIsSearching = false`), guaranteeing that ownership is released regardless of whether results were populated or discarded.

### Issue 2: Duplicate Join Submissions in `WBP_Server.uasset`
- **Previous Defect (P011-R4)**:
  - `Button_0` in `WBP_Server` directly fired `JoinSession` without checking or setting a joining lock.
- **Correction Applied in `WBP_Server.uasset`**:
  - Added boolean variable `bIsJoining` (default `false`).
  - `OnClicked (Button_0)` passes through `Branch(bIsJoining)`. If `bIsJoining == true`, duplicate clicks are rejected immediately.
  - On first click (`bIsJoining == false`), `bIsJoining` is set to `true`, and button label text is updated to `"JOINING..."` before executing `JoinSession`.
  - On `JoinSession.OnFailure`, the failure text is set to `"JOIN FAILED"` and `bIsJoining` is reset to `false`, restoring usable retry capability.
  - On `JoinSession.OnSuccess`, widgets are removed as player travels to host.

---

## 3. Immediate Search -> Back -> Reopen -> Refresh Reproduction Test

Executed during live 2-client PIE simulation while Host was running `Map1` (`GM_ProphuntGameMode_C_0`, 1 player):

### Step 1: Baseline State
- Active Client Menu: `WBP_Menu_C_1` (`is_in_viewport == True`).
- `bIsSearching`: `False`.
- `CurrentSearchGeneration`: `0`, `ActiveRequestGeneration`: `0`.
- `FindingSession.is_enabled`: `True`, `Btn_RefreshBrowser.is_enabled`: `True`.
- `BorderServer` visibility: `HIDDEN`.

### Step 2: Action 1 - Start Search
- Triggered `FindingSession.on_clicked.broadcast()`.
- Observed:
  - `bIsSearching`: `True` (Lock engaged).
  - `CurrentSearchGeneration`: `1`, `ActiveRequestGeneration`: `1`.
  - `BorderServer` visibility: `VISIBLE`.
  - `FindingSession.is_enabled`: `False`, `Btn_RefreshBrowser.is_enabled`: `False`.

### Step 3: Action 2 - Immediate Back While Search Active
- Immediately triggered `Btn_CloseBrowser.on_clicked.broadcast()` before OSS query completed.
- Observed:
  - `bIsSearching`: `True` (**Ownership retained across Back!**).
  - `CurrentSearchGeneration`: `2` (Incremented to invalidate presentation).
  - `ActiveRequestGeneration`: `1` (Preserved in-flight token).
  - `BorderServer` visibility: `HIDDEN`.
  - `FindingSession.is_enabled`: `False`, `Btn_RefreshBrowser.is_enabled`: `False` (Buttons locked against overlapping requests).

### Step 4: Action 3 - Immediate Reopen While Search Active
- Immediately triggered `FindingSession.on_clicked.broadcast()` while search was still pending.
- Observed:
  - `bIsSearching`: `True`.
  - `CurrentSearchGeneration`: `2`, `ActiveRequestGeneration`: `1` (No token overwrite, no duplicate OSS query).
  - `BorderServer` visibility: `VISIBLE`.
  - `FindingSession.is_enabled`: `False`, `Btn_RefreshBrowser.is_enabled`: `False`.
  - `ServerList` Children count: `0`.

### Step 5: Action 4 - Immediate Refresh While Search Active
- Immediately triggered `Btn_RefreshBrowser.on_clicked.broadcast()` while search was still pending.
- Observed:
  - Discarded by `Branch(bIsSearching == True)`.
  - `CurrentSearchGeneration`: `2`, `ActiveRequestGeneration`: `1`.
  - `ServerList` Children count: `0`.

### Step 6: Callback Completion & Invalidation Outcome
- Search completed over network:
  - `Branch(ActiveRequestGeneration == CurrentSearchGeneration)` evaluated `1 == 2` -> `False` (Mismatch!).
  - Loop body bypassed: `0` rows populated into `ServerList`.
  - Mismatch `else` branch executed completion cleanup:
    - `bIsSearching` restored to `False`.
    - `FindingSession.is_enabled` restored to `True`.
    - `Btn_RefreshBrowser.is_enabled` restored to `True`.
  - Outcome: Obsolete callback cleanly neutralized; 0 ghost rows populated.

---

## 4. Clean Refresh, Duplicate Join Guard & Two Regression Cycles

### Cycle 1: Clean Refresh, Discovery & Duplicate Join Guard
1. **Clean Refresh**:
   - Client clicked `Btn_RefreshBrowser` with browser open.
   - `CurrentSearchGeneration`: `3`, `ActiveRequestGeneration`: `3` (Matching tokens).
   - Search completed: `WBP_Server_C_0` populated into `ServerList` (`child count = 1`).
   - `bIsSearching` restored to `False`, `Button_0.is_enabled = True`.
2. **Duplicate Join Submission Test**:
   - Initial `bIsJoining`: `False`.
   - Click 1: Clicked `Button_0`. `bIsJoining` became `True`, label updated.
   - Click 2: Immediately fired second click on `Button_0`. Guard rejected duplicate click (`bIsJoining` remained `True`, no duplicate OSS join fired).
3. **Dual Roster Verification**:
   - Client traveled to `Map1`.
   - Host World: `Map1`, Client World: `Map1`.
   - GameMode: `GM_ProphuntGameMode_C_0`, player count = `2`.
4. **Teardown**:
   - Client invoked `LeaveGameSession` -> traveled back to `Boot_Lvl`.
   - Host count decremented to `1`.
   - Host invoked `LeaveGameSession` -> traveled back to `Boot_Lvl`.

### Cycle 2: Genuine Enabled Rehost & Dual Join
1. **Host Rehost**:
   - Active Host widget on `Boot_Lvl`: `WBP_Menu_C_2` (`is_in_viewport == True`).
   - `CreateServerbutton.is_enabled`: `True` (Genuine default state; no test overrides).
   - Host clicked `CreateServerbutton` -> traveled to `Map1` (`GM_ProphuntGameMode_C_0`, 1 player).
2. **Client Discovery & Join**:
   - Client on `Boot_Lvl` (`WBP_Menu_C_2`) clicked `FindingSession`.
   - Discovered `WBP_Server_C_1` (`child count = 1`).
   - Clicked `Button_0` (JOIN) -> traveled to `Map1`.
   - Verified player count on `GM_ProphuntGameMode_C_0`: `2` (Host + Client verified).
3. **Teardown & Cleanup**:
   - Both clients called `LeaveGameSession`.
   - Stopped PIE via `editor_query:stop_pie`.
   - Restored `LevelEditorPlaySettings.PlayNumberOfClients = 1`.
   - Parked editor level on `/Game/Core/Map/Boot_Lvl`.
   - Verified dirty packages: `0`.

---

## 5. Hash Manifest Verification
All 14 project-tracked assets verified in `coordination/evidence/P011-R5-final-hashes.json`:
- **Modified Assets (In Scope)**:
  - `Content\Core\Widgets\WBP_Menu.uasset` (Retained search ownership across Back, single-outstanding-search contract, completion cleanup on mismatch branch)
  - `Content\Core\Widgets\WBP_Server.uasset` (Added `bIsJoining` duplicate guard, joining status, and failure recovery reset)
- **Unmodified Assets (100% Matched Baseline)**:
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
