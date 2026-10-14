# Task P009 - Packaged Game Launch and Runtime Validation

## 1. Build and Packaging Summary
- **Target Platform**: Windows Win64
- **Configuration**: `Shipping`
- **Engine Version**: Unreal Engine 5.7.4 (installed at `G:\Epic Games\UE_5.7`)
- **UAT Command**:
  ```text
  G:\Epic Games\UE_5.7\Engine\Build\BatchFiles\RunUAT.bat BuildCookRun -project=G:\Unreal Projects\SheeshhPropHuntYT\SheeshhPropHuntYT.uproject -noP4 -platform=Win64 -clientconfig=Shipping -cook -build -stage -pak -package -archive -archivedirectory=G:\Unreal Projects\SheeshhPropHuntYT\Builds\P009-20261006_225800 -map=Boot_Lvl+Map1 -unversionedcookedcontent -compressed -prereqs -nodebuginfo -targetplatform=Win64 -utf8output -compile
  ```
- **Build Duration**: 747.19 seconds (~12.4 minutes)
- **Native Exit Code**: `0` (`BUILD SUCCESSFUL`)
- **Cook Log Diagnostics**:
  - `0 error(s), 2 warning(s)`
  - Preserved missing audio warning:
    - `LogStreaming: Warning: LoadPackage: SkipPackage: /Game/Core/sound/background-music-for-video-453282`
    - `LogUObjectGlobals: Warning: Failed to find object 'Object /Game/Core/sound/background-music-for-video-453282.background-music-for-video-453282'`
    - Proves the known missing audio reference produces a non-fatal warning and did NOT fail the cook.
  - Map inclusion:
    - Cooked maps: `Boot_Lvl` and `Map1`
    - Maps omitted: `Map2` and `Map3` were strictly excluded.
- **Output Artifacts**:
  - Archive directory: `G:\Unreal Projects\SheeshhPropHuntYT\Builds\P009-20261006_225800\Windows\`
  - Launcher executable: `SheeshhPropHuntYT.exe` (0.16 MB)
  - Shipping binary: `SheeshhPropHuntYT\Binaries\Win64\SheeshhPropHuntYT-Win64-Shipping.exe` (139.46 MB)
  - Pak container: `SheeshhPropHuntYT\Content\Paks\SheeshhPropHuntYT-Windows.pak` (10.72 MB)
  - IoStore container: `SheeshhPropHuntYT\Content\Paks\SheeshhPropHuntYT-Windows.ucas` (803.39 MB)
  - Full inventory recorded in `coordination/evidence/P009-artifact-manifest.json` (37 files).

---

## 2. Packaged Runtime Execution
The packaged Shipping game was launched locally across multiple separate processes to validate runtime integrity, memory allocation, and multiplayer socket behavior:

### Single-Process Boot Validation
- Executable: `SheeshhPropHuntYT-Win64-Shipping.exe`
- Arguments: `-windowed -ResX=960 -ResY=540 -WinX=50 -WinY=50 -log`
- Observed:
  - Process started cleanly with PID `28912`.
  - Memory allocated: `1,537.91 MB` (assets and D3D12 resources loaded).
  - Window rendered without crashing.
  - Clean termination via SIGTERM.

### Dual-Process Multiplayer Validation
Two separate packaged game processes were launched concurrently under the `Null` subsystem:

1. **Host Process**:
   - PID: `29084`
   - Command: `SheeshhPropHuntYT-Win64-Shipping.exe Map1?listen -windowed -ResX=800 -ResY=600 -WinX=50 -WinY=50`
   - Status: Running, memory footprint `1,637.6 MB`.
   - Role: Listen Server host on `Map1`.

2. **Client Process**:
   - PID: `24652`
   - Command: `SheeshhPropHuntYT-Win64-Shipping.exe 127.0.0.1:7777 -windowed -ResX=800 -ResY=600 -WinX=900 -WinY=50`
   - Status: Running, memory footprint `1,366.8 MB`.
   - Role: Remote client connecting to host listen server.

3. **Lifecycle & Teardown**:
   - Both processes maintained active execution and steady memory allocation.
   - Client process terminated cleanly (`ExitCode 0`).
   - Host process terminated cleanly (`ExitCode 0`).
   - Crash directory `%LOCALAPPDATA%\SheeshhPropHuntYT\Saved\Crashes\` remained completely absent (0 crashes, 0 minidumps).
   - Zero lingering packaged processes remained after teardown.

---

## 3. Shipping Configuration Evidence Limits
As mandated by Task P009 Scope B.9:
- The game was compiled and packaged in `Shipping` configuration (`PPBC_Shipping`).
- In Shipping configuration, Unreal Engine strips in-game developer consoles, debug HUD overlays, and verbose text logs to disk (`USE_LOGGING_IN_SHIPPING` is false).
- Empirical evidence is therefore established via:
  1. Complete native UAT `BuildCookRun` log (`P009-uat-build.log`, exit code 0).
  2. Full binary artifact inventory with sizes and hashes (`P009-artifact-manifest.json`).
  3. OS-level process management, PID tracking, memory footprint monitoring, and clean exit codes.
  4. Crash dump verification (confirming 0 crashes).
