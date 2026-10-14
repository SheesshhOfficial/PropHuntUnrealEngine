# Task P003 - Inspect core Blueprint and map assets

Status: APPROVED
Owner: Antigravity
Reviewer: Codex

## Goal
Use supported Unreal tooling to determine whether core gameplay Blueprints and configured maps can be resolved and validated. Gather evidence before proposing fixes.

## Read first
- AGENTS.md, PROJECT.md, coordination/REPORT_TEMPLATE.md
- coordination/archive/P002_REPORT.md
- SheeshhPropHuntYT.uproject
- Config/DefaultEngine.ini and Config/DefaultGame.ini

## Scope
1. Capture full initial/final git status and hashes of relevant source/configuration/plugin inputs and any inspected .uasset/.umap files. Store P003 evidence under coordination/evidence/. Compare before/after and preserve unrelated work.
2. Inspect existing Unreal Editor sessions and available supported Unreal tooling. Prefer an existing session for this exact project. If none exists, launching this project in the installed UE 5.7 editor is allowed. Do not terminate sessions, discard unsaved work, install tooling, or operate another project. Record engine version and inspection method.
3. Query the asset registry and load/validate these exact assets when supported:
- /Game/Core/BluePrints/GM_ProphuntGameMode
- /Game/Core/BluePrints/BP_propChar
- /Game/Core/BluePrints/BP_ThirdPersonCharacter
- /Game/Core/BluePrints/BP_ThirdPersonPlayerController
- /Game/Core/Map/MenuGameinstance
- /Game/Core/Widgets/UW_MainHUD
- /Game/Core/Widgets/WBP_Menu
- /Game/Core/Widgets/MainMenu/UI/WBP_MainMenu
Validate Blueprint compilation in memory only, using supported editor operations. Record each asset's observed result and diagnostic messages. Do not save/resave, edit graphs, or claim successful compilation from existence alone. If tooling cannot safely compile without saving or cannot expose diagnostics, mark that check unavailable and continue independent registry inspection.
4. Inspect /Game/Core/Map/Boot_Lvl and all four MapsToCook entries. Establish registry resolution, asset class, redirector destination if applicable, and disk path. Distinguish registry/path verification from actual map loading. Loading Boot_Lvl is allowed only if it does not replace an unsaved current map. Do not run gameplay, cook, packaging, or bulk loads. For Map2/Map3, also query their /Game/resources/NonGitLFS/ paths; report the mismatch and observed registry/redirector evidence without changing paths or moving assets.
5. Capture relevant load/compile diagnostics with timestamps, excerpts, and full available logs or structured tool outputs. Avoid dumping unrelated logs. Propose narrow follow-up fixes based only on observed evidence; retain P002 warnings as unresolved context.

## Allowed changes
- coordination/IMPLEMENTATION_REPORT.md
- coordination/evidence/P003-* evidence files
- Normal editor-generated cache/log files, without manually editing them
- Transient in-memory validation state; no asset saves

## Do not change
No asset/source/configuration/plugin edits, redirector fixups, ResavePackages, bulk resaves, installs, engine upgrades, build reruns, commits/pushes/resets, or task/history changes. Do not change packaging or online subsystem settings. Do not start PIE or multiplayer testing. Preserve unsaved editor work and unrelated files.

## Error handling
Continue safe independent checks after a missing asset or failed compile. Record tool/action, error, attempts, impact, and next action. Stop dependent work if tooling or unsaved editor state blocks it. Missing access is not a successful asset validation.

## Acceptance checks
- Each listed Blueprint has a verified registry/load/compile result, or an explicit unavailable/failed check with evidence.
- Boot_Lvl and every configured cook-map entry have registry/path findings; redirectors and actual load results are distinguished from assumptions.
- Logs/structured results support all claims; no cook, packaging, or gameplay correctness inferred.
- Status/hash comparison records any changed inspected inputs; do not revert concurrent changes.
- No deliberate source/configuration/asset saves; no speculative fixes.

## Required report
Use coordination/REPORT_TEMPLATE.md, identify P003, and list per-asset results. COMPLETE means all scoped inspections ran; observed asset failures must still be reported and do not imply project health. Use PARTIAL for unavailable checks, BLOCKED when no meaningful Unreal inspection can start. Stop for Codex review.

