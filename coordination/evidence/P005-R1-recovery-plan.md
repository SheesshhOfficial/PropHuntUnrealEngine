# Scoped Non-Destructive Recovery Plan

> [!IMPORTANT]
> This recovery plan is documented for audit and recovery readiness only. It **must NOT be executed** during Task P005-R1.

## Objective
If a full rollback of Task P005 is ever required, safely restore the workspace to its exact pre-P005 state without wildcard deletions (`Remove-Item -Recurse *`), forced overwrites, or data loss of concurrent edits.

## Prerequisites & Pre-Conditions
1. **Workspace Verification**:
   - Verify absolute workspace root: `G:\Unreal Projects\SheeshhPropHuntYT`.
   - Ensure Unreal Editor is cleanly shut down (`Get-Process UnrealEditor* -ErrorAction SilentlyContinue` returns null).
   - Ensure no background processes or file locks exist on project files.
2. **Backup Source Integrity**:
   - Verify the presence and integrity of `coordination/backups/P005-20261006-174241/`.
   - Verify the pre-recorded manifest `coordination/evidence/P005-backup-verification.txt` has 1,571 valid source hashes.
3. **Drive Space Check**:
   - Verify drive `G:` has at least 15 GB of free space before quarantine and copy operations.

## Phase 1: Isolation & Quarantine (No Destructive Deletion)
Do NOT delete repaired assets directly. Instead, safely relocate the active mutated paths into a timestamped quarantine directory:
1. Create quarantine path: `coordination/backups/quarantine-P005-<timestamp>/Content/resources/`.
2. Move active `Content/resources/CyberpunkIndustries` to `coordination/backups/quarantine-P005-<timestamp>/Content/resources/CyberpunkIndustries`.
3. Move active `Content/resources/Downtown_West` to `coordination/backups/quarantine-P005-<timestamp>/Content/resources/Downtown_West`.
4. Copy active `Config/DefaultGame.ini` to `coordination/backups/quarantine-P005-<timestamp>/Config/DefaultGame.ini`.

## Phase 2: Restoring from Verified Backup
1. **Restore CyberpunkIndustries**:
   - Copy `coordination/backups/P005-20261006-174241/Content/resources/NonGitLFS/CyberpunkIndustries` -> `Content/resources/NonGitLFS/CyberpunkIndustries/` (including `Maps/Map3.umap` and `Map3_BuiltData.uasset`).
   - File count to verify: exactly 317 files.
2. **Restore Downtown_West**:
   - Copy `coordination/backups/P005-20261006-174241/Content/resources/NonGitLFS/Downtown_West` -> `Content/resources/NonGitLFS/Downtown_West/` (including `Maps/Map2.umap`, `Map2_BuiltData.uasset`, and all sub-levels).
   - File count to verify: exactly 1,251 files.
3. **Restore Configuration**:
   - Copy `coordination/backups/P005-20261006-174241/Config/DefaultGame.ini` -> `Config/DefaultGame.ini`.
   - SHA256 to verify: `FE60D606F1BBEB8363072D17B0F3066AB11B29A041E60EE90B4B20D3D9086D67`.

## Phase 3: Post-Restoration Validation
1. **Hash Verification**:
   - Run a full SHA256 audit across all 1,569 restored asset and config files against `coordination/evidence/P005-backup-verification.txt`.
   - Confirm 0 mismatches.
2. **External Referencer Verification**:
   - Verify `Content/Core/BluePrints/BP_propChar.uasset` SHA256 is `EA4A8FB63409B2981457DD477B9955FE95ADC79D8B750EA68F02A79E791D115A`.
   - Verify `Content/resources/Stylized_Egypt/Maps/Map1.umap` SHA256 is `E60529E62A879C7B96D6C6B28BD2EF6B85750F9DB27909FFD7D8F1EF3C581900`.
   - Verify `Content/Core/sound/SC_BackgroundMusic.uasset` SHA256 is `01B531384F84933476B6ED00A995C262B797D1FB06BCC6051CA944D7F4847F81`.
3. **Clean Editor Startup**:
   - Launch Unreal Editor 5.7 on `SheeshhPropHuntYT.uproject`.
   - Confirm project loads cleanly into the pre-P005 state.
