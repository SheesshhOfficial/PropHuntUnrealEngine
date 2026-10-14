# Task P009 - Session cleanup and packaged-game validation

Status: REVIEWED_PARTIAL
Owner: Antigravity
Reviewer: Codex

## Goal
Validate leaving/rehosting sessions and the packaged Windows game with Boot_Lvl and Map1. Round lifecycle is accepted from the user's own testing; do not schedule more lifecycle tests or restore Map2/Map3.

## Read first
AGENTS.md, PROJECT.md, coordination/REPORT_TEMPLATE.md, coordination/archive/P008_REPORT.md, P007 session evidence, Config/DefaultGame.ini and Config/DefaultEngine.ini.

## User direction
Round lifecycle works according to the user (2026-10-06). Combine session cleanup and packaged-game checks in P009. Next phase is a comprehensive UI/widget redesign; then more transformable Map1 props, music, and online/voice/performance work. Map2/Map3 will be added only if the user requests it in the future.

## Scope A - Session cleanup
1. Capture project identity, full status, relevant input hashes, editor dirty packages, existing sessions/processes and transient settings. Preserve user work. Reuse normal local host/discovery/join flow; record subsystem, network roles and exact reproduction steps.
2. With host and one client on Map1, use the client's ordinary leave/return-to-menu action. Check client returns to Boot_Lvl, widgets/input focus are usable, connection/session state clears and host remains playable. Rejoin through discovery; check player/session counts and absence of duplicate HUD/menu widgets.
3. Use host's normal leave action while client is connected. Record client disconnect/error/menu handling and remaining session state. Confirm both can host/discover/join a new session after teardown without restarting the application. One bounded repeat is sufficient. Do not force lifecycle health/timers, restore maps, or use DestroySession directly as proof of the menu action.
4. If normal action/tooling is unavailable, label the check skipped; diagnostics must not be presented as normal-flow success. Capture relevant raw logs, world/session/player/widget observations and cleanup. Stop only task-created sessions; restore transient preferences.

## Scope B - Package and launch
5. Verify installed UE 5.7 toolchain/SDK, supported Windows target, disk space and plugin packaging availability. Use G:/Epic Games/UE_5.7/Engine/Build/BatchFiles/RunUAT.bat. Do not install dependencies or upgrade tools.
6. Create a unique output directory under project-local Builds/P009-<timestamp>/; check resolved path before writing and do not overwrite/delete existing builds. Run the normal Windows Win64 BuildCookRun build/cook/stage/package/archive for this project using its configured Shipping configuration, Boot_Lvl and Map1. Keep exact command, native exit code, start/end timestamps, complete UAT log, selected compiler/SDK and produced artifacts under coordination/evidence/P009-*. Use command-line overrides instead of editing packaging config. Do not bypass failures by dropping required content/plugins or changing online settings.
7. Inspect packaging errors/warnings and map inclusion. The known missing audio is preserved: record whether it causes a cook failure/warning; do not remove it silently. Map2/Map3 must not be explicitly included. Capture artifact manifest/path and executable existence; exit code zero alone is not runtime validation.
8. Launch the packaged game locally, verify Boot_Lvl/menu startup and actual host-to-Map1 travel. Launch a second separate process and exercise discovery/join under the current Null subsystem, then repeat client leave/rejoin and host leave/new host as practical. No public servers or external-account access. Record process topology, visual observations, input method, connection/travel evidence and runtime errors. Do not claim packaged UI tests from editor PIE results or treat direct open commands as session-flow proof.
9. Shipping may restrict logs or automation: explicitly state evidence limits. If Shipping package succeeds but runtime inspection is impossible, a separate Development package is allowed as a clearly labeled diagnostic only; it does not establish Shipping runtime behavior. Build it only when needed, in a separate unique directory. No speculative rebuild loops.
10. Stop task-owned packaged processes cleanly; do not force-close user applications. Preserve build artifacts/evidence and editor unsaved work. Capture final status/input-hash comparison and all retained output locations.

## Failure handling and boundaries
This is validation, not repair. When a check fails, preserve evidence, classify it (tool availability, cook/build, launch, cleanup/session logic), finish independent safe work and propose one narrow follow-up. Do not modify assets/source/config/plugin inputs to fix it within P009. If dirty editor work blocks a build or launch, record that blocker instead of discarding work. Long packaging may take time: allow completion, retain logs, and avoid duplicate runs or rapid polling.

## Allowed changes
coordination/IMPLEMENTATION_REPORT.md, coordination/evidence/P009-*, unique Builds/P009-* outputs, normal generated build/editor/game logs/caches, and restored transient test preferences. No saved product edits.

## Do not change
No round-lifecycle retesting, UI redesign, music edits, prop tagging, map restoration, installs, engine changes, global asset saves, plugin/online config changes, Git operations, task/history/archive edits, or deletion of existing builds/backups. Never simulate success by forcing runtime session/player state.

## Acceptance checks
- Client leave/rejoin, host departure, new hosting and discovery/join tested with normal actions, or exact failure/unavailability documented.
- No duplicate/stale session/widget/player state claims without observed evidence.
- Windows Shipping build/cook/stage/package results substantiated by command/full log/native exit and artifact inventory.
- Packaged Boot_Lvl startup, Map1 hosting and separate-process joining tested; packaged cleanup tested or explicitly unavailable.
- Shipping results distinguished from any Development diagnostic/PIE results.
- Inputs unchanged, transient settings restored, task-owned sessions/processes cleaned up, and artifacts retained.

## Required report
Use coordination/REPORT_TEMPLATE.md; Task ID P009. COMPLETE only when cleanup and Shipping packaging/runtime checks pass; PARTIAL when failures/unavailable checks remain with completed diagnostics; BLOCKED when neither safe cleanup nor packaging testing can start. Include concise result matrix, exact repros, raw evidence and next required repair. Stop for Codex review. Do not begin UI redesign automatically.

