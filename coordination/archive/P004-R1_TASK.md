# Task P004-R1 - Reconcile repair evidence and qualify the plan

Status: APPROVED
Owner: Antigravity
Reviewer: Codex

## Goal
Resolve the live prop-array discrepancy and make the repair proposal concrete without claiming unverified identity or guaranteed repair results.

## Read first
AGENTS.md, PROJECT.md, coordination/archive/P004_REPORT.md, coordination/evidence/P004-repair-plan.md and P004 mappings.

## Scope
1. Requery BP_propChar.PropAllowedMesh in the exact-project editor. Codex observed length 55 and 39 None entries on 2026-10-06, versus P004's claimed 36. Record every index and its current object path or None, with timestamp and session/project identity. Establish whether the three additional nulls are pre-existing empty slots, missing Egypt assets, or another condition using retained evidence and supported read-only queries. Do not guess original index-to-package mappings.
2. Explain why 1,402 manifest entries differ from the report's stated 911 + 6 + 36 inputs. Count actual categories; correct the description. Capture current hashes/status and preserve input files.
3. Correct 'exist identically' and guaranteed repair statements: registry class/name/path correspondence proves candidate presence, not original identity. Historical movement method is unverified unless retained evidence establishes it. Distinguish unchanged asset bytes from filesystem paths that would change.
4. Revise coordination/evidence/P004-repair-plan.md: compare supported Unreal relocation with restoring original package layout. Explain how each approach treats references pointing to already-missing old paths versus valid current paths, and how those claims will be validated. Do not present a generic editor move as guaranteed to recover missing references or an offline folder move as automatically safe. Retain backup/reversal, destination collision checks, unsaved editor preservation, full pack dependency inspection, and fresh-session reload requirements. Do not delete NonGitLFS or recommend saving null defaults.
5. Treat missing audio as unresolved; do not remove or replace it by default. Prepare the exact user decision and affected asset for later action.
6. Replace implementation report for P004-R1 and save index/manifest/plan evidence under coordination/evidence/P004-R1-*. You may correct P004-repair-plan.md; preserve the archived original report and all other prior evidence.

## Do not change
No asset, configuration, source, plugin, task/history, or archive edits. No moves, copies of asset packs, saves, resaves, redirector fixups, editor shutdown, installs, builds, cook, PIE, or Git changes. Preserve unrelated work.

## Acceptance checks
- Live 55-entry array enumeration accounts for observed 39 nulls or explicitly documents the unresolved discrepancy.
- Manifest category counts reconcile to the actual 1,402 entries.
- Candidate identity, expected repair effects, relocation mechanics, and historical causes are qualified by evidence.
- Proposed repair has explicit preconditions and post-reload checks; no implementation performed.
- Audio choice remains open; no default removal.

## Required report
Use coordination/REPORT_TEMPLATE.md; Task ID P004-R1, status COMPLETE, PARTIAL, or BLOCKED. Stop for Codex review.

