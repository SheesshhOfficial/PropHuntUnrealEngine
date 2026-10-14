# SheeshhPropHuntYT

## Product
Multiplayer Prop Hunt: props hide as environmental objects while hunters find them during timed rounds. README.md describes the intended systems; its feature claims require runtime verification.

## Technology and layout
- Unreal Engine 5.7, as declared by SheeshhPropHuntYT.uproject.
- Blueprint gameplay/assets in Content/ with a C++ runtime module in Source/SheeshhPropHuntYT/.
- Editor target: SheeshhPropHuntYTEditor (Win64 Development).
- Config/DefaultEngine.ini selects /Game/Core/Map/Boot_Lvl and GM_ProphuntGameMode. The active default online subsystem is Null. Steam subsystem settings are commented out, but the Steam GameNetDriver definition remains active with an IpNetDriver fallback; runtime behavior is unverified.
- Plugins are declared in the project descriptor; verify installed dependencies before claiming the project builds.

## Validation
Locate the actual UE 5.7 installation before using commands. Do not assume its path or install tools automatically.

PowerShell build pattern, once $ueRoot is resolved:
```powershell
& "$ueRoot\Engine\Build\BatchFiles\Build.bat" SheeshhPropHuntYTEditor Win64 Development "-Project=$PWD\SheeshhPropHuntYT.uproject" -WaitMutex
```
Open SheeshhPropHuntYT.uproject in UE 5.7. For gameplay changes, compile affected Blueprints and test the relevant behavior in Play In Editor using a listen server and at least one client. Record mode, player count, observations, and errors. Online session changes require appropriate session tests; a C++ build alone does not prove multiplayer behavior.

## Constraints and evidence
Preserve unrelated local work. Avoid editing generated Binaries/, Intermediate/, Saved/, DerivedDataCache/, and .vs/ as source. Do not bulk resave binary assets or upgrade the engine/plugins without a scoped task. Use supported Unreal tooling for .uasset/.umap changes; never treat binary assets as text.

Separate verified behavior from README claims and assumptions. Report unavailable checks explicitly. Shared coordination files carry the task and report between apps; chats are not shared automatically.

