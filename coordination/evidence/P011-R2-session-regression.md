# Task P011-R2 - Advertised Session Two-Cycle Regression & UI Lifecycle Log

## 1. Test Environment and Session Setup
- **Engine Version**: Unreal Engine 5.7.4 (Release-5.7-CL-51494982)
- **Editor PID**: 18776 (Monolith server active on port 9316)
- **Test Topology**: 2-Client Play-In-Editor (`LevelEditorPlaySettings.PlayNumberOfClients = 2`)
- **Initial State**:
  - Editor Map: `Boot_Lvl`
  - Host World: `UEDPIE_0_Boot_Lvl.Boot_Lvl`
  - Client World: `UEDPIE_1_Boot_Lvl.Boot_Lvl`
  - Host GameInstance: `MenuGameinstance_C`
  - Client GameInstance: `MenuGameinstance_C`
  - Initial Dirty Packages: `0`
  - Baseline SHA256 Hashes: Verified in `coordination/evidence/P011-R2-baseline-hashes.json` (14 entries)

---

## 2. Regression Cycle 1: Full Advertised Lifecycle

### Step 1: Host Advertised Session Creation
- **Action**: Host clicked `CreateServerbutton` on `WBP_Menu_C_0`.
- **UI State Verification**:
  - Host clicked `CreateServerbutton` (`OnClicked` broadcast).
  - Duplicate-submission lock engaged: `CreateServerbutton.is_enabled` became `False`.
  - Button text transitioned to `"HOSTING..."`.
- **Underlying Blueprint Execution**:
  - `MenuGameinstance.MenuInstanceNewSession` executed `CreateAdvancedSession`.
  - Session advertised on Online Subsystem (OSS).
  - Host executed listen server browse: `UEngine::Browse Started Browse: "/Game/resources/Stylized_Egypt/Maps/Map1??listen"`.
  - World transitioned to `/Game/resources/Stylized_Egypt/Maps/UEDPIE_0_Map1.Map1`.
  - GameMode: `GM_ProphuntGameMode_C_0`, initial player count = 1.

### Step 2: Client Discovery, Refresh & Join
- **Action**: On `UEDPIE_1_Boot_Lvl`, Client clicked `FindingSession` and `Btn_RefreshBrowser` on `WBP_Menu_C_1`.
- **UI & Browser Execution**:
  - `BorderServer` transitioned to `Visible`.
  - `Btn_RefreshBrowser` clicked (`OnClicked` broadcast) -> `ClearChildren(ServerList)` -> `FindSessionsAdvanced`.
  - Advertised session discovered: `txt_sname` = `"Prop Hunt Server"`, `1/2` players.
  - Long name handling verified: `TextOverflowPolicy = Ellipsis` active on `txt_sname` in `WBP_Server_C`.
  - Client clicked `Button_0` ("JOIN") on discovered `WBP_Server_C_0`.
  - Client joined Host on `UEDPIE_0_Map1`.
- **Multiplayer Roster Verification**:
  - `GM_ProphuntGameMode_C_0.get_num_players()` returned `2`.
  - Host controller: `BP_ThirdPersonPlayerController_C_0` on `UEDPIE_0_Map1`.
  - Client controller: `BP_ThirdPersonPlayerController_C_1` on `UEDPIE_1_Map1`.

### Step 3: Client Leave & Host Count Decrement
- **Action**: Client called `LeaveGameSession` on `MenuGameinstance_C`.
- **Teardown Execution**:
  - Client destroyed session and traveled cleanly back to `/Game/Core/Map/UEDPIE_1_Boot_Lvl`.
  - Host world remained active on `UEDPIE_0_Map1.Map1`.
  - `GM_ProphuntGameMode_C_0.get_num_players()` cleanly decremented from `2` to `1`. No crashes, no hangs.

### Step 4: Host Teardown
- **Action**: Host called `LeaveGameSession` on `MenuGameinstance_C`.
- **Teardown Execution**:
  - Host destroyed session and traveled cleanly back to `/Game/Core/Map/UEDPIE_0_Boot_Lvl`.
  - Both clients returned safely to `Boot_Lvl`.

---

## 3. Regression Cycle 2: Immediate Rehost, Rediscovery & Rejoin

### Step 1: Host Immediate Rehost
- **Action**: On `UEDPIE_0_Boot_Lvl`, Host triggered `CreateServerbutton` on re-instantiated `WBP_Menu_C_0`.
- **Engine Logs & Browse**:
  - Host executed listen travel: `UEngine::Browse Started Browse: "/Game/resources/Stylized_Egypt/Maps/Map1??listen"`.
  - World transitioned to `UEDPIE_0_Map1.Map1`.
  - GameMode: `GM_ProphuntGameMode_C_0`, player count = 1.

### Step 2: Client Rediscovery & Refresh
- **Action**: On `UEDPIE_1_Boot_Lvl`, Client opened browser and clicked `Btn_RefreshBrowser`.
- **Execution**:
  - `ServerList` populated with newly advertised session entry:
    - Server Name: `"Prop Hunt Server"`
    - Child widget: `WBP_Server_C_0`
    - Child count: 2 (subsequent refresh/find results populated cleanly)

### Step 3: Client Rejoin & Dual-Player Roster Verification
- **Action**: Client clicked `Button_0` (JOIN) on `WBP_Server_C_0`.
- **Engine Logs**:
  ```text
  [LogNet][log] Login request: ?Name=VENOM-6D7496A54937F0AC85F149B65E84854F
  [LogNet][log] Welcomed by server (Level: /Game/resources/Stylized_Egypt/Maps/UEDPIE_0_Map1, Game: /Game/Core/BluePrints/GM_ProphuntGameMode.GM_ProphuntGameMode_C)
  [LogLoad][log] Took 0.346355 seconds to LoadMap(/Game/resources/Stylized_Egypt/Maps/Map1)
  [LogWorld][log] Bringing World /Game/resources/Stylized_Egypt/Maps/UEDPIE_1_Map1.Map1 up for play at 2026.10.07-04.36.12
  ```
- **Roster Verification**:
  - Query executed via Unreal Python:
    - Host World `w0`: `Map1`
    - Client World `w1`: `Map1`
    - GameMode: `GM_ProphuntGameMode_C_0`
    - `GM0 Num Players`: `2` (Verified 100%)

### Step 4: Clean Teardown of Cycle 2
- **Action**:
  1. Client called `LeaveGameSession` -> traveled back to `UEDPIE_1_Boot_Lvl` -> Host player count decremented cleanly to `1`.
  2. Host called `LeaveGameSession` -> traveled back to `UEDPIE_0_Boot_Lvl`.
  3. PIE stopped cleanly via `editor_query:stop_pie`.
  4. Editor play settings restored: `PlayNumberOfClients = 1`.
  5. Editor parked on `/Game/Core/Map/Boot_Lvl`.
  6. Final dirty packages: `0`.

---

## 4. Hash Manifest Verification
- All 14 tracked project assets verified in `coordination/evidence/P011-R2-final-hashes.json`.
- Modified assets (within task scope):
  - `Content\Core\Widgets\WBP_Menu.uasset` (Added `Btn_RefreshBrowser`, failure handling, typography update)
  - `Content\Core\Widgets\WBP_Server.uasset` (Set `txt_sname` overflow policy to Ellipsis)
  - `Content\Core\Map\MenuGameinstance.uasset` (Added `OnCreateSessionFailed` dispatcher & delegate call)
- Unmodified assets (100% matched baseline):
  - `Content\Core\Widgets\T_Map1_Background.uasset` (MATCH)
  - `Content\Core\Widgets\T_Map1_Preview.uasset` (MATCH)
  - `Content\Core\Map\UI_Bootlvl.uasset` (MATCH)
  - `Content\Core\Widgets\MainMenu\UI\WBP_MainMenu.uasset` (MATCH)
  - `Content\Core\BluePrints\BP_ThirdPersonPlayerController.uasset` (MATCH)
  - `Content\Core\Widgets\UW_MainHUD.uasset` (MATCH)
  - `Content\Core\Map\Boot_Lvl.umap` (MATCH)
  - `Content\resources\Stylized_Egypt\Maps\Map1.umap` (MATCH)
  - `Config\DefaultEngine.ini` (MATCH)
  - `Config\DefaultGame.ini` (MATCH)
  - `SheeshhPropHuntYT.uproject` (MATCH)
