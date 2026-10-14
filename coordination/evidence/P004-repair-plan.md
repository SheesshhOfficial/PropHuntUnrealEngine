# Repair Plan: Missing Asset References (Task P004 / Revised in P004-R1)

See full qualified plan in [coordination/evidence/P004-R1-repair-plan.md](file:///G:/Unreal%20Projects/SheeshhPropHuntYT/coordination/evidence/P004-R1-repair-plan.md).

## Problem Overview
During P003 load diagnostics, 37 package reference load failures were detected:
1. **36 Static Mesh Packages**:
   - 13 under `/Game/resources/CyberpunkIndustries/Meshes/`
   - 23 under `/Game/resources/Downtown_West/Assets/props/`
   - Referenced by `BP_propChar` (in `PropAllowedMesh`), `Map3.umap`, `Map2.umap`, and composite prop assets.
   - Candidate assets with matching names and classes exist under `Content/resources/NonGitLFS/`.
   - In `BP_propChar.PropAllowedMesh` (55 elements), 39 entries evaluate to `None` in memory: 36 correspond to the missing packages, and 3 are pre-existing empty/unassigned slots at indices 37..39.
2. **1 Audio Package**:
   - `/Game/Core/sound/background-music-for-video-453282`
   - Referenced by Sound Cue `/Game/Core/sound/SC_BackgroundMusic` (in turn referenced by `GM_ProphuntGameMode`).
   - Completely absent on disk; requires explicit user decision.

## Comparison of Repair Approaches
- **Approach A (Restoring original locations)**:
  - Relocating `CyberpunkIndustries` and `Downtown_West` back to `Content/resources/`.
  - 0 binary `.uasset` or `.umap` files need editing or resaving.
  - Matches `DefaultGame.ini` `+MapsToCook` paths without config changes.
  - Requires clean editor shutdown, destination collision checks, backup archive, and fresh-session validation.
  - Do NOT delete `NonGitLFS/`.
- **Approach B (In-Editor Re-wiring)**:
  - Moving assets in Content Browser does not fix already-broken references pointing to `/Game/resources/`.
  - Re-saving `BP_propChar` while 39 entries are `None` would permanently serialize nulls into the asset. High risk of corruption.

## Recommendation
Execute Approach A with strict safeguards (full backup, clean editor shutdown, fresh session verification). Audio decision left open for user direction.

## Codex review qualification (2026-10-06)
Inspection accepted; relocation has not been executed or approved as a guaranteed repair. Absence of loader errors does not establish authored intent for indices 37..39. Treat three remaining nulls as a hypothesis to check after reload, not a reason to overwrite defaults. A supported editor move to the original package destination may restore old-path resolution after fresh load; its outcome cannot be dismissed without testing. The current comparison does not establish that all editor relocation strategies require manual rewiring. Full pack dependency validation, verified backups and a separate implementation task are required before repair execution.

