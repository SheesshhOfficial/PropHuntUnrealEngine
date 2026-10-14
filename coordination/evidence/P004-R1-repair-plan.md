# Qualified Repair Plan: Missing Asset References (Task P004-R1)

## 1. Problem Definition & Evidence Summary
During P003/P004 inspection, 37 package reference load failures were detected by Unreal Engine 5.7:
- **36 StaticMesh Packages**:
  - 13 under `/Game/resources/CyberpunkIndustries/Meshes/`
  - 23 under `/Game/resources/Downtown_West/Assets/props/`
  - Referenced by:
    - `BP_propChar`'s `PropAllowedMesh` array (length 55; currently contains **39 `None` entries**, comprising 36 missing load references and 3 currently empty slots of unverified original intent at indices 37..39).
    - `/Game/resources/NonGitLFS/CyberpunkIndustries/Maps/Map3` (13 internal references).
    - `/Game/resources/NonGitLFS/Downtown_West/Maps/Map2` (21 internal references).
    - Composite prop assets under `NonGitLFS/Downtown_West/Assets/props/...`.
    - `/Game/resources/Stylized_Egypt/Maps/Map1` (1 reference).
- **1 Audio Package**:
  - `/Game/Core/sound/background-music-for-video-453282`
  - Referenced by Sound Cue `/Game/Core/sound/SC_BackgroundMusic` (referenced by `GM_ProphuntGameMode`).

AssetRegistry queries confirmed that candidate assets with matching package names and `StaticMesh` classes exist on disk under `Content/resources/NonGitLFS/`. However, candidate presence in the filesystem does not prove original byte-level identity with originally authored assets.

---

## 2. Technical Comparison of Approaches

### Approach A: Restoring Original Package Layout (Relocating Packs to `Content/resources/`)
- **Reference Mechanics**:
  - Existing serialized import tables in `BP_propChar.uasset`, `Map2.umap`, `Map3.umap`, and composite props reference hard-coded package paths starting with `/Game/resources/CyberpunkIndustries/` and `/Game/resources/Downtown_West/`.
  - When assets are placed at `Content/resources/CyberpunkIndustries/` and `Content/resources/Downtown_West/`, their package paths match the hard-coded imports on disk.
  - Existing asset bytes remain unchanged on disk; only their directory path changes.
  - Zero binary `.uasset` or `.umap` files need internal reference modification or resaving.
  - Matches active `DefaultGame.ini` `+MapsToCook` paths without editing project configuration.
- **Risks & Qualifications**:
  - Offline filesystem moves are **not automatically safe**:
    - Risk of destination collisions (verified: target paths `Content/resources/CyberpunkIndustries` and `Content/resources/Downtown_West` do not currently exist).
    - Risk of file locks if executed while the editor process holds file handles.
    - Risk of in-memory corruption if editor unsaved buffers are flushed to disk during shutdown.
    - Does not guarantee all internal material/texture dependencies within the packs are resolved without an end-to-end dependency check.
- **Safety Preconditions**:
  1. Verify zero unsaved/dirty packages in Unreal Editor before closing.
  2. Perform clean editor shutdown.
  3. Create a full compressed backup archive of `Content/resources/NonGitLFS/` before moving.
  4. Perform filesystem move without deleting or modifying original files outside the targeted directories.
  5. Do NOT delete the `NonGitLFS/` parent directory.
  6. Re-launch fresh Unreal Editor session and validate logs and array states.

### Approach B: Supported Unreal In-Editor Relocation / Re-Wiring
- **Reference Mechanics**:
  - Standard Unreal Editor move operations (`UEditorAssetLibrary::RenameAsset` / Content Browser drag-and-drop) generate `UObjectRedirector` assets at the source location and update referencers known to the AssetRegistry.
- **Severe Limitations in Current State**:
  - The packages currently reside in `NonGitLFS/`. The referencers (`BP_propChar`, `Map2`, `Map3`) are **already broken** pointing to `/Game/resources/`, NOT to `NonGitLFS/`.
  - Moving assets inside `NonGitLFS/` via the editor does NOT repair references pointing to `/Game/resources/` because no redirectors exist from the `/Game/resources/` paths to `NonGitLFS/`.
  - Re-assigning `PropAllowedMesh` manually inside `BP_propChar` would require manually identifying and re-pointing 36 array indices.
  - **Critical Hazard**: `BP_propChar` currently has 39 `None` entries in memory. If `BP_propChar` is compiled and saved in memory while in this state, the 39 `None` values will be **permanently serialized into the binary asset**, overwriting the original referenced paths in that saved copy; a verified backup would be needed for recovery.
  - Would also require editing and resaving `Map2.umap`, `Map3.umap`, dozens of composite props, and `DefaultGame.ini`.
- **Verdict**: In-editor re-wiring carries high risk of binary asset corruption and data loss, and is not recommended.

---

## 3. Recommended Implementation Strategy (Approach A with Strict Safeguards)

### Proposed Scoped Actions
1. **Pre-Move Safety Check**:
   - Confirm target paths do not exist (verified: `Content/resources/CyberpunkIndustries` and `Content/resources/Downtown_West` are absent).
   - Confirm 0 dirty packages in editor (`list_dirty_packages` verified count: 0).
   - Cleanly close the active Unreal Editor process to release all file handles and prevent memory flushing.
2. **Backup**:
   - Create full backup archive: `coordination/evidence/backup_NonGitLFS_<timestamp>.zip` or directory copy.
3. **Directory Relocation**:
   - Move `Content/resources/NonGitLFS/CyberpunkIndustries/` -> `Content/resources/CyberpunkIndustries/`.
   - Move `Content/resources/NonGitLFS/Downtown_West/` -> `Content/resources/Downtown_West/`.
   - Retain empty `Content/resources/NonGitLFS/` directory; do not remove or delete it.
4. **Validation Protocol in Fresh Session**:
   - Launch fresh Unreal Editor 5.7 instance.
   - Inspect `Saved/Logs/SheeshhPropHuntYT.log`: confirm 0 `LoadErrors` for `BP_propChar`, `Map2`, and `Map3`.
   - Query `BP_propChar.PropAllowedMesh`: confirm that unresolved `None` entries drop from 39 to exactly 3 (the 3 observed additional empty slots at indices 37..39).
   - Query AssetRegistry for `/Game/resources/CyberpunkIndustries/Maps/Map3` and `/Game/resources/Downtown_West/Maps/Map2`: confirm resolved as `World` assets matching disk paths.
   - Run in-memory compilation check on `BP_propChar` and `GM_ProphuntGameMode`: confirm 0 errors.

---

## 4. Unresolved Audio Reference (Requires Explicit User Choice)
- Asset `/Game/Core/sound/background-music-for-video-453282` is absent across the entire repository.
- It will **not** be removed, substituted, or altered by default.
- Affected assets:
  - Sound Cue `/Game/Core/sound/SC_BackgroundMusic` (contains broken wave player node).
  - Game Mode `/Game/Core/BluePrints/GM_ProphuntGameMode` (references Sound Cue).
- **User Decision Required**:
  - **Choice 1**: Provide/restore the intended audio file (`background-music-for-video-453282` as WAV or SoundWave) into `Content/Core/sound/`.
  - **Choice 2**: Authorize explicit removal or decoupling of the background music reference in `SC_BackgroundMusic` / `GM_ProphuntGameMode`.

## Codex review qualification (2026-10-06)
Inspection accepted; relocation has not been executed or approved as a guaranteed repair. Absence of loader errors does not establish authored intent for indices 37..39. Treat three remaining nulls as a hypothesis to check after reload, not a reason to overwrite defaults. A supported editor move to the original package destination may restore old-path resolution after fresh load; its outcome cannot be dismissed without testing. The current comparison does not establish that all editor relocation strategies require manual rewiring. Full pack dependency validation, verified backups and a separate implementation task are required before repair execution.

