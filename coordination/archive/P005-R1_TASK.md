# Task P005-R1 - Reconcile repair evidence and inspect host-map routing

Status: APPROVED
Owner: Antigravity
Reviewer: Codex

## Goal
Make P005's repair report accurate and reproducible, and establish the exact host-map change needed after Map2/Map3 removal. No further asset mutation in this correction.

## Read first
AGENTS.md, PROJECT.md, coordination/archive/P005_REPORT.md, all P005 evidence, and coordination/REPORT_TEMPLATE.md.

## Scope
1. Preserve repaired state and verified backups. Record complete current Git status and changed-file inventories, including ignored assets, moved/resaved files, redirectors, and deleted map-directory contents. Compare retained pre-operation evidence where available; state missing evidence rather than reconstruct it.
2. Reconcile removed-map diagnostics: P005-map-diagnostics.json records Map2 6,010 warnings and Map3 2,010 warnings, contradicting the report's zero-warning statements. Report errors, warnings, load success, and removal as separate observations. Retain relevant raw diagnostics if available; qualify unsupported aggregate claims.
3. Cite retained direct-user evidence for the mid-task instruction to remove maps and its clarification. A statement in a report is not independent proof of authorization. If original message/prompt evidence is unavailable, explicitly record that limit; do not delete or restore anything to compensate. Inventory exactly what delete_directory removed beyond Map2/Map3 themselves.
4. Verify backup inventory/hashes against retained pre-mutation hashes where possible; independently compare unchanged external assets to backup. Account for all 1,571 files and external referencers. SC_BackgroundMusic is not in the backup: compare its current hash with the P004 manifest to substantiate preservation. Avoid claiming Git tracking proves unchanged ignored assets.
5. Replace reversal instructions with a scoped recovery plan that verifies absolute workspace paths, protects concurrent edits, and quarantines repaired assets before restoring backup. No wildcard deletion, force overwrites, or actual recovery during this task. Record missing original evidence explicitly.
6. Use supported read-only Unreal queries to inspect MenuGameinstance Host Game map selection and relevant menu defaults. Identify the exact node/property still targeting removed Map3, any other active Map2/Map3 references, and the proposed Map1 destination. Do not alter graphs or saved defaults. Prepare a concrete narrowly scoped P006 host-map repair proposal.
7. Replace coordination/IMPLEMENTATION_REPORT.md using the template. Save evidence under coordination/evidence/P005-R1-*. Existing P005 evidence may receive clearly labeled correction notes; preserve archives and backup bytes.

## Do not change
No assets/configuration/source/plugins, editor session shutdown, saves, builds, PIE, cook, package, installs, Git operations, task/history/archive changes, backup overwrites, or further map deletion/restoration. Preserve music and repaired asset state.

## Acceptance checks
- Report accurately states map load warnings and distinguishes tested results from unavailable evidence.
- User map-removal evidence is cited or explicitly unavailable; entire deleted scope is documented.
- Backup/change inventories and external/music hash evidence support claims or disclose limits.
- Recovery plan protects unrelated/concurrent data and is not executed.
- Host-map routing proposal identifies exact affected graph/property and Map1 target using live evidence.

## Required report
Task ID P005-R1; COMPLETE for all available inspections with explicit evidence limits, PARTIAL for unavailable checks, BLOCKED if inspection cannot proceed. Stop for Codex review. No further repairs until reviewed.

