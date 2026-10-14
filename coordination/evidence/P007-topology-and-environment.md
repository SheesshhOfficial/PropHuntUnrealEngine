# Task P007 - Test Topology and Environment

- **Date / Timestamp**: 2026-10-06T20:12:00+05:30
- **Engine Version**: Unreal Engine 5.7.4 (`++UE5+Release-5.7-CL-51494982`)
- **Process ID**: 18776 (`UnrealEditor.exe`)
- **Monolith MCP Port**: 9316 (Version 0.23.0)
- **Editor Startup / Parked Map**: `/Game/Core/Map/Boot_Lvl.Boot_Lvl`
- **Target Map**: `/Game/resources/Stylized_Egypt/Maps/Map1.umap`
- **OnlineSubsystem Configuration**:
  - `DefaultPlatformService`: `Null`
  - `bHasVoiceEnabled`: `true`
  - Source: `Config/DefaultEngine.ini`

## PIE Process Model and Test Topology
- **PIE Process Model**: Single Process (`RunUnderOneProcess=True`)
- **Transient Test Preference**: `PlayNumberOfClients` transiently set from `1` to `2` during multiplayer testing, and restored to `1` upon test conclusion.
- **Game Instances**:
  - **Instance 0 (Host / Server)**:
    - GameInstance: `MenuGameinstance_C` (`/Engine/Transient.UnrealEdEngine_0:MenuGameinstance_C_5`)
    - Initial World: `UEDPIE_0_Boot_Lvl` -> Travel World: `UEDPIE_0_Map1`
    - NetMode: `NM_ListenServer`
    - Server Listen Port: `7777` (`IpNetDriver_10`)
    - PlayerController: `BP_ThirdPersonPlayerController_C_0` (LocalRole: `ROLE_AUTHORITY: 3`, RemoteRole: `ROLE_SIMULATED_PROXY: 1`)
    - GameMode: `GM_ProphuntGameMode_C_0`
  - **Instance 1 (Client)**:
    - GameInstance: `MenuGameinstance_C` (`/Engine/Transient.UnrealEdEngine_0:MenuGameinstance_C_6`)
    - Initial World: `UEDPIE_1_Boot_Lvl` -> Travel World: `UEDPIE_1_Map1`
    - NetMode: `NM_Client`
    - Client Driver: `PendingNetDriver` -> `GameNetDriver` (`IpNetDriver_11`)
    - PlayerController: `BP_ThirdPersonPlayerController_C_0` (LocalRole: `ROLE_AUTONOMOUS_PROXY: 2`, RemoteRole: `ROLE_AUTHORITY: 3`)
    - GameMode: `None` (server-only object correctly absent on client)

## Tooling Used
- Monolith MCP: `start_pie`, `stop_pie`, `run_pie_smoke`, `poll_pie_smoke`, `list_dirty_packages`, `get_recent_logs`, `ui_query`, `blueprint_query`.
- Unreal Python API: `unreal` module for runtime object inspection, delegate invocation (`broadcast`), and network role observation.
- PowerShell / Git CLI for hashing and working-tree verification.
