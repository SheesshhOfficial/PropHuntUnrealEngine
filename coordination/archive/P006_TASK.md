# Task P006 - Route hosting and map selection to Map1

Status: APPROVED
Owner: Antigravity
Reviewer: Codex

## Goal
Host Game opens the remaining Map1 as a listen server, and menus cannot select removed Map2/Map3. Preserve all other session/gameplay behavior.

## Read first
- AGENTS.md, PROJECT.md, coordination/REPORT_TEMPLATE.md
- coordination/evidence/P005-R1-host-map-routing-analysis.json
- coordination/archive/P005-R1_REPORT.md

## Scope
1. Capture full status, hashes of source/configuration and core assets, editor identity, dirty packages, and targeted graph/widget properties. Preserve user unsaved work; if an affected asset is already dirty, report a blocker instead of saving it.
2. Create and hash-verify backups of exactly these three assets under a unique coordination/backups/P006-<timestamp>/ directory, preserving relative paths:
   Content/Core/Map/MenuGameinstance.uasset
   Content/Core/Widgets/WBP_Menu.uasset
   Content/Core/Widgets/MainMenu/UI/WBP_MainMenu.uasset
   Export relevant graph/widget state before changes for review. No asset mutations before verified backups.
3. In /Game/Core/Map/MenuGameinstance EventGraph, reidentify K2Node_CallFunction_3 by function and connections before editing. Its OpenLevelBySoftObjectPtr Level pin currently targets /Game/resources/CyberpunkIndustries/Maps/Map3.Map3. Set Level to /Game/resources/Stylized_Egypt/Maps/Map1.Map1. Preserve Options=?listen, bAbsolute, execution connections, session settings, and Boot_Lvl error-return travel.
4. In /Game/Core/Widgets/WBP_Menu, set MapSelection DefaultOptions to Map1 only and ensure its default selected option and existing mapSel initialization cannot retain Map2. Preserve other settings and session flows; verify the actual runtime selection logic before editing any initializer.
5. In /Game/Core/Widgets/MainMenu/UI/WBP_MainMenu, disable the Map2 and Map3 buttons through supported widget properties. Prevent any Construct/runtime bindings from re-enabling them. Keep their layout and labels; do not silently redirect them to Map1. Preserve the Map1 handler. If simple disabling cannot prevent the active click flow, stop that dependent edit and report a narrowly scoped alternative rather than redesigning UI.
6. Use supported Unreal tooling only. Compile all three affected Blueprints, capture errors/warnings, and save only those three scoped assets when compile validation succeeds. No global save. Verify persisted pin/widget values by supported reload/requery when safe, without discarding unsaved packages.
7. Validate static execution: host OnSuccess reaches the Map1 open-level node with listen options; MapSelection has only Map1 and correct initialization; unavailable map buttons remain disabled; Boot_Lvl error-return and Map1 handler are preserved. Inspect targeted graph/UI diffs for unrelated changes. No PIE in this task: actual session creation/travel/join verification is the next milestone.
8. Capture final status/hashes, changed-asset inventory, exact tool results, backups, before/after graph/widget state and compile output under coordination/evidence/P006-*. Confirm source/configuration, music, prop Blueprint, Map1 and relocated packs were not deliberately modified.

## Allowed changes
Only the three named binary assets, coordination/IMPLEMENTATION_REPORT.md, coordination/evidence/P006-*, coordination/backups/P006-*, and normal generated editor logs/caches.

## Do not change
No map deletion/restoration, music edits, prop-array edits, online subsystem/plugin/source/configuration changes, installs, builds, global saves, redirector fixups, cook/packaging, PIE, Git operations, task/history/archive edits, or backup overwrites. Do not terminate editor or discard unrelated unsaved work.

## Error handling
Continue independent safe checks after non-blocking errors. Record exact error/action/attempt/impact. If backup, asset ownership, compile, or supported property editing fails, stop dependent mutation and report remaining work. Preserve backup and current evidence; do not improvise destructive rollback over concurrent edits.

## Acceptance checks
- Verified backups precede edits; only three scoped assets deliberately change.
- Persisted Host Game Level targets Map1 with existing listen/session behavior preserved.
- Persisted map dropdown contains only Map1 and initializes to it; Map2/Map3 buttons cannot be selected through the menu's active flow.
- All three Blueprints compile without errors; warnings documented.
- Evidence includes focused before/after state, persisted requery, status/hashes and unchanged surrounding behavior.
- Runtime multiplayer correctness remains explicitly unverified until next task.

## Required report
Use coordination/REPORT_TEMPLATE.md, Task ID P006; COMPLETE if edits and static checks pass, PARTIAL for incomplete edits/validation, BLOCKED if safe editing cannot start. Stop for Codex review.

