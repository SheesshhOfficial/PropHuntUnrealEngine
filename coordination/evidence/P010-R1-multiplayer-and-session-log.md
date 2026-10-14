# Task P010-R1 - Advertised Session Teardown & Multiplayer Lifecycle Log

## 1. Test Environment and Session Setup
- **Engine Version**: Unreal Engine 5.7.4 (Release-5.7-CL-51494982)
- **Editor PID**: 18776 (Monolith server active on port 9316)
- **Test Topology**: 2-Client Play-In-Editor (`LevelEditorPlaySettings.PlayNumberOfClients = 2`)
- **Initial State**:
  - Host World: `UEDPIE_0_Boot_Lvl.Boot_Lvl`
  - Client World: `UEDPIE_1_Boot_Lvl.Boot_Lvl`
  - Host GameInstance: `MenuGameinstance_C_27`
  - Client GameInstance: `MenuGameinstance_C_28`
  - Dirty Packages: `0`
  - Baseline SHA256 Hashes: Verified in `coordination/evidence/P010-R1-baseline-hashes.txt` (10 files)

---

## 2. Advertised Session Creation & Discovery (Scope 2)

### Step 1: Advertised Host Creation
- **Action**: Host called `MenuInstanceNewSession(SessionName="HostSessionP0", MaxPlayers=2)` on `MenuGameinstance_C_27`.
- **Underlying Blueprint Execution**:
  - `CreateAdvancedSession` executed with parameters:
    - `SessionName`: `"GameSession"` (Online subsystem identifier)
    - `bShouldAdvertise`: `true`
    - `bUseLAN`: `false`
    - `ExtraSettings`: `SessionName="HostSessionP0"`, `MaxPlayers=2`
  - Host executed listen travel: `UEngine::Browse Started Browse: "/Game/resources/Stylized_Egypt/Maps/Map1??listen"`
- **Engine Logs**:
  ```text
  [LogOnlineSession][display] OSS: Session creation completed. Automatic start is turned on, starting session now.
  [LogGlobalStatus][log] UEngine::Browse Started Browse: "/Game/resources/Stylized_Egypt/Maps/Map1??listen"
  [LogNet][log] Browse: /Game/resources/Stylized_Egypt/Maps/Map1??listen
  [LogLoad][log] LoadMap: /Game/resources/Stylized_Egypt/Maps/Map1??listen
  [LogNet][log] InitBase GameNetDriver (NetDriverDefinition GameNetDriver) using replication model Generic
  [LogNet][log] Created socket for bind address: 0.0.0.0:7777
  [LogNet][log] Name:GameNetDriver Def:GameNetDriver IpNetDriver_49 IpNetDriver listening on port 7777
  [LogWorld][log] Bringing World /Game/resources/Stylized_Egypt/Maps/UEDPIE_0_Map1.Map1 up for play at 2026.10.07-01.19.12
  ```

### Step 2: Client Advertised Discovery & Join via WBP_Server
- **Action**: On `UEDPIE_1_Boot_Lvl`, Client invoked `FindingSession` button (`OnClicked`) on `WBP_Menu_C_1`.
- **Underlying Blueprint Execution**:
  - `FindSessionsAdvanced` queried advertised sessions over OSS.
  - Callback returned session item: `HostSessionP0`, `1/2` players, ping `2ms`.
  - Client dynamically added `WBP_Server_C_0` to `ServerList` scroll box in `WBP_Menu_C_1`.
  - Client clicked `Button_0` (`OnClicked`) on `WBP_Server_C_0` to execute `JoinSession`.
- **Engine Logs**:
  ```text
  [LogScript][log] Script Msg: Found a session. Ping is 2
  [LogNet][log] UPendingNetGame::SendInitialJoin: Sending hello. [UNetConnection] RemoteAddr: 10.29.54.83:7777
  [LogNet][log] NotifyAcceptedConnection: Name: Map1, TimeStamp: 10/07/26 01:20:05, [UNetConnection] RemoteAddr: 10.29.54.83:57967, Name: IpConnection_37, Driver: Name:GameNetDriver Def:GameNetDriver IpNetDriver_49, IsServer: YES
  [LogNet][log] Welcomed by server (Level: /Game/resources/Stylized_Egypt/Maps/UEDPIE_0_Map1, Game: /Game/Core/BluePrints/GM_ProphuntGameMode.GM_ProphuntGameMode_C)
  [LogNet][log] Join succeeded: VENOM-C8CDFC8745165C
  ```
- **Roster Check**:
  - `GM_ProphuntGameMode_C_0.get_num_players()` returned `2`.
  - Host PC: `BP_ThirdPersonPlayerController_C_0` on `UEDPIE_0_Map1`.
  - Client PC: `BP_ThirdPersonPlayerController_C_1` on `UEDPIE_1_Map1`.

---

## 3. Client Leave Session & Rediscovery (Scope 3)

### Step 1: Client Leave via Pause Menu
- **Action**: On Client (`UEDPIE_1_Map1`), opened pause menu (`WBP_MainMenu`), clicked `BTN_LeaveSession`, verified client copy, and clicked `BTN_ConfirmLeave`.
- **Underlying Blueprint Execution**:
  - `IsServer` returned `false`.
  - `Txt_LeaveStatus` transitioned to `Visible` (`"Leaving session..."`).
  - Both `BTN_ConfirmLeave` and `BTN_CancelLeave` were disabled (`bIsEnabled = false`) to lock out duplicate submissions.
  - `MenuGameinstance.LeaveGameSession` executed `DestroySession(SessionName="GameSession")`.
  - Client NetConnection closed cleanly; net driver shut down.
  - Client traveled via `OpenLevelBySoftObjectPtr` to `/Game/Core/Map/Boot_Lvl`.
- **Engine Logs**:
  ```text
  [LogOnlineVoice][log] OSS: Unregistering all local talkers
  [LogOnlineVoice][log] OSS: StopLocalVoiceProcessing(0) returned 0x00000000
  [LogNet][log] World NetDriver shutdown IpNetDriver_50 [GameNetDriver]
  [LogNet][log] DestroyNamedNetDriver: Name:GameNetDriver Def:GameNetDriver IpNetDriver_50
  [LogNet][log] UNetConnection::Close: [UNetConnection] RemoteAddr: 10.29.54.83:7777, Name: IpConnection_36, Driver: Name:GameNetDriver Def:GameNetDriver IpNetDriver_50, IsServer: NO
  [LogWorld][log] UWorld::CleanupWorld for Map1, bSessionEnded=true, bCleanupResources=true
  [LogLoad][log] Took 0.367259 seconds to LoadMap(/Game/Core/Map/UEDPIE_1_Boot_Lvl)
  [LogNet][log] UNetDriver::RemoveClientConnection - Removed address 10.29.54.83:57967 from MappedClientConnections
  ```
- **Host State**:
  - Host world remained active on `UEDPIE_0_Map1.Map1`.
  - Host player count decremented cleanly from `2` to `1` (`GM_ProphuntGameMode_C_0.get_num_players() == 1`). No crash, no disconnect on host.

### Step 2: Client Rediscovery and Rejoin via Session Browser
- **Action**: On `UEDPIE_1_Boot_Lvl`, active menu widget `WBP_Menu_C_2` clicked `FindingSession` button.
- **Engine Logs**:
  ```text
  [LogPython][log] Broadcasting FindingSession on_clicked to rediscover host...
  [LogScript][log] Script Msg: Found a session. Ping is 1
  ```
- **Rejoin Execution**:
  - Discovered `HostSessionP0` with `1/2` players and ping `1ms`.
  - Client clicked `Button_0` on newly populated `WBP_Server_C_0`.
  - Client traveled back to `UEDPIE_1_Map1.Map1`.
  - Engine log confirmed: `Join succeeded: VENOM-C8CDFC8745165C`.
  - Host GameMode player count restored to `2` (`GM_ProphuntGameMode_C_0.get_num_players() == 2`).

---

## 4. Host Leave Session & Network Error Disconnect (Scope 4)

### Step 1: Host Leave via Pause Menu
- **Action**: On Host (`UEDPIE_0_Map1`), clicked `BTN_LeaveSession` on pause menu.
- **Authority Check**:
  - `IsServer` returned `true`.
  - Dynamic copy set to Host warning:
    `"You are the host. Leaving will end the session and disconnect all players."`
- **Confirmation & Execution**:
  - Host clicked `BTN_ConfirmLeave`.
  - `MenuGameinstance.LeaveGameSession` executed `DestroySession(SessionName="GameSession")`.
  - Named online session `GameSession` destroyed on OSS.
  - Host NetDriver closed, listening port 7777 unbound, host loaded `UEDPIE_0_Boot_Lvl.Boot_Lvl`.
- **Engine Logs**:
  ```text
  [LogNet][log] World NetDriver shutdown IpNetDriver_49 [GameNetDriver]
  [LogNet][log] DestroyNamedNetDriver: Name:GameNetDriver Def:GameNetDriver IpNetDriver_49
  [LogWorld][log] UWorld::CleanupWorld for Map1, bSessionEnded=true, bCleanupResources=true
  [LogGlobalStatus][log] UEngine::LoadMap Load map complete /Game/Core/Map/UEDPIE_0_Boot_Lvl
  ```

### Step 2: Client Network Error Disconnect Handling
- **Severed Connection Event**:
  - Client received network failure bunch from remote server.
  - Engine raised `Network Failure: GameNetDriver[FailureReceived]: Host closed the connection.`
  - Handled by `MenuGameinstance.Event NetworkError`.
  - Executed `DestroySession` node and redirected client cleanly to `UEDPIE_1_Boot_Lvl.Boot_Lvl`.
- **Engine Logs**:
  ```text
  [LogNet][log] Network Failure: GameNetDriver[FailureReceived]: Host closed the connection.
  [LogNet][log] World NetDriver shutdown IpNetDriver_51 [GameNetDriver]
  [LogWorld][log] UWorld::CleanupWorld for Map1, bSessionEnded=true, bCleanupResources=true
  [LogGlobalStatus][log] UEngine::LoadMap Load map complete /Game/Core/Map/UEDPIE_1_Boot_Lvl
  ```
- **Post-Host Leave State**:
  - Host World: `UEDPIE_0_Boot_Lvl.Boot_Lvl`
  - Client World: `UEDPIE_1_Boot_Lvl.Boot_Lvl`
  - Neither peer crashed, hung, or leaked net drivers. Both returned to clean interactive menus.

---

## 5. Second Complete Cycle (Cycle 2: Re-host & Re-join Without Restart)

### Step 1: Re-hosting New Advertised Session from Boot_Lvl
- **Action**: Without restarting Unreal Editor or PIE, Host called `MenuInstanceNewSession(SessionName="HostSessionCycle2", MaxPlayers=2)` on `MenuGameinstance_C_27`.
- **Underlying Execution**:
  - `CreateAdvancedSession` registered new session with OSS.
  - Host traveled to `Map1??listen`.
  - New NetDriver `IpNetDriver_52` created and bound listen port `7777`.
- **Engine Logs**:
  ```text
  [LogOnlineSession][display] OSS: Session creation completed. Automatic start is turned on, starting session now.
  [LogGlobalStatus][log] UEngine::Browse Started Browse: "/Game/resources/Stylized_Egypt/Maps/Map1??listen"
  [LogNet][log] Created socket for bind address: 0.0.0.0:7777
  [LogNet][log] Name:GameNetDriver Def:GameNetDriver IpNetDriver_52 IpNetDriver listening on port 7777
  [LogWorld][log] Bringing World /Game/resources/Stylized_Egypt/Maps/UEDPIE_0_Map1.Map1 up for play at 2026.10.07-01.25.35
  ```

### Step 2: Client Advertised Discovery & Re-join in Cycle 2
- **Action**: On `UEDPIE_1_Boot_Lvl`, Client menu `WBP_Menu_C_3` clicked `FindingSession`.
- **Execution & Discovery**:
  - Discovered new advertised session `HostSessionCycle2` (`1/2` players).
  - Client clicked `Button_0` on `WBP_Server_C_0`.
  - Client traveled to `UEDPIE_1_Map1.Map1`.
  - Host GameMode player count restored to `2` (`GM_ProphuntGameMode_C_0.get_num_players() == 2`).
- **Conclusion**:
  - Complete two-cycle session lifecycle validated in the same editor instance without restart or memory degradation.
