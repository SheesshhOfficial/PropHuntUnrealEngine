# Task P011-R1 - Advertised Session Regression & UI Lifecycle Log

## 1. Test Environment and Session Setup
- **Engine Version**: Unreal Engine 5.7.4 (Release-5.7-CL-51494982)
- **Editor PID**: 18776 (Monolith server active on port 9316)
- **Test Topology**: 2-Client Play-In-Editor (`LevelEditorPlaySettings.PlayNumberOfClients = 2`)
- **Initial State**:
  - Host World: `UEDPIE_0_Boot_Lvl.Boot_Lvl`
  - Client World: `UEDPIE_1_Boot_Lvl.Boot_Lvl`
  - Host GameInstance: `MenuGameinstance_C_32`
  - Client GameInstance: `MenuGameinstance_C_33`
  - Editor Dirty Packages: `0`
  - Baseline SHA256 Hashes: Verified in `coordination/evidence/P011-R1-baseline-hashes.json` (12 tracked assets)

---

## 2. Advertised Session Host Flow (Scope 2 & 5)

### Step 1: Host Click and Duplicate Submission Lock
- **Action**: On `UEDPIE_0_Boot_Lvl`, Host triggered `CreateServerbutton` `OnClicked` on `WBP_Menu_C_0`.
- **Underlying Blueprint Execution**:
  - `CreateServerbutton` was immediately disabled (`SetIsEnabled(false)`) to lock out duplicate submissions.
  - Legacy premature `RemoveAllWidgets` node was bypassed, preserving UI on screen until engine level transition.
  - GameInstance call `MenuInstanceNewSession(ServerName="HostSessionP0", AmountOfSlott=2)` was invoked.
  - `CreateAdvancedSession` executed on Online Subsystem with:
    - `bShouldAdvertise`: `true`
    - `bUseLAN`: `false`
    - `PublicConnections`: `2`
    - `ExtraSettings`: `SessionName="HostSessionP0"`, `MaxPlayers=2`
  - Host traveled to listen server: `UEngine::Browse Started Browse: "/Game/resources/Stylized_Egypt/Maps/Map1??listen"`
- **Engine Logs**:
  ```text
  [LogGlobalStatus][log] UEngine::LoadMap Load map complete /Game/resources/Stylized_Egypt/Maps/Map1
  [LogLoad][log] LoadMap: /Game/resources/Stylized_Egypt/Maps/Map1??listen
  [LogNet][log] InitBase GameNetDriver (NetDriverDefinition GameNetDriver) using replication model Generic
  [LogNet][log] Created socket for bind address: 0.0.0.0:7777
  [LogNet][log] Name:GameNetDriver Def:GameNetDriver IpNetDriver_60 IpNetDriver listening on port 7777
  [LogWorld][log] Bringing World /Game/resources/Stylized_Egypt/Maps/UEDPIE_0_Map1.Map1 up for play at 2026.10.07-04.05.08
  ```
- **Roster & State Verification**:
  - World: `UEDPIE_0_Map1.Map1`
  - GameMode: `GM_ProphuntGameMode_C_0`
  - Initial Player Count: `1`

---

## 3. Client Advertised Discovery & Browser Join (Scope 3 & 6)

### Step 1: Server Browser Open & Discovery
- **Action**: On Client (`UEDPIE_1_Boot_Lvl`), clicked `FindingSession` ("SERVER BROWSER" button) on `WBP_Menu_C_1`.
- **Underlying Blueprint Execution**:
  - `BorderServer` transitioned from `Hidden` to `Visible`.
  - `FindingSession` button was disabled (`SetIsEnabled(false)`) during active search.
  - `ServerList` was cleared (`ClearChildren`).
  - `FindSessionsAdvanced` queried the Online Subsystem.
- **Engine Logs**:
  ```text
  [LogScript][log] Script Msg: Found a session. Ping is 9
  [LogScript][log] Script Msg: Found a session. Ping is 333
  ```

### Step 2: Server Row Population (`WBP_Server`)
- **Action**: `OnSuccess` execution loop created a `WBP_Server` row entry and added it to `ServerList`.
- **Populated Row Verification**:
  - Widget: `WBP_Server_C_0`
  - `txt_sname`: `"HostSessionP0"`
  - `txt_ammountofplayer`: `"1/2"`
  - `txt_ping`: `"9"`
  - `Button_0`: Enabled and bound to `JoinSession`.

### Step 3: Client Join Execution
- **Action**: Client clicked `Button_0` ("JOIN") on `WBP_Server_C_0`.
- **Underlying Blueprint Execution**:
  - `JoinSession` initiated travel to Host address `10.29.54.83:7777`.
  - Client world transitioned from `UEDPIE_1_Boot_Lvl` to `UEDPIE_1_Map1`.
- **Engine Logs**:
  ```text
  [LogWorld][log] UWorld::CleanupWorld for Boot_Lvl, bSessionEnded=true, bCleanupResources=true
  [LogSlate][log] InvalidateAllWidgets triggered. All widgets were invalidated
  [LogPlayLevel][log] PIE: Created PIE world by copying editor world to UEDPIE_1_Map1.Map1
  [LogWorld][log] Bringing World /Game/resources/Stylized_Egypt/Maps/UEDPIE_1_Map1.Map1 up for play at 2026.10.07-04.06.43
  [LogLoad][log] Took 0.286789 seconds to LoadMap(/Game/resources/Stylized_Egypt/Maps/Map1)
  [LogGlobalStatus][log] UEngine::LoadMap Load map complete /Game/resources/Stylized_Egypt/Maps/Map1
  [LogGlobalStatus][log] UPendingNetGame::TravelCompleted Pending net game travel completed
  [LogNet][log] Join succeeded: VENOM-040883A943BA40
  ```
- **Roster & Synchronization Verification**:
  - Host World: `UEDPIE_0_Map1`
  - Client World: `UEDPIE_1_Map1`
  - GameMode: `GM_ProphuntGameMode_C_0`
  - `gm.get_num_players()`: `2` (Host + Client synchronized in arena)

---

## 4. Client Leave Session & Host Persistence

### Step 1: Client Leave via Pause Menu
- **Action**: Client on `UEDPIE_1_Map1` triggered `LeaveGameSession`.
- **Underlying Blueprint Execution**:
  - `DestroySession(SessionName="GameSession")` was executed.
  - NetDriver `IpNetDriver_61` shut down cleanly.
  - Client traveled back to `UEDPIE_1_Boot_Lvl.Boot_Lvl`.
- **Engine Logs**:
  ```text
  [LogNet][log] DestroyNamedNetDriver: Name:GameNetDriver Def:GameNetDriver IpNetDriver_61
  [LogNet][log] UNetConnection::Close: [UNetConnection] RemoteAddr: 10.29.54.83:7777, Name: IpConnection_44
  [LogWorld][log] UWorld::CleanupWorld for Map1, bSessionEnded=true, bCleanupResources=true
  [LogWorld][log] Bringing World /Game/Core/Map/UEDPIE_1_Boot_Lvl.Boot_Lvl up for play at 2026.10.07-04.07.13
  [LogLoad][log] Took 0.180385 seconds to LoadMap(/Game/Core/Map/UEDPIE_1_Boot_Lvl)
  [LogNet][log] UNetDriver::RemoveClientConnection - Removed address 10.29.54.83:59500
  ```
- **Host Persistence Verification**:
  - Host World remained alive on `UEDPIE_0_Map1.Map1`.
  - GameMode player count decremented cleanly: `gm.get_num_players() == 1`.
  - Host connection did not drop or disconnect.

### Step 2: Host Teardown
- **Action**: Host on `UEDPIE_0_Map1` triggered `LeaveGameSession`.
- **Result**:
  - Listen server tore down cleanly.
  - Host returned to `UEDPIE_0_Boot_Lvl.Boot_Lvl`.

---

## 5. UI Presentation & Navigation Regression

### 1. Home / Host Panel (`Border_0`)
- Explicit section labels implemented and verified:
  - `SERVER NAME`: Displays default text `"Prop Hunt Server"` in `#F4F6FA` with `#141A24` input background.
  - `PLAYER SLOTS`: ComboBoxString populated with `"2 Players"` default option in `#F4F6FA`.
  - `MAP SELECTION`: ComboBoxString locked strictly to `"Map1"` in `#F4F6FA`.
  - `DIRECT IP CONNECTION`: Labeled secondary input with default IP `"10.29.9.102"` and `"DIRECT CONNECT"` button.
- Primary buttons:
  - `CreateServerbutton`: 44px cyan `#27D8E8` button labeled `"HOST GAME"`.
  - `FindingSession`: 44px cyan-bordered `#1B2433` button labeled `"SERVER BROWSER"`.

### 2. Featured Map Card (`Border_MapPreview`)
- Featured Arena: Authentic Map1 scene artwork (`T_Map1_Preview`, 412x180) rendered with 6px rounded corners and `#2A364F` outline.
- Copy: Clean gameplay objectives and rules:
  - `• HIDE & SEEK OBJECTIVE`
  - `• PROPS: BLEND INTO SURROUNDINGS`
  - `• HUNTERS: ELIMINATE ALL DISGUISES`
- All technical developer copy ("LISTEN & ADVANCED SESSIONS", unverified arbitrary round timer figures) completely removed.

### 3. Server Browser Modal (`BorderServer`)
- Header: `"COMMUNITY SERVERS"` title in 20pt Bold Cyan `#27D8E8` on left; `"BACK"` button (`Btn_CloseBrowser`) on right.
- Back Button Logic: `Btn_CloseBrowser.OnClicked` wired to `BorderServer.SetVisibility(Hidden)` and `FindingSession.SetIsEnabled(true)`.
- Column Headings:
  - `Col_ServerName`: `"SERVER NAME"`
  - `Col_Players`: `"PLAYERS"`
  - `Col_Ping`: `"PING"`
  - `Col_Action`: `"ACTION"`
- Empty / Searching State: `TextBlock_1` styled in 14pt `#8A99AD` with copy `"NO SERVERS FOUND • HOST A GAME OR REFRESH"`.

---

## 6. Multi-Resolution Evidence Summary
- 1080p Home/Host: [P011-R1-menu-1080p.png](file:///g:/Unreal%20Projects/SheeshhPropHuntYT/coordination/evidence/P011-R1-menu-1080p.png) (1920x1080)
- 720p Home/Host: [P011-R1-menu-720p.png](file:///g:/Unreal%20Projects/SheeshhPropHuntYT/coordination/evidence/P011-R1-menu-720p.png) (1280x720)
- Ultrawide Home/Host: [P011-R1-menu-ultrawide.png](file:///g:/Unreal%20Projects/SheeshhPropHuntYT/coordination/evidence/P011-R1-menu-ultrawide.png) (2560x1080)
- 1080p Browser Modal: [P011-R1-browser-1080p.png](file:///g:/Unreal%20Projects/SheeshhPropHuntYT/coordination/evidence/P011-R1-browser-1080p.png) (1920x1080)
- 720p Browser Modal: [P011-R1-browser-720p.png](file:///g:/Unreal%20Projects/SheeshhPropHuntYT/coordination/evidence/P011-R1-browser-720p.png) (1280x720)
- Ultrawide Browser Modal: [P011-R1-browser-ultrawide.png](file:///g:/Unreal%20Projects/SheeshhPropHuntYT/coordination/evidence/P011-R1-browser-ultrawide.png) (2560x1080)

---

## 7. SHA256 Integrity Verification
- Baseline Manifest: [P011-R1-baseline-hashes.json](file:///g:/Unreal%20Projects/SheeshhPropHuntYT/coordination/evidence/P011-R1-baseline-hashes.json)
- Final Manifest: [P011-R1-final-hashes.json](file:///g:/Unreal%20Projects/SheeshhPropHuntYT/coordination/evidence/P011-R1-final-hashes.json)
- Modified Assets: Exactly 2 scoped widgets (`WBP_Menu.uasset`, `WBP_Server.uasset`).
- Unmodified Assets: 10 surrounding project assets match 100% bit-for-bit.
