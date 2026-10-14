# Figma Workflow & Annotated Feature Atlas: Live Canvas Workspace Index

## Overview
This document indexes the continuous spatial game workflow authored natively on the connected Figma canvas for **Sheeshh Prop Hunt**. Unlike detached slides or manual SVG import instructions, the entire visual guide is laid out as a single connected spatial workspace inside the user's active Figma file.

---

## 1. Connected Figma Environment & Canvas Proof

### Live Canvas Document
- **User Account**: `Sheesh` (`aka.venom.official@gmail.com`, ID: `1574009614295004041`)
- **Figma File Name**: `SE Mega Root Tree - Rebranched`
- **Figma File Key**: `dPzxa8g9beHU6sKGx7dqnY`
- **Direct Workspace URL**: [https://www.figma.com/file/dPzxa8g9beHU6sKGx7dqnY](https://www.figma.com/file/dPzxa8g9beHU6sKGx7dqnY)
- **Integration Architecture**: Model Context Protocol (MCP) `figma-write-bridge` over local WebSocket (`ws://127.0.0.1:3055`) connected directly to running Figma Desktop app session.

### Root Frame & Spatial Layout Bounds
- **Master Continuous Canvas Frame**: `SHEESHH PROP HUNT - GAME WORKFLOW`
  - **Figma Node ID**: `3:7`
  - **Dimensions**: `4200px` width × `6200px` height
  - **Origin**: `(0, 0)` on active canvas
  - **Background**: Deep Navy (`#0B0F19`)

---

## 2. Spatial Layout & Major Region Breakdown

The workspace is organized from top to bottom as a continuous connected journey across the canvas:

```
[00. Title & Role Lockup] (y: 80 - 400)
             │
             ▼
[01. Launch & Session Discovery] (y: 440 - 1320)
   ├─ Main Menu (WBP_MainMenu)
   ├─ Server Browser (WBP_ServerList)
   ├─ Host Config & Spawn Placeholders
   └─ Network Level Travel Callout
             │
      ┌──────┴──────┐
      ▼             ▼
[02. Hunter Lane]  [03. Prop Lane]  (Parallel Lanes, y: 1360 - 2760)
 • Reticle & HUD     • Mimic & Disguise HUD
 • Aim Sensitivity   • Rotation Lock (IA_RotationLock)
 • 3-Step Shoot      • Matched Before/After Transformation Pair
      │             │
      └──────┬──────┘
             ▼
[04. Shared Pause & Settings Branch] (y: 2820 - 4020)
 • Pause Overlay (WBP_Menu) [Reached from BOTH lanes]
 • Audio Settings (SC_Music & SC_SFX Sliders with % Readout)
 • Video Settings (720p 6-Row Viewport Scaling)
 • Controls Settings (Live Sensitivity Slider & Readout)
             │
             ├──────────────────────────┐
             ▼                          ▼
[05. Developer Debug Branch]     [06. Outcomes, Atlas & Checklist]
 • Host Authority Gates (HasAuthority)  • Evidence Provenance Matrix
 • Dynamic Hunter Limits (1..N-1)       • Round Outcome Loop
 • Confirmed Round Start & Server Prop  • 18 Missing-Image Replacement Slots
 (y: 4080 - 4960)                       (y: 5060 - 6020)
```

---

## 3. Node Inventory of Major Spatial Regions

| Region Name | Node ID | Type | Dimensions | Location (X, Y) | Description / Evidence |
|---|---|---|---|---|---|
| **Master Canvas Frame** | `3:7` | FRAME | 4200 × 6200 | (0, 0) | Master continuous workspace frame |
| **Title Container** | `3:8` | RECTANGLE | 4000 × 320 | (100, 80) | Typographic header container |
| **Title Text** | `3:9` | TEXT | Auto | (160, 120) | `SHEESHH PROP HUNT` header text |
| **Subtitle Text** | `3:10` | TEXT | Auto | (160, 195) | Pitch, subtitle & engine metadata |
| **Hunter Role Badge** | `3:11` / `3:12` | RECT + TEXT | 340 × 46 | (160, 250) | Orange badge: Seek & Eliminate |
| **Prop Role Badge** | `3:13` / `3:14` | RECT + TEXT | 340 × 46 | (530, 250) | Cyan badge: Mimic & Survive |
| **Debug Role Badge** | `3:15` / `3:16` | RECT + TEXT | 380 × 46 | (900, 250) | Violet badge: Host Gated & Telemetry |
| **Section 01 Container** | `3:17` | RECTANGLE | 4000 × 880 | (100, 440) | Launch & Session Discovery boundary |
| **Main Menu Card** | `3:19` / `3:21` | RECT + TEXT | 800 × 460 | (160, 540) | Callouts for Host, Find, Settings, Name, Quit |
| **Server Browser Card** | `3:22` / `3:24` | RECT + TEXT | 800 × 460 | (1020, 540) | Callouts for Refresh, List, Join, Metadata |
| **Host Config Slot** | `3:25` / `3:27` | RECT + TEXT | 680 × 460 | (1880, 540) | `IMG-01-HOST-CONFIG` (960x540 placeholder) |
| **Spawn Transition Slot** | `3:28` / `3:30` | RECT + TEXT | 680 × 460 | (2600, 540) | `IMG-01-SPAWN-TRANSITION` (960x540 placeholder) |
| **Session Architecture** | `3:31` / `3:33` | RECT + TEXT | 680 × 460 | (3320, 540) | Null OSS and listen travel callouts |
| **Hunter Lane Container** | `3:34` | RECTANGLE | 1960 × 1400 | (100, 1360) | Hunter combat lane container |
| **Hunter HUD Slot** | `3:36` / `3:38` | RECT + TEXT | 880 × 380 | (160, 1460) | `IMG-02-HUNTER-HUD` (960x540 placeholder) |
| **Hunter Aim Slot** | `3:39` / `3:41` | RECT + TEXT | 880 × 380 | (1100, 1460) | `IMG-02-HUNTER-AIM` (4x sensitivity verified) |
| **Hunter Shoot Step 1** | `3:44` / `3:45` | RECT + TEXT | 560 × 320 | (190, 1950) | `IMG-02-SHOOT-AIM` (Target acquisition) |
| **Hunter Shoot Step 2** | `3:46` / `3:47` | RECT + TEXT | 560 × 320 | (790, 1950) | `IMG-02-SHOOT-FIRE` (Hitscan raycast fire) |
| **Hunter Shoot Step 3** | `3:48` / `3:49` | RECT + TEXT | 560 × 320 | (1390, 1950) | `IMG-02-SHOOT-DAMAGE` (Damage & elimination) |
| **Prop Lane Container** | `3:50` | RECTANGLE | 1960 × 1400 | (2140, 1360) | Prop survival lane container |
| **Prop HUD Slot** | `3:52` / `3:54` | RECT + TEXT | 880 × 380 | (2200, 1460) | `IMG-03-PROP-HUD` (960x540 placeholder) |
| **Rotation Lock Slot** | `3:55` / `3:57` | RECT + TEXT | 880 × 380 | (3140, 1460) | `IMG-03-ROTATION-LOCK` (World freeze & orbit) |
| **Matched Before Card** | `3:60` / `3:61` | RECT + TEXT | 840 × 320 | (2230, 1950) | `IMG-03-TRANSFORM-BEFORE` (Humanoid form) |
| **Matched After Card** | `3:62` / `3:63` | RECT + TEXT | 840 × 320 | (3140, 1950) | `IMG-03-TRANSFORM-AFTER` (Transformed urn) |
| **Pause & Settings Branch** | `3:64` | RECTANGLE | 4000 × 1200 | (100, 2820) | Shared modal overlay & preferences rail |
| **Pause Menu Card** | `3:66` / `3:68` | RECT + TEXT | 840 × 460 | (160, 2920) | Reached from both lanes; DestroySession |
| **Audio Settings Card** | `3:69` / `3:71` | RECT + TEXT | 880 × 460 | (1060, 2920) | SC_Music & SC_SFX sliders; settings.sav |
| **Video Settings Card** | `3:72` / `3:74` | RECT + TEXT | 960 × 460 | (2000, 2920) | 6-row 720p scaling; GameUserSettings |
| **Controls Settings Card** | `3:75` / `3:77` | RECT + TEXT | 960 × 460 | (3020, 2920) | `IMG-04-SETTINGS-CONTROLS` (Sensitivity slider) |
| **Debug Branch Container** | `3:78` | RECTANGLE | 4000 × 880 | (100, 4080) | Developer Debug tool branch container |
| **Debug Live Card** | `3:80` / `3:82` | RECT + TEXT | 1200 × 460 | (160, 4180) | Telemetry, dynamic clamp (1..N-1), host gates |
| **Debug Preview Card** | `3:83` / `3:85` | RECT + TEXT | 1200 × 460 | (1420, 4180) | Asset preview provenance; singleton input |
| **Debug Security Card** | `3:86` / `3:88` | RECT + TEXT | 1200 × 460 | (2680, 4180) | Shipping guards & authority enforcement |
| **Section 06 Container** | `3:89` | RECTANGLE | 4000 × 960 | (100, 5060) | Outcomes, Feature Atlas & Checklist |
| **Feature Atlas Card** | `3:91` / `3:93` | RECT + TEXT | 1880 × 800 | (160, 5160) | Evidence matrix with provenance labels |
| **Replacement Checklist Card** | `3:94` / `3:96` | RECT + TEXT | 1880 × 800 | (2120, 5160) | 18 replacement placeholder inventory guide |

---

## 4. Visual QA & Verification Exports

Representative visual exports were captured directly from the live Figma canvas via `export_node` and archived in `documentation/figma_review/`:
- `documentation/figma_review/overview_export.png`: Full-frame thumbnail view of node `3:7` (4200 × 6200).
- `documentation/figma_review/title_text.png`: Native text rendering of `SHEESHH PROP HUNT` (node `3:9`).
- `documentation/figma_review/menu_callouts.png`: High-resolution render of Main Menu numbered callouts (node `3:21`).
- `documentation/figma_review/transform_before.png`: Matched Pair Before card typography (node `3:61`).
- `documentation/figma_review/audio_settings.png`: Audio settings Callouts confirming SC_Music & SC_SFX (node `3:71`).
- `documentation/figma_review/debug_live.png`: Debug host authority callouts & dynamic limits (node `3:82`).

---

## 5. Owner Maintenance Workflows

1. **Panning the Canvas**:
   - In Figma Desktop, press `Shift + 1` to zoom to fit the entire continuous workspace (`SHEESHH PROP HUNT - GAME WORKFLOW`).
   - Use spacebar + drag to smoothly pan between Launch, Hunter Lane, Prop Lane, Settings, and Debug branches.
2. **Replacing Placeholders**:
   - Capture clean in-game screenshots at 16:9 aspect ratio (1920x1080).
   - Select any labeled slot (e.g., `IMG-03-TRANSFORM-BEFORE`).
   - Paste the image directly into the rectangle fill using Figma's fill inspector.
   - Update `documentation/FIGMA_IMAGE_PLACEHOLDERS.csv` from `PLANNED` to `CAPTURED`.
