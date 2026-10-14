# Miro Board Index — Sheeshh Prop Hunt Game Documentation

**Documentation Date:** 2026-10-12 (Asia/Calcutta)  
**Board Title:** Sheeshh Prop Hunt — Game Documentation  
**Board URL:** [https://miro.com/app/board/uXjVEb-ujEA=/](https://miro.com/app/board/uXjVEb-ujEA=/)  
**Primary Companion Document:** [GAME_DOCUMENTATION.md](GAME_DOCUMENTATION.md)  

---

## 1. Board Structure & Frame Map

The board is arranged in a structured 2D grid of 11 sequential frames (1600x1100 each), styled according to the design brief with navy headline bars, cyan accents, clear section hierarchy, and honest evidence labels.

| Frame # | Frame Title & Content | Board Coordinates (X, Y) | Description & Key Visuals |
| :---: | :--- | :---: | :--- |
| **01** | `01 START HERE: Overview & Legend` | `(0, 0)` | Game pitch, working name, document date, quick navigation overview, and evidence verification tier legend. |
| **02** | `02 GAMEPLAY: Roles & Match Rules` | `(1800, 0)` | Prop disguise loop (`BP_propChar`, 55 props, `IA_RotationLock`, `IA_Taunt`), Hunter hitscan (`BP_ThirdPersonCharacter`), and round timer win conditions. |
| **03** | `03 PLAYER JOURNEY: Match Lifecycle` | `(3600, 0)` | Mermaid sequence flow from launch -> `Boot_Lvl` -> Listen Server / Browser -> `Map1` -> Pause (`WBP_Menu`) -> `DestroySession` teardown. |
| **04** | `04 SYSTEMS & ARCHITECTURE` | `(5400, 0)` | Technical system relationship diagram (`MenuGameinstance`, `Boot_Lvl`, `Map1`, `GM_ProphuntGameMode`, `UDebugMenuLib`, `BP_SettingsSaveGame`, `UGameUserSettings`). |
| **05** | `05 UI GALLERY: Live & Historical Screens` | `(7200, 0)` | Screen comparison gallery featuring 7 embedded live and historical screenshots with provenance and SHA256 hashes. |
| **06** | `06 DEVELOPER DEBUG: Host Control Tools` | `(0, 1300)` | Dynamic host authority gating, Shipping compile-time guard (`UDebugMenuLib`), clamp limits, 2-click round start, and singleton controller input. |
| **07** | `07 SETTINGS & SAVE DATA: Persistence` | `(1800, 1300)` | Graphics options (`UGameUserSettings`), audio/sensitivity persistence (`BP_SettingsSaveGame`), transactional Apply/Discard rollback, and aim response. |
| **08** | `08 TESTING & BUILD: Acceptance Matrix` | `(3600, 1300)` | Comprehensive system status matrix (Table widget), PowerShell build command, and reproducible PIE 2-player test checklist. |
| **09** | `09 KNOWN ISSUES & GAPS` | `(5400, 1300)` | Explicit documentation of open gates: physical keyboard strikes, fresh packaged cook run, PlayerState startup race, subjective music audibility, and capture checklist. |
| **10** | `10 ROADMAP & SCOPE BOUNDARIES` | `(0, 2600)` | Phased execution roadmap (props expansion, music choice, Steam OSS, VOIP) vs. permanently excluded items (Map2/Map3 restoration). |
| **11** | `11 EVIDENCE & MAINTENANCE: Artifact Index` | `(1800, 2600)` | Deliverables index, full SHA256 hash manifest, local documentation references, and maintenance protocols. |

---

## 2. Embedded Media Artifacts

The following screenshot files from `coordination/evidence/` were uploaded directly to Miro storage and embedded with individual captions and SHA256 provenance labels:

| Image Asset | Miro Widget ID | Provenance Tier | Direct Widget URL |
| :--- | :---: | :--- | :--- |
| `Codex-settings-live.png` | `3458764686816898242` | Live PIE capture (Task P013-R3) | [Open in Miro](https://miro.com/app/board/uXjVEb-ujEA=/?moveToWidget=3458764686816898242) |
| `Codex-settings-video-live.png` | `3458764686816898439` | Live PIE capture (Task P013-R3) | [Open in Miro](https://miro.com/app/board/uXjVEb-ujEA=/?moveToWidget=3458764686816898439) |
| `Codex-debug-1920-preview.png` | `3458764686816898631` | Asset preview (Task P013-R3) | [Open in Miro](https://miro.com/app/board/uXjVEb-ujEA=/?moveToWidget=3458764686816898631) |
| `Codex-debug-live.png` | `3458764686816898813` | Live capture within takeover (Task P013-R3) | [Open in Miro](https://miro.com/app/board/uXjVEb-ujEA=/?moveToWidget=3458764686816898813) |
| `P011-R2-menu-1080p.png` | `3458764686816955055` | Historical asset preview (Task P011-R2) | [Open in Miro](https://miro.com/app/board/uXjVEb-ujEA=/?moveToWidget=3458764686816955055) |
| `P011-R2-browser-1080p.png` | `3458764686816955297` | Historical asset preview (Task P011-R2) | [Open in Miro](https://miro.com/app/board/uXjVEb-ujEA=/?moveToWidget=3458764686816955297) |
| `P010-R1-pause-menu-1080p.png` | `3458764686816955578` | Historical capture (Task P010-R1) | [Open in Miro](https://miro.com/app/board/uXjVEb-ujEA=/?moveToWidget=3458764686816955578) |

---

## 3. Maintenance Instructions

1. **Local Documents as Source of Truth**:  
   Always update `documentation/GAME_DOCUMENTATION.md` first. Miro reflects the local documentation, not vice versa.
2. **Updating Miro Board Items**:  
   Use `canvas_read_as_svg` with targeted `widget_ids` or bounding boxes to inspect existing frames before updating. Send partial SVG patches preserving `data-miro-id`.
3. **Adding New Screenshots**:  
   - Save the raw screenshot to `coordination/evidence/` and compute its SHA256 hash.
   - Obtain a single-use upload URL via `image_get_upload_url`.
   - Upload image bytes via `curl -X PUT -H "Content-Type: image/png" --data-binary @<file> <upload_url>`.
   - Place the image via `image_create` or canvas composer DSL using the returned token.
   - Add caption, date, provenance, and hash card beneath the image.
4. **Permissions & Security**:  
   Do not modify board sharing permissions, make the board publicly discoverable, or invite external accounts without user authorization.
