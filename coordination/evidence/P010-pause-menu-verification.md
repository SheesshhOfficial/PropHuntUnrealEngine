# Task P010 - Pause Menu Redesign & Leave Session Verification

## 1. Visual Hierarchy & Design System Alignment
Per [coordination/UI_DESIGN_BRIEF.md](file:///G:/Unreal%20Projects/SheeshhPropHuntYT/coordination/UI_DESIGN_BRIEF.md), the in-game pause presentation has been completely transformed from a transparent unstyled screen to a polished competitive arcade interface.

### Design Elements Implemented
- **Backdrop Overlay (`PauseBackdrop`)**:
  - Full viewport coverage (`[0,0] to [1,1]` anchor stretch).
  - Charcoal / navy tint (`#101522` at 85% opacity, `RGBA(0.012, 0.016, 0.026, 0.85)`).
  - Ensures high legibility while keeping underlying gameplay visible.
  - Z-Order: `-10`.
- **Elevated Card Container (`PauseCardBG`)**:
  - Centered presentation (`440 x 440` design frame, center anchored).
  - Background: Elevated dark slate `#1C2434` (`RGBA(0.022, 0.033, 0.053, 0.95)`).
  - Border: Subtle slate border `#2A364F`, 1.5px outline width.
  - Geometry: Soft rounded corners (`CornerRadius = 12px`).
  - Z-Order: `-1`.
- **Arcade Title & Role Accent**:
  - Heading: `"PAUSED"` in bold warm white (`#F4F6FA`, 28pt font, centered).
  - Role Accent Line (`PauseAccentLine`): Cyan prop accent `#27D8E8` (`64 x 3px`), positioned under heading.
- **Action Button Hierarchy (`VerticalBox_0`)**:
  1. **Resume Game (`BTN_Play`)** - Primary Action:
     - Styling: Cyan accent outline `#27D8E8` (1.5px normal, 2.5px hover), dark slate fill `#1A2536`, rounded corners 8px.
     - Label: `"RESUME GAME"` in bold `#F4F6FA` (16pt).
     - Behavior: Closes pause menu, destroys controller reference, restores Game Only input mode and hides mouse cursor.
  2. **Settings (`BTN_Settings`)** - Secondary Action:
     - Styling: Neutral dark slate `#1E2636`, subtle outline `#2E3A52` (1.0px normal, 1.5px hover), rounded corners 8px.
     - Label: `"SETTINGS"` in bold `#E2E8F0` (15pt).
     - Behavior: Switches `WidgetSwitcher_0` to Index 1 (Settings menu), preserving all existing settings bindings and options.
  3. **Leave Session (`BTN_LeaveSession`)** - Distinct Session Action:
     - Visual Separation: Increased top padding (16px) to clearly demarcate session-level actions from match controls.
     - Styling: Amber/orange hunter accent border `#FF9347` (`#8C5020` normal, `#FF9347` hover), dark fill `#261E1A`, rounded corners 8px.
     - Label: `"LEAVE SESSION"` in bold `#FFB86C` (15pt).
     - Behavior: Checks authority (`IsServer`), sets role-appropriate confirmation copy, and displays `LeaveConfirmOverlay`.
  4. **Quit to Desktop (`BTN_Exit`)** - Application Exit:
     - Styling: Neutral dark `#1C202A`, muted red border on hover (`#C53030`), rounded corners 8px.
     - Label: `"QUIT TO DESKTOP"` in bold `#CBD5E1` (14pt).
     - Behavior: Calls `QuitGame` to exit application cleanly.

---

## 2. Leave Confirmation Modal (`LeaveConfirmOverlay`)
To prevent accidental abandonment and inform players of session consequences, a dedicated modal layer is integrated into `WBP_MainMenu`:

- **Layer Architecture**:
  - `LeaveConfirmOverlay`: Full-canvas overlay, Z-Order `50`, default visibility `Collapsed`.
  - `ModalScrim`: Full-screen dark scrim `#080B12D0` (~80% opacity) dimming the pause menu.
  - `ModalCardBG`: Centered modal dialog card (`520 x 280px`), `#161D2BFA` fill, warning border `#FF9347` (1.5px), 12px rounded corners.
  - `ModalCardBox`: Centered content container (`480 x 250px`).
- **Dynamic Authority-Aware Messaging**:
  - Title: `"LEAVE SESSION"` (bold warm white `#F4F6FA`, 20pt).
  - **Host Message**: `"You are the host. Leaving will end the session and disconnect all players."`
  - **Client Message**: `"Are you sure you want to leave the session and return to the main menu?"`
  - Text strings routed via `Conv_StringToText` to ensure flawless `FText` localization and formatting.
- **Progress & Duplicate Prevention State**:
  - Status text `Txt_LeaveStatus`: `"Leaving session..."` (bold `#FFB86C`, 14pt, default `Collapsed`).
  - Upon clicking `BTN_ConfirmLeave`:
    - `Txt_LeaveStatus` transitions to `Visible`.
    - Both `BTN_ConfirmLeave` and `BTN_CancelLeave` are set to `bIsEnabled = false` to prevent duplicate submissions.
- **Action Buttons**:
  - `BTN_CancelLeave`: Neutral dark button (`#1E2636`, border `#36435C`), label `"CANCEL"`. Closes modal overlay and preserves pause menu.
  - `BTN_ConfirmLeave`: Restrained warning button (`#7D1F1F`, border `#C53030` normal, `#FF4D4D` hover), label `"LEAVE"`. Calls `MenuGameinstance.LeaveGameSession`.

---

## 3. Visual Artifacts
Captured at exact native resolutions via Unreal Editor preview rendering:

| Artifact | Resolution | State / Context |
|---|---|---|
| [P010-pause-menu-before-1080p.png](file:///G:/Unreal%20Projects/SheeshhPropHuntYT/coordination/evidence/P010-pause-menu-before-1080p.png) | 1920x1080 | Baseline pause menu (unformatted, transparent, no Leave button) |
| [P010-pause-menu-after-1080p.png](file:///G:/Unreal%20Projects/SheeshhPropHuntYT/coordination/evidence/P010-pause-menu-after-1080p.png) | 1920x1080 | Redesigned pause menu (backdrop, card, hierarchy, accents) |
| [P010-pause-menu-after-720p.png](file:///G:/Unreal%20Projects/SheeshhPropHuntYT/coordination/evidence/P010-pause-menu-after-720p.png) | 1280x720 | 720p safe-zone and DPI scaling validation |
| [P010-pause-menu-after-ultrawide.png](file:///G:/Unreal%20Projects/SheeshhPropHuntYT/coordination/evidence/P010-pause-menu-after-ultrawide.png) | 2560x1080 | 21:9 ultrawide aspect ratio centering and anchor validation |
| [P010-leave-confirm-client-1080p.png](file:///G:/Unreal%20Projects/SheeshhPropHuntYT/coordination/evidence/P010-leave-confirm-client-1080p.png) | 1920x1080 | Confirmation modal showing Client copy |
| [P010-leave-confirm-host-1080p.png](file:///G:/Unreal%20Projects/SheeshhPropHuntYT/coordination/evidence/P010-leave-confirm-host-1080p.png) | 1920x1080 | Confirmation modal showing Host disconnect warning copy |
| [P010-leave-confirm-leaving-1080p.png](file:///G:/Unreal%20Projects/SheeshhPropHuntYT/coordination/evidence/P010-leave-confirm-leaving-1080p.png) | 1920x1080 | Confirmation modal showing "Leaving session..." progress state |
