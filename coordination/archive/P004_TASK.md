# Task P004 - Plan missing-reference repairs

Status: READY
Owner: Antigravity
Reviewer: Codex

## Goal
Produce a concrete, evidence-backed repair proposal for P003's missing asset references without changing assets or configuration.

## Read first
- AGENTS.md and PROJECT.md
- coordination/archive/P003_REPORT.md
- coordination/evidence/P003-load-diagnostics.log
- Config/DefaultGame.ini

## Scope
1. Capture starting/final full git status and hashes of inspected inputs/assets. Preserve editor unsaved work and existing evidence. Use the existing exact-project editor session and supported read-only Unreal queries.
2. Deduplicate missing package references in P003 diagnostics. For each missing mesh package, query the original path and proposed NonGitLFS counterpart in the asset registry. Record existence, asset class, redirector state, and relevant referencers. Do not claim identity from matching filename alone; identify uncertainty.
3. Inspect BP_propChar's relevant variable/default/component references read-only to establish affected properties and whether failed loads have produced null in-memory values. Do not save or compile/resave it as a repair. Do not dump entire graphs unnecessarily.
4. Inspect SC_BackgroundMusic's missing audio reference. Search targeted local project paths for a recoverable audio candidate or exact original asset, without downloads, Git checkout, or substituting an unrelated sound. If none is found, state the user choice required between supplying/restoring the intended audio and intentionally removing the cue reference.
5. Compare repair options: restoring original asset locations using supported Unreal operations versus retaining NonGitLFS paths and updating references/cook settings. Account for referencers inside the moved packs, Git ignore intent, unsaved editor state, touched-file count, reversibility, and validation. Recommend the narrowest supported option with exact proposed assets/config entries, required backup strategy, and checks. Flag decisions that require user preference; do not execute any option.
6. Save a missing-reference mapping and concise repair plan under coordination/evidence/P004-*. Replace coordination/IMPLEMENTATION_REPORT.md with evidence and a proposed next implementation milestone.

## Do not change
No assets, source, plugin inputs, configuration, task/history, or archived evidence edits. No moves/copies of asset packs, saves, redirector fixups, ResavePackages, installs, builds, cook/packaging, PIE, commits/pushes/resets, downloads, or termination of editor processes. Generated logs/cache are permitted; input assets must remain unchanged.

## Error handling
Continue independent read-only checks after failures. Record tool, error, attempts, impact, and next action. Report unavailable inspection clearly; do not invent mappings or recover missing in-memory defaults by guessing.

## Acceptance checks
- Deduplicated missing-package mapping distinguishes confirmed candidates from assumptions and unresolved references.
- Referencer/property evidence supports the proposed scope; uninspected dependencies are explicit.
- Audio recovery availability and any required user preference are explicit.
- Concrete recommendation includes exact proposed changes, backup/reversal approach, and editor/load/compile validation before gameplay testing.
- Hash/status comparisons disclose changes; no deliberate asset/configuration modifications.

## Required report
Use coordination/REPORT_TEMPLATE.md; identify P004, set COMPLETE, PARTIAL, or BLOCKED according to actual inspection coverage, and stop for Codex review. COMPLETE means the repair proposal is prepared, not that references are fixed.
