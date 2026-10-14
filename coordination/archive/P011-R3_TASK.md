# Task P011-R3 - Fix disabled rehost and overlapping browser requests

Status: READY
Owner: Antigravity
Reviewer: Codex

## Goal
Finish the current menu correction without moving to HUD. Read AGENTS.md, PROJECT.md, coordination/UI_DESIGN_BRIEF.md, coordination/evidence/P011-R2-CODEX_REVIEW.md and archived P011-R2 task/report. This is the second and final implementation attempt in the authorized two-cycle controller run; final Codex review follows, no third implementation.

## Scope
WBP_Menu.uasset, WBP_Server.uasset under Content/Core/Widgets and the minimal menu-session lifecycle callbacks in Content/Core/Map/MenuGameinstance.uasset. Preserve all existing artwork, map/session flags and names/slots. No HUD, gameplay, maps, settings/config/source/plugins, installs, commits or pushes. Back up/hash before supported Unreal edits and preserve unrelated/unsaved work.

## Required corrections
1. Diagnose why Host remains disabled when Boot_Lvl returns (original log line 22098). Restore a usable idle menu after leave/travel with correct widget ownership/recreation/state reset; do not just broadcast a disabled button or externally force test properties. Bind/unbind failure callbacks safely without persistent stale menu listeners. Pending host prevents duplicates; genuine failure displays actionable error and restores retry. Back during pending must have explicitly safe behavior.
2. Guard browser searches in widget logic before clearing rows/starting OSS search. Disable/re-enable Refresh through real success/failure, reject repeated input without duplicate rows, and ignore late callbacks after Back/reopening. Distinct loading/empty/error/results states; join pending/failure recovery and keyboard focus where supported. OSS Ignoring game search request while one is pending is not an acceptable UI debounce implementation.
3. Retain remaining P011-R2 home/host/player-name navigation obligations. Avoid another cosmetic rebuild merely to produce the same previews. Do not claim all requirements passed based on property flags or graph wiring.

## Validation and honest reporting
Compile/save only affected assets with actual outputs. Verify normal enabled Host -> advertised discovery/Refresh -> returned row Join -> pause Leave -> Host Leave -> enabled normal Host again, then a second discover/join. Ordinary pointer/keyboard actions must be distinguished from delegate broadcasts/direct GI calls. Record button enabled state before rehost without test overrides, players/world/session names and timestamped raw logs.
Use supported native live Slate-inclusive captures and keyboard interaction checks; if tools are unavailable, complete safe independent fixes, document attempts/impact/next step and report PARTIAL. Preview/composite imagery cannot establish runtime input/layering. Real failure testing only where safely reachable; simulated callback diagnostics labeled separately. No fabricated pass, fake session rows or deletion of session state to manufacture outcomes.
Full-path JSON hash manifests cover changed/new assets and verified backups. Stop task-owned sessions, restore editor settings/map safely, and replace coordination/IMPLEMENTATION_REPORT.md with Task ID P011-R3 using REPORT_TEMPLATE.md. COMPLETE only if all carried-forward acceptance checks pass; otherwise PARTIAL/BLOCKED. Do not alter history/task or start another milestone. If dispatched with a completion nonce, write its exact marker after all work/report/cleanup, then stop.
