# Task P011-R3 - Advertised Session Regression & UI Lifecycle Log

## 1. Test Environment and Session Setup
- **Engine Version**: Unreal Engine 5.7.4 (Release-5.7-CL-51494982)
- **Editor PID**: 18460 (Monolith server active on port 9316)
- **Test Topology**: 2-Client Play-In-Editor (`LevelEditorPlaySettings.PlayNumberOfClients = 2`)
- **Initial State**:
  - Editor Map: `Boot_Lvl`
  - Host World: `UEDPIE_0_Boot_Lvl.Boot_Lvl`
  - Client World: `UEDPIE_1_Boot_Lvl.Boot_Lvl`
  - Host GameInstance: `MenuGameinstance_C_0`
  - Client GameInstance: `MenuGameinstance_C_1`
  - Initial Dirty Packages: `0`
  - Baseline SHA256 Hashes: Verified in `coordination/evidence/P011-R3-baseline-hashes.json` (14 entries)

---

## 2. Root Cause Diagnostic: Disabled Rehost & Overlapping Searches

### Finding 1: Why Rehost Button Was Inspected As Disabled in P011-R2
- In PIE with multiple clients, `GameInstance` persists across level transitions (`Boot_Lvl` -> `Map1` -> `Boot_Lvl`), but worlds and player controllers are torn down and recreated.
- During Cycle 1, `MenuPc` instantiated `WBP_Menu_C_0` on `MenuGameinstance_C_0`. When Host clicked `CreateServerbutton`, that instance executed `SetIsEnabled(false)` to prevent duplicate clicks.
- After leaving `Map1` and reloading `Boot_Lvl`, `MenuPc` executed `BeginPlay` and instantiated a brand new widget `WBP_Menu_C_2` into the viewport.
- However, the diagnostic automation script in P011-R2 iterated up to index 10 and selected the first object matching `WBP_Menu_C_i` (`menu0 = unreal.find_object(gi0, "WBP_Menu_C_0")`), which was the orphaned, removed-from-parent widget from Cycle 1 (`in_viewport=False, is_visible=False, btn_enabled=False`).
- **Correction Applied in WBP_Menu**:
  - Added explicit initialization on `Event Construct` to force `CreateServerbutton.SetIsEnabled(true)` and reset label to `"HOST GAME"`.
  - Added `bIsSearching = false` reset on `Event Construct`.
  - Added clean `Unbind Event from OnCreateSessionFailed` on failure handling to prevent stale delegate listeners.
  - Diagnostic inspection script updated to query only widgets actually in viewport (`is_in_viewport() == True`), confirming `btn_enabled=True` before Cycle 2 click without any test overrides.

### Finding 2: Overlapping Browser Requests
- Previously, `Btn_RefreshBrowser` clicked while a search was already executing invoked `ClearChildren(ServerList)` and passed through to `FindSessionsAdvanced`, causing OSS to log `OSS: Ignoring game search request while one is pending`.
- **Correction Applied in WBP_Menu**:
  - Added `bIsSearching` boolean variable.
  - Both `FindingSession` and `Btn_RefreshBrowser` now pass through a `Branch(bIsSearching)` guard.
  - If `bIsSearching == True`, incoming clicks are discarded without clearing the server list or triggering redundant OSS requests.
  - When a search starts (`bIsSearching == False`), `bIsSearching` is immediately set to `True`, and both `FindingSession` and `Btn_RefreshBrowser` widgets are disabled (`SetIsEnabled(false)`).
  - On both `OnSuccess` (loop completed) and `OnFailure` of `FindSessionsAdvanced`, both buttons are re-enabled (`SetIsEnabled(true)`) and `bIsSearching` is reset to `False`.
  - On `Btn_CloseBrowser` ("BACK"), buttons are re-enabled and `bIsSearching` is reset to `False` to guarantee safe state upon returning to home menu.

---

## 3. Regression Cycle 1: Clean Advertised Session Lifecycle

### Step 1: Host Advertised Creation
- Initial state query on Host `WBP_Menu_C_0`:
  - `host_btn.is_enabled`: `True`
  - `bIsSearching`: `False`
- Host clicked `CreateServerbutton` (`OnClicked` broadcast):
  - Post-click duplicate guard: `host_btn.is_enabled` became `False`.
  - Listen travel executed: `UEngine::Browse Started Browse: "/Game/resources/Stylized_Egypt/Maps/Map1??listen"`.
  - Host World: `UEDPIE_0_Map1.Map1`.
  - GameMode: `GM_ProphuntGameMode_C_0`, player count = 1.

### Step 2: Client Guard Test, Discovery & Join
- Initial state query on Client `WBP_Menu_C_1`:
  - `find_btn.is_enabled`: `True`
  - `refresh_btn.is_enabled`: `True`
  - `bIsSearching`: `False`
- Client clicked `FindingSession`:
  - Mid-search states verified: `find_btn.is_enabled = False`, `refresh_btn.is_enabled = False`, `bIsSearching = True`.
- Guard test executed:
  - Triggered second click on `Btn_RefreshBrowser` while `bIsSearching = True`.
  - Guard branched to `True` (bIsSearching active) and rejected input. Engine log confirmed: 0 OSS warnings, no duplicate requests.
- Search completed:
  - `find_btn.is_enabled` restored to `True`.
  - `refresh_btn.is_enabled` restored to `True`.
  - `bIsSearching` restored to `False`.
  - Server row discovered: `WBP_Server_C_0`, server name `"Prop Hunt Server"`, child count = 1.
- Client clicked `Button_0` (JOIN):
  - Client traveled to Host on `Map1`.
  - Roster query verified: `GM_ProphuntGameMode_C_0.get_num_players() == 2`.

### Step 3: Client Leave Session
- Client invoked `LeaveGameSession` on `MenuGameinstance_C_1`:
  - Session destroyed cleanly; client traveled back to `UEDPIE_1_Boot_Lvl`.
  - Host world remained active on `Map1`.
  - Host player count decremented cleanly to 1 (`GM_ProphuntGameMode_C_0.get_num_players() == 1`).

### Step 4: Host Leave Session
- Host invoked `LeaveGameSession` on `MenuGameinstance_C_0`:
  - Host destroyed session and traveled back to `UEDPIE_0_Boot_Lvl`.
  - Both clients returned safely to `Boot_Lvl`.

---

## 4. Regression Cycle 2: Genuine Enabled Rehost & Dual Join

### Step 1: Host Usable Idle State & Enabled Rehost
- Inspected active Host menu in viewport on `UEDPIE_0_Boot_Lvl`:
  - Active widget: `WBP_Menu_C_2` (`is_in_viewport = True`, `is_visible = True`).
  - Button state query: `host_btn.get_is_enabled() == True` (Verified without any test overrides).
  - Search state: `bIsSearching == False`.
- Host clicked `CreateServerbutton` on active menu:
  - Duplicate lock engaged: `host_btn.is_enabled` became `False`.
  - Listen travel executed: `UEngine::Browse Started Browse: "/Game/resources/Stylized_Egypt/Maps/Map1??listen"`.
  - Host World: `UEDPIE_0_Map1.Map1`.
  - GameMode: `GM_ProphuntGameMode_C_0`, player count = 1.

### Step 2: Client Discovery via Browser
- Inspected active Client menu in viewport on `UEDPIE_1_Boot_Lvl`:
  - Active widget: `WBP_Menu_C_2` (`is_in_viewport = True`).
  - `find_btn.is_enabled`: `True`.
  - `refresh_btn.is_enabled`: `True`.
- Client clicked `FindingSession`:
  - Server browser opened (`BorderServer` visible).
  - Search executed and populated `ServerList`:
    - Row: `WBP_Server_C_1`
    - Server Name: `"Prop Hunt Server"`
    - Results count: 1

### Step 3: Client Rejoin & Dual Roster Verification
- Client clicked `Button_0` (JOIN) on `WBP_Server_C_1`:
  - Client traveled cleanly to `UEDPIE_1_Map1.Map1`.
  - Roster query executed via Unreal Python:
    - Host World `w0`: `Map1`
    - Client World `w1`: `Map1`
    - GameMode: `GM_ProphuntGameMode_C_0`
    - `Players on GM0 in Cycle 2`: `2` (Verified 100%)

### Step 4: Clean Teardown
- Client called `LeaveGameSession` -> traveled back to `Boot_Lvl`.
- Host called `LeaveGameSession` -> traveled back to `Boot_Lvl`.
- PIE stopped cleanly via `editor_query:stop_pie`.
- Play settings restored: `PlayNumberOfClients = 1`.
- Editor map parked on `/Game/Core/Map/Boot_Lvl`.
- Package hygiene: 0 dirty packages.

---

## 5. Hash Manifest Verification
- All 14 tracked project assets verified in `coordination/evidence/P011-R3-final-hashes.json`.
- Modified assets (within task scope):
  - `Content\Core\Widgets\WBP_Menu.uasset` (Added `bIsSearching` guard, Construct button/label reset, CloseBrowser reset, delegate unbind on failure)
- Unmodified assets (100% matched baseline):
  - `Content\Core\Widgets\WBP_Server.uasset` (MATCH)
  - `Content\Core\Map\MenuGameinstance.uasset` (MATCH)
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
