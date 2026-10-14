# Task P011 - UI Layout, Typography & Responsive Verification

## 1. Visual Design Conformance against UI_DESIGN_BRIEF.md

### Color Palette Implementation
| Token | Hex / Spec | Usage in Redesign |
| :--- | :--- | :--- |
| Base Backdrop | `#101522` / `(R=0.063, G=0.082, B=0.133, A=0.85)` | Charcoal legibility overlay on `Image_99` replacing harsh magenta tint |
| Panel Fill | `#1C2434` / `(R=0.110, G=0.141, B=0.204, A=1.0)` | Elevated cards (`Border_0`, `Border_MapPreview`, `BorderServer`) |
| Secondary Fill | `#141A24` / `(R=0.078, G=0.102, B=0.141, A=1.0)` | Text inputs (`getservername`, `ipentered`), sub-cards (`Border_MapRuleCard`), server rows (`Border_15`) |
| Border / Outline | `#2A364F` (1.0 - 1.5px) | Subtle card borders with 6px-12px rounded corners via `WhiteSquareTexture` |
| Primary Accent | `#27D8E8` (Cyan) | "PROP HUNT" title, `CreateServerbutton` fill, `FindingSession` outline, server ping, mode chips |
| Secondary Accent | `#FF9347` (Orange) | "CURRENT ROTATION" arena tag on Map1 preview card |
| Text Primary | `#F4F6FA` (Warm White) | Card headings, map titles, server names, combobox selections |
| Text Secondary | `#CBD5E1` / `#94A3B8` (Slate) | Input hints, rule list bullets, map descriptions, player counts |

---

## 2. Widget Structure & Layout

### Left Navigation / Hosting Panel (`Border_0`)
- **Dimensions & Anchor**: Symmetrical left card: `anchors: [0, 0.5] to [0, 0.5]`, `alignment: [0, 0.5]`, `offsets: left 64, top 0, right 460, bottom 520`.
- **Card Styling**: Elevated `#1C2434` fill, `#2A364F` border outline, 12px rounded corners, 24px inner padding.
- **Controls Layout (`VerticalBox_0`)**:
  - `getservername` (Server Name Input): `#141A24` fill, 6px corners, `#2A364F` outline (normal) / `#27D8E8` outline (focused), `#F4F6FA` text, `"Enter Server Name..."` hint text.
  - `getNoofplayers` (Slots Dropdown): `#141A24` button fill, 6px corners, `#2A364F` outline, `#F4F6FA` selection text, `[8, 6, 8, 6]` padding. Options: 2-5 players.
  - `MapSelection` (Map Dropdown): `#141A24` button fill, 6px corners, `#2A364F` outline, `#F4F6FA` text. Strictly locked to `"Map1"`.
  - `CreateServerbutton` (Host Action): Primary cyan `#27D8E8` fill, `#38E1F0` outline, hover `#4CE4F2`, 6px corners. Text `"HOST GAME"` in high-contrast dark `#101522` 15pt Bold.
  - `FindingSession` (Browser Toggle): Dark slate `#1A2536` fill, cyan `#27D8E8` outline, hover `#38E1F0` outline, 6px corners. Text `"SERVER BROWSER"` in `#F4F6FA` 15pt Bold.
  - `ipentered` (Direct IP Input): `#141A24` fill, 6px corners, `#2A364F` outline (normal) / `#27D8E8` outline (focused), `#F4F6FA` text, `"Enter Server IP (e.g. 127.0.0.1)..."` hint text.
  - `joinIp` (Direct Connect Action): Dark slate `#1A2536` fill, `#2A364F` outline, hover `#64748B`, 6px corners. Text `"DIRECT CONNECT"` in `#CBD5E1` 13pt Bold.

### Right-Side Featured Map Card (`Border_MapPreview`)
- **Dimensions & Anchor**: Symmetrical right card: `anchors: [1, 0.5] to [1, 0.5]`, `alignment: [1, 0.5]`, `offsets: left -64, top 0, right 460, bottom 520`.
- **Card Styling**: Elevated `#1C2434` fill, `#2A364F` border outline, 12px rounded corners, 24px inner padding.
- **Content Hierarchy (`VBox_MapPreview`)**:
  - `TextBlock_MapTag`: `"CURRENT ROTATION"` (11pt Bold `#FF9347`)
  - `TextBlock_MapName`: `"EGYPTIAN RUINS"` (24pt Bold `#F4F6FA`)
  - `TextBlock_MapMode`: `"PROP HUNT • MAP 1 (EXCLUSIVE)"` (12pt Bold `#27D8E8`)
  - `TextBlock_MapDesc`: Concise gameplay summary explaining prop camouflage vs hunter search (`#94A3B8`, autowrapped).
  - `Border_MapRuleCard`: `#141A24` card with match specs:
    - `"• 2 - 5 PLAYERS PER MATCH"`
    - `"• 5 MINUTE ROUND TIMER"`
    - `"• LISTEN & ADVANCED SESSIONS"`

### Header & Player Profile
- **Title (`Title_PropHunt`)**: Centered at top (`anchors: [0.5, 0] to [0.5, 0]`, `offsets: left 0, top 36, right 380, bottom 52`). Text `"PROP HUNT"` in 36pt Bold `#27D8E8` with 2px `#101522` outline.
- **Player Avatar (`Image_0`)**: Anchored top-left at `[64, 52]`, size 52x52.
- **Player Name (`TextBlock_2`)**: Anchored top-left at `[128, 64]`, 16pt Bold `#F4F6FA`, dynamically bound to `getname`.

### Server Browser Row (`WBP_Server`)
- **Root Card (`Border_15`)**: Elevated `#141C29` card fill, `#2A364F` border outline, 6px rounded corners, padding `[16, 8, 16, 8]`.
- **Server Name (`txt_sname`)**: 15pt Bold `#F4F6FA`, bound to `GetExtraSettings`.
- **Player Count (`txt_ammountofplayer`)**: 14pt Bold light slate `#CBD5E1`, bound to `getnoofplayers`.
- **Ping (`txt_ping`)**: 14pt Bold cyan `#27D8E8`, bound to `getPing`.
- **Join Action (`Button_0`)**: Dark slate fill `#1A2536`, cyan outline `#27D8E8` (1.5px), hover `#27D8E8` (2px), 6px corners. Label `"JOIN"` in 13pt Bold `#F4F6FA`.

---

## 3. Responsive Scaling & DPI Evidence
Rendered and verified across three target display resolutions:
1. **720p (1280x720)**: [P011-menu-720p.png](file:///g:/Unreal%20Projects/SheeshhPropHuntYT/coordination/evidence/P011-menu-720p.png)
   - Layout preserves all margins. Both left and right cards scale cleanly without content clipping.
2. **1080p (1920x1080)**: [P011-menu-1080p.png](file:///g:/Unreal%20Projects/SheeshhPropHuntYT/coordination/evidence/P011-menu-1080p.png)
   - Standard 1080p reference frame. Symmetrical 460x520 cards, centered title, clean negative space for 3D world backdrop.
3. **Ultrawide (2560x1080)**: [P011-menu-ultrawide.png](file:///g:/Unreal%20Projects/SheeshhPropHuntYT/coordination/evidence/P011-menu-ultrawide.png)
   - Left card remains anchored 64px from left margin; right card remains anchored 64px from right margin; title remains centered. No stretching or coordinate drift.
