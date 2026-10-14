# Task P005 - Restore asset-pack paths and validate references

Status: READY
Owner: Antigravity
Reviewer: Codex

## Goal
Repair the missing mesh/map paths by relocating the two asset packs to the package locations already referenced by the project, using supported Unreal tooling and verified backups. Do not change the music.

## Read first
- AGENTS.md, PROJECT.md, coordination/REPORT_TEMPLATE.md
- coordination/archive/P004-R1_REPORT.md
- coordination/evidence/P004-R1-repair-plan.md (including Codex qualifications)
- coordination/evidence/P004-missing-packages-audit.json

## Scope and execution
1. Capture full starting Git status, resolved absolute source/destination paths, editor project/session identity, dirty-package list, and complete inventories/hashes of both packs and all known external referencers. Inspect full pack dependencies, including materials/textures, before selecting relocation operations.
2. Sources:
   Content/resources/NonGitLFS/CyberpunkIndustries/
   Content/resources/NonGitLFS/Downtown_West/
   Destinations:
   Content/resources/CyberpunkIndustries/
   Content/resources/Downtown_West/
   Verify all resolved paths remain inside this project and destinations have no collisions. Do not merge/overwrite a destination or remove the NonGitLFS parent.
3. Back up complete source packs and affected external referencers to a unique project-local coordination/backups/P005-<timestamp>/ directory. Preserve directory layout and verify every copied file against its source hash. Check free disk space first. Keep backup outside Content; do not rely on Git, since binary assets are ignored. Record a precise reversal procedure and do not mutate assets until backup verification succeeds.
4. Use supported Unreal Content Browser or asset relocation APIs to move assets to the original package destinations. Inspect operation semantics first. Retain any generated redirectors; no global redirector fixup. Only scoped moved assets/necessary redirectors may be saved. Do not auto-save unrelated packages or BP_propChar while it contains failed-load null defaults. External referencer resaves are outside this task: if a tooling operation requires them, report the blocker instead of expanding scope. An editor move may restore old-path resolution after a fresh reload, but this must be verified.
5. Preserve unsaved work. If unrelated dirty assets prevent safe relocation/restart, report the blocker; do not save, discard, or terminate them. A clean exact-project editor shutdown and restart is authorized after verifying no unsaved work will be lost. Do not force-kill. Do not substitute raw filesystem moves or byte edits for supported Unreal operations.
6. In a fresh UE 5.7 session, verify all 36 mapped mesh packages and both configured map paths resolve at their original destinations. Requery all 55 BP_propChar.PropAllowedMesh entries; validate recovered entries using actual object paths, not just null counts. The expected remaining nulls are indices 37..39, but their authored intent is unknown. Do not fill or delete them by guessing. Compile BP_propChar and GM_ProphuntGameMode in memory without saving their defaults.
7. Load Map2 and Map3 one at a time only when the editor map has no unsaved work. Capture dependency/load diagnostics for meshes, materials, textures, and other packages; compile/map-check results are separate from gameplay success. Preserve the missing audio warning as unresolved context. No cook or PIE in this milestone.
8. Capture final status, inventories/hashes, relocation tool results, verified backup paths, per-package resolution, array enumeration, and fresh-session logs under coordination/evidence/P005-*. Report partial repairs or blockers accurately. If validation fails, stop and document reversible recovery from the verified backup; do not improvise destructive cleanup or overwrite concurrent work.

## Allowed changes
- Supported relocation/resaves of assets within these two packs and generated source redirectors
- coordination/IMPLEMENTATION_REPORT.md, coordination/evidence/P005-* and coordination/backups/P005-*
- Normal generated editor logs/caches

## Do not change
No music edits, external referencer saves, prop-array reconstruction, configuration/source/plugin edits, installs, engine upgrades, Git changes, bulk/global resaves or redirector fixups, cook/packaging, PIE, or task/history/archive edits. Do not delete backups or unrelated files.

## Error handling
Proceed with independent verification after non-blocking errors. Stop dependent mutations if backups, collision checks, unsaved-work checks, or supported relocation semantics fail. Save exact errors, actions, attempts, effects, and next steps. BLOCKED is preferable to bypassing these concrete preconditions.

## Acceptance checks
- Verified complete backups precede every mutation; operation results and changed-file inventory are retained.
- Supported relocation performed without unrelated package saves or data loss.
- All 36 mesh packages and two configured map paths resolve after fresh reload; actual recovered prop-array paths are recorded.
- BP_propChar and game mode compile in memory; both moved maps have actual load/dependency findings.
- Any additional missing dependencies or remaining nulls are explicit, without claiming full project/gameplay correctness.
- Music, source/configuration, and external referencer disk files remain unchanged; hashes substantiate this.

## Required report
Use coordination/REPORT_TEMPLATE.md; Task ID P005. COMPLETE only if relocation and required validation pass, PARTIAL for executed repair with outstanding checks/failures, BLOCKED when safe execution cannot start. Stop for Codex review. Do not begin the next milestone.
