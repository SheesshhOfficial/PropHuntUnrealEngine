# Figma Game Workflow and Annotated Feature Atlas — Master Content

**Document Version:** 1.0 (Task P015)  
**Date:** 2026-10-12 (Asia/Calcutta)  
**Product Working Name:** Sheeshh Prop Hunt (`SheeshhPropHuntYT`)  
**Engine & Target:** Unreal Engine 5.7 (Win64 Development)  
**Design Palette:** Deep Navy (`#101827`), Slate (`#243248`), Vivid Cyan (`#30D5E8`), Warm Orange (`#FFAD59`), Debug Violet (`#B69CFF`), Background Tint (`#0B0F19`), Crisp Paper (`#F4F7FB`), Muted Body (`#AFC0D4`).

---

## 1. Frame-by-Frame Structure & Content

### Page 00: Cover, Overview & Journey Map

#### Frame 00.01: Cover & Presentation Header
- **Frame Title:** `00.01 Cover: Sheeshh Prop Hunt Player Journey & Feature Atlas`
- **Typographic Lockup:** 
  - Eyebrow: `UNREAL ENGINE 5.7 MULTIPLAYER ACTION`
  - Title: `SHEESHH / PROP HUNT`
  - Subtitle: `Hide in plain sight. Hunt before time runs out.`
- **Metadata Card:**
  - **Working Title:** Sheeshh Prop Hunt (`SheeshhPropHuntYT`)
  - **Author:** Antigravity (Pair Programming with Codex & Project Owner)
  - **Date:** 2026-10-12 (Asia/Calcutta)
  - **Build Target:** Win64 Development Editor (`SheeshhPropHuntYTEditor`)
- **Role Badges:**
  - `[HUNTER SQUAD - Hitscan Armed Seekers]` (Orange accent `#FFAD59`)
  - `[PROP TEAM - Environmental Mimics]` (Cyan accent `#30D5E8`)
- **Hero Image Slot:** `IMG-00-HERO` (1600x900 placeholder: Cinematic perspective of Map1 Egyptian courtyard with disguised prop and aiming hunter).

#### Frame 00.02: What is the Game?
- **Frame Title:** `00.02 What is the Game? Core Loop & Scope`
- **Pitch Statement:**
  An arcade multiplayer hide-and-seek action game developed in Unreal Engine 5.7. A squad of Hunter players armed with hitscan rifles searches a multi-level ancient Egyptian courtyard (`Map1`) to distinguish living disguised players from static background objects before the round timer reaches zero. Props transform into everyday environmental items, freeze their rotation, and taunt hunters to survive.
- **Two Core Roles:**
  - **Props (Hiders):** Turn into pots, crates, columns, or pylons. Blend seamlessly into architecture using rotation locks.
  - **Hunters (Seekers):** Scout rooms, line up hitscan shots, and coordinate search lines. Health penalty or missed shot costs discourage blind shooting.
- **Current Scope & Evidence Legend:**
  - `[USER-TESTED]`: Verified by owner playtesting (Round timer lifecycle, hide/find mechanics).
  - `[INDEPENDENTLY VERIFIED]`: Inspected via static analysis, PIE execution, or code audits.
  - `[REPORT-ONLY]`: Historical assertions from earlier task reports without fresh independent runtime proof.
  - `[PLANNED]`: Approved future roadmap items (Steam OSS, VOIP, additional props).
  - `[EXCLUDED]`: Permanently excluded from scope (Map2 and Map3 restoration).
  - `[GAP]`: Areas where automation is unavailable (physical keyboard strikes).

#### Frame 00.03: Full Player Journey Map
- **Frame Title:** `00.03 Complete Player Journey & Branching Pathways`
- **Architectural Flow:**
  ```
  [Game Launch] ──► [Boot_Lvl / WBP_MainMenu]
                           │
             ┌─────────────┼─────────────┬───────────────────────────┐
             ▼             ▼             ▼                           ▼
        [Host Game]   [Find Game]   [Settings UI]               [Quit Game]
             │             │             │
             │             ▼             ├─ Video (DX12 / 6 Rows)
             │      [Server Browser]     ├─ Audio (Master/Music/SFX)
             │             │             ├─ Controls (Sensitivity)
             │             ▼             └─ Apply / Discard Cycle
             │      [Join Session]
             ▼             ▼
        [Travel to Map1 (Listen Server)]
             │
             ├───────────────────────────────────────────────────────┐
             ▼                                                       ▼
      [HUNTER LANE]                                             [PROP LANE]
      • Spawn & Blind Hold                                      • Spawn & Disperse (30s)
      • Search & Aiming                                         • Inspect & IA_ChangeProp
      • Hitscan Shooting                                        • Lock Orient: IA_RotationLock
      • Eliminate Props                                         • Bait Cues: IA_Taunt
             │                                                       │
             └───────────────────────┬───────────────────────────────┘
                                     ▼
                          [Match Round Lifecycle]
                          (Timed Hide/Seek Loop)
                                     │
           ┌─────────────────────────┴─────────────────────────┐
           ▼                                                   ▼
     [Pause Branch]                                      [Developer Debug]
     • WBP_Menu (Esc)                                    • WBP_DeveloperDebugPanel (~)
     • Resume / Leave                                    • Host-Only Action Gates
     • DestroySession                                    • Singleton Input Restore
           │                                                   │
           └─────────────────────────┬─────────────────────────┘
                                     ▼
                          [Round Win / Loss Outcome]
                          • Prop Victory (Time 00:00)
                          • Hunter Victory (All Props Eliminated)
                          • Return to Boot_Lvl
  ```

---

### Page 01: Launch, Hosting & Session Discovery

#### Frame 01.01: Start Screen & Main Menu Breakdown
- **Frame Title:** `01.01 Main Menu Presentation & Control Annotations`
- **Screen Display:** `P011-R2-menu-1080p.png` (Labeled: *Historical asset preview — earlier presentation, not current live acceptance*).
- **Numbered Control Pointers:**
  - **(1) Host Game Button (`Btn_HostGame`):** Initializes local listen server session via `MenuGameinstance::HostSession` and executes seamless travel to `Map1`.
  - **(2) Find Game Button (`Btn_FindGame`):** Navigates to the Server Browser panel (`WBP_ServerList`) to query active sessions via Null Online Subsystem.
  - **(3) Settings Button (`Btn_Settings`):** Opens the multi-tab preferences overlay for Video, Audio, Controls, and Cosmetics.
  - **(4) Player Name Input (`EditableText_PlayerName`):** Local profile text input; sets player alias in session metadata (Note: not an authentication login).
  - **(5) Quit Game Button (`Btn_QuitGame`):** Exits the game application cleanly to desktop.

#### Frame 01.02: Host Game Configuration & Map Routing
- **Frame Title:** `01.02 Host Session Flow & Map1 Routing`
- **Behavior & Wiring:**
  - Default map set to `/Game/resources/Stylized_Egypt/Maps/map1` in `Config/DefaultEngine.ini`.
  - Maps 2 and 3 are explicitly disabled and excluded.
  - Host triggers `MenuGameinstance` which opens map with `?listen` parameter.
- **Image Slots:**
  - `IMG-01-HOST-CONFIG` (960x540 placeholder: Host session creation dialog and listen server launch).
  - `IMG-01-HOST-SUCCESS` (960x540 placeholder: Host spawned into Map1 waiting room).

#### Frame 01.03: Server Browser & Session Joining
- **Frame Title:** `01.03 Server Browser & Null OSS Discovery`
- **Screen Display:** `P011-R2-browser-1080p.png` (Labeled: *Historical asset preview — earlier server browser presentation*).
- **Numbered Control Pointers:**
  - **(1) Refresh Button:** Sends asynchronous `FindSessions` query to local network.
  - **(2) Server List Scroll Box:** Populates available sessions using `WBP_Server` row widgets.
  - **(3) Server Row Entry:** Displays Host Name, Map (`Map1`), Player Count, and Ping.
  - **(4) Join Button:** Executes `JoinSession` via `MenuGameinstance` and connects client to host IP.
  - **(5) Back Button:** Discards query and returns cleanly to main menu.
- **Image Slot:** `IMG-01-JOIN-FAIL` (960x540 placeholder: Connection failure / timeout feedback notification).

#### Frame 01.04: Transition to Map1
- **Frame Title:** `01.04 Loading & Match Spawn Transition`
- **Behavior:**
  - Seamless level transition from `Boot_Lvl` to `Map1.umap`.
  - GameMode (`GM_ProphuntGameMode`) initializes player controller and assigns initial team roles.
- **Image Slot:** `IMG-01-SPAWN-TRANSITION` (960x540 placeholder: Initial spawn in Map1 spawn room prior to round start).

---

### Page 02: Hunter Gameplay Journey

#### Frame 02.01: Hunter Role Overview & HUD Layout
- **Frame Title:** `02.01 Hunter Squad: Role Objective & HUD Anatomy`
- **Role Objective:**
  Search the map, distinguish living props from static scenery, and eliminate all props using hitscan weapons before the round timer expires.
- **Character Asset:** `BP_ThirdPersonCharacter` (StormTrooper skeletal mesh).
- **HUD Annotations (Planned / To Verify):**
  - **Timer Indicator:** Displays remaining round time counting down from hide phase to seek phase.
  - **Hunter Health / Ammo:** Weapon ammunition count and current player integrity.
  - **Crosshair / Reticle:** Center-screen hitscan targeting reticle.
  - **Alive Props Counter:** Number of surviving enemy props remaining in the match.
- **Image Slot:** `IMG-02-HUNTER-HUD` (960x540 placeholder: Hunter POV with visible HUD, ammo counter, and reticle).

#### Frame 02.02: Search & Aiming Mechanics
- **Frame Title:** `02.02 Search Tactics & Aim Sensitivity Response`
- **Controls & Input:**
  - `IA_Move` (WASD / Left Stick): Traversal across multi-level courtyards, staircases, and corridors.
  - `IA_Look` (Mouse / Right Stick): Responsive camera aiming.
  - `IA_Jump` (Spacebar): Obstacle vaulting and vertical positioning.
- **Verified Sensitivity Response:**
  Codex takeover verified live Aim yaw delta scaling: yaw delta of 5 at sensitivity 0.2, scaling to 20 at sensitivity 0.8 (exact 4x linear scaling response matching user settings).
- **Image Slot:** `IMG-02-HUNTER-AIM` (960x540 placeholder: Hunter aiming down sights across Map1 courtyard).

#### Frame 02.03: Hitscan Shooting & Dealing Damage
- **Frame Title:** `02.03 Hitscan Fire & Damage Feedback Loop`
- **Action Sequence:**
  1. **Aim Target:** Align crosshair onto suspected prop.
  2. **Execute Shot (`IA_shoot`):** Weapon performs hitscan line trace from muzzle socket forward.
  3. **Hit Confirmation:** Impact particle/decal spawns on hit object.
  4. **Damage Dealing:** If object is `BP_propChar`, deductions are made from prop health pool.
- **Image Slots (Matched Feature Sequence):**
  - `IMG-02-SHOOT-AIM` (800x450 placeholder: Hunter crosshair centered on suspicious pot).
  - `IMG-02-SHOOT-FIRE` (800x450 placeholder: Muzzle flash and tracer impact on prop).
  - `IMG-02-SHOOT-DAMAGE` (800x450 placeholder: Prop taking damage / hit reaction effect).

#### Frame 02.04: Damage Received & Elimination
- **Frame Title:** `02.04 Hunter Hazards & Miss Penalties`
- **Mechanics:**
  - Shooting static environmental clutter (non-props) inflicts weapon recoil penalties or minor health deductions to prevent continuous blind firing.
- **Image Slot:** `IMG-02-HUNTER-DAMAGE` (960x540 placeholder: Hunter receiving miss penalty / environmental feedback).

#### Frame 02.05: Hunter Round Outcomes
- **Frame Title:** `02.05 Hunter Victory & Defeat Conditions`
- **Conditions:**
  - **Victory:** All props eliminated before round expiration [USER-TESTED].
  - **Defeat:** Round timer reaches 00:00 while at least one prop survives [USER-TESTED].
- **Image Slot:** `IMG-02-HUNTER-VICTORY` (960x540 placeholder: Hunter victory banner / match summary screen).

---

### Page 03: Prop Gameplay Journey

#### Frame 03.01: Prop Role Overview & Survival Goals
- **Frame Title:** `03.01 Prop Team: Mimicry & Survival Objective`
- **Role Objective:**
  Disguise as everyday scene objects, blend into environment architecture, freeze orientation, taunt hunters, and survive until round expiration.
- **Character Asset:** `BP_propChar` with replicated static mesh actor `BP_SPawnedProp`.
- **Prop Catalog:** 55 fully resolved static meshes (Egyptian pottery, pylons, barrels, crates, urns).
- **Image Slot:** `IMG-03-PROP-HUD` (960x540 placeholder: Prop POV showing change count, rotation-lock indicator, and taunt prompt).

#### Frame 03.02: Before & After Transformation Sequence (Matched Pair)
- **Frame Title:** `03.02 Prop Transformation: Before & After Sequence`
- **Matched Pair Contract:**
  Side-by-side comparison captured from the exact same camera angle, showing the default humanoid pawn transforming into an environmental asset.
- **Matched Slots:**
  - `IMG-03-TRANSFORM-BEFORE` (800x450 placeholder: Prop character in default humanoid form standing beside an Egyptian urn).
  - `IMG-03-TRANSFORM-AFTER` (800x450 placeholder: Prop character transformed into the identical Egyptian urn at the exact same location).
- **Trigger Mechanic:** Aim crosshair at valid static mesh in map and trigger `IA_ChangeProp`.

#### Frame 03.03: Hiding Tactics & Rotation Lock
- **Frame Title:** `03.03 Positioning, Blending & Rotation Lock`
- **Mechanics:**
  - `IA_RotationLock`: Freezes the prop mesh's world rotation in place, allowing the player to freely orbit the third-person camera without rotating the disguised object and alerting hunters.
- **Image Slot:** `IMG-03-ROTATION-LOCK` (960x540 placeholder: Disguised prop locked against a wall while camera pans freely).

#### Frame 03.04: Audio Taunts & Risk Mechanics
- **Frame Title:** `03.04 Audio Taunts & Baiting Hunters`
- **Mechanics:**
  - `IA_Taunt`: Emits spatial audio cues (`funny-cat-meow`, `hehehe-chuckle`, `taunt-robotic-voice`).
  - Rewards survival score while revealing approximate position to nearby seekers.
- **Image Slot:** `IMG-03-TAUNT-CONTEXT` (960x540 placeholder: Disguised prop taunting while hunter walks past in background).

#### Frame 03.05: Prop Damage & Destruction
- **Frame Title:** `03.05 Prop Damage Reactions & Destruction`
- **Mechanics:**
  - Disguised props take hitscan damage from hunters. When health pool is exhausted, prop shatters with explosion particles (`P_Explosion`).
- **Image Slot:** `IMG-03-PROP-DAMAGE` (960x540 placeholder: Disguised prop hit reaction and destruction).

#### Frame 03.06: Prop Round Outcomes
- **Frame Title:** `03.06 Prop Victory & Survival Conditions`
- **Conditions:**
  - **Victory:** Timer hits 00:00 with at least 1 prop alive [USER-TESTED].
  - **Defeat:** All props eliminated by hunters before time runs out [USER-TESTED].
- **Image Slot:** `IMG-03-PROP-VICTORY` (960x540 placeholder: Prop victory screen / round completion celebration).

---

### Page 04: Pause Menu & Settings Architecture

#### Frame 04.01: In-Game Pause Menu
- **Frame Title:** `04.01 Pause Menu & Session Teardown Flow`
- **Screen Display:** `P010-R1-pause-menu-1080p.png` (Labeled: *Historical capture — earlier pause/leave screen, consult P010 review*).
- **Numbered Control Pointers:**
  - **(1) Resume Button:** Closes pause overlay and restores gameplay input mode.
  - **(2) Settings Button:** Opens the full Settings panel over active gameplay.
  - **(3) Leave Session Button:** Triggers confirmation dialog -> `DestroySession` -> returns player to `Boot_Lvl` cleanly [VERIFIED P010-R1].

#### Frame 04.02: Settings Architecture & Navigation Rail
- **Frame Title:** `04.02 Settings Navigation & Transactional Persistence`
- **Layout:** Redesigned by Codex in P013-R3. Features left category rail, central option cards, and persistent bottom Apply/Discard footer.
- **Categories:** Controls, Audio, Video, Cosmetics.

#### Frame 04.03: Controls Settings & Sensitivity
- **Frame Title:** `04.03 Controls Category: Camera Sensitivity & Keybinds`
- **Inspected Controls:**
  - `SLIDER_CameraSensitivity`: Normalized float slider (tested values 0.2 to 0.8 producing exact 4x linear yaw response; UI slider bounds subject to asset check).
  - `Txt_SensitivityValue`: Live numeric readout displaying formatted sensitivity value.
  - Connected directly to `BP_SettingsSaveGame` and consumed dynamically by both Hunter and Prop pawns.
- **Image Slot:** `IMG-04-SETTINGS-CONTROLS` (960x540 placeholder: Controls settings tab with sensitivity slider and numeric readout).

#### Frame 04.04: Audio Settings & Sound Routing
- **Frame Title:** `04.04 Audio Category: Volumes & SoundMix Classes`
- **Screen Display:** `Codex-settings-live.png` (Labeled: *Current live Settings audio; direct Codex takeover*).
- **Numbered Control Pointers:**
  - **(1) Music Volume Slider:** `SC_Music` sound class multiplier with live numeric percentage readout.
  - **(2) SFX Volume Slider:** `SC_SFX` sound class multiplier with live numeric percentage readout.
  - **(3) Discard Button:** Restores sliders back to baseline committed values.
  - **(4) Apply Button:** Commits values to `BP_SettingsSaveGame` on disk (`settings.sav`).
- **Qualification:** Mathematical mix gain updates and PIE persistence verified; subjective audibility requires user music asset selection. Master volume control is not present in the inspected live UI.

#### Frame 04.05: Video Settings & 720p Responsive Scaling
- **Frame Title:** `04.05 Video Category: DX12 Graphics Presets & Scaling`
- **Screen Display:** `Codex-settings-video-live.png` (Labeled: *Current live Settings video; direct Codex takeover*).
- **Numbered Control Pointers:**
  - **(1) Overall Graphics Quality:** Global preset (Low, Medium, High, Epic, Cinematic).
  - **(2) Individual Quality Rows:** Resolution Scale, Shadows, Foliage, Textures, Post-Processing, Anti-Aliasing.
  - **(3) Display Controls:** Window Mode (Fullscreen, Borderless, Windowed) and VSync toggle.
  - **(4) Responsive Guarantee:** All 6 rows fit cleanly within a 720p viewport without scrolling or clipping [VERIFIED].

#### Frame 04.06: Cosmetics & Profile Settings
- **Frame Title:** `04.06 Cosmetics Category: Character Customization Status`
- **Inspected Status:**
  - Category tab exists in `WBP_MainMenu`. Shows skin / mesh selection options.
  - Documented as work-in-progress; no invented shop or microtransaction features claimed.
- **Image Slot:** `IMG-04-SETTINGS-COSMETICS` (960x540 placeholder: Cosmetics menu tab showing character customization).

#### Frame 04.07: Apply vs. Discard Transactional State
- **Frame Title:** `04.07 Transactional Persistence: Apply & Discard Lifecycle`
- **Three-State Transactional Flow:**
  - **State A (Saved / Baseline):** Loaded on panel Construct from `BP_SettingsSaveGame` / `GameUserSettings`.
  - **State B (Dirty / Edited):** Moving any slider toggles dirty flag and updates numeric label; Discard button active.
  - **State C (Committed / Applied):** Apply serializes to `settings.sav` and propagates live sensitivity to spawned pawns.
- **Image Slot:** `IMG-04-APPLY-DISCARD-FLOW` (960x540 placeholder: Visual diagram of dirty state transition).

#### Frame 04.08: Session Leave & Teardown Flow
- **Frame Title:** `04.08 Session Teardown & Return to Boot_Lvl`
- **Execution Path:**
  - Player clicks Leave -> Confirmation modal displays -> `MenuGameinstance::DestroySession` executes -> Seamless return to `Boot_Lvl.umap`.
  - Audited in P010-R1: Zero orphaned widgets or memory leaks.

---

### Page 05: Developer Debug Tools

#### Frame 05.01: Debug Identity & Security Boundaries
- **Frame Title:** `05.01 Developer Debug Panel: Security & Boundaries`
- **Screen Display:** `Codex-debug-1920-preview.png` (Labeled: *Final Debug layout; asset preview — preview is not live host proof*).
- **Visual Identity:** Purple / Violet accent theme (`#B69CFF`) to distinguish internal QA tools from player settings.
- **Security & Authority Architecture:**
  - **Compile-Time Shipping Guard:** `UDebugMenuLib::IsDeveloperDebugAllowed()` returns `false` unconditionally in Shipping builds (`UE_BUILD_SHIPPING=1`).
  - **Host Authority Check:** Gated strictly to local authoritative player controller (`HasAuthority() && IsLocalPlayerController()`).
  - **Denial Feedback:** Inactive matches, `Boot_Lvl`, or remote clients display explicit status: `"Disabled: Active gameplay match required on server host"`.

#### Frame 05.02: Diagnostic Telemetry Readouts
- **Frame Title:** `05.02 Live Hardware & Session Telemetry`
- **Numbered Telemetry Readouts:**
  - **(1) Framerate / Frame Time:** Real-time FPS and millisecond frame timing.
  - **(2) Current Map:** Displays active level (`Boot_Lvl` vs. `Map1`).
  - **(3) Network Mode & Role:** NetMode (Listen Server, Client, Standalone) and Engine Role (`Authority` vs. `AutonomousProxy`).
  - **(4) Player Count & Ping:** Active connected players from `GameStateBase::PlayerArray` and network ping.
  - **(5) Build Configuration:** Active executable configuration (`Development` vs. `Shipping`).

#### Frame 05.03: Server Host Action Controls
- **Frame Title:** `05.03 Host Action Controls & Bounds Enforcement`
- **Screen Display:** `Codex-debug-live.png` (Labeled: *Debug runtime context before final header/width adjustments*).
- **Numbered Control Pointers:**
  - **(1) Hunter Count Commit (`Btn_CommitHunterCount`):** Clamped server-side strictly between `1` and `PlayerCount - 1`. Prevents locking out props.
  - **(2) Server Prop Action (`Btn_ServerPropAction`):** Authoritatively transforms the host pawn into `BP_propChar`.
  - **(3) Server Hunter Action (`Btn_ServerHunterAction`):** Transforms the host pawn into Hunter.
  - **(4) Start Round Action (`Btn_StartRound`):** Two-click confirmation flow (first click arms, second click force-starts round); permanently disables once started.
- **Caller Audit:** Audited all callers in `BP_ThirdPersonPlayerController`; normal gameplay HUD and characters never invoke these debug RPCs.

#### Frame 05.04: Singleton Management & Input Restoration
- **Frame Title:** `05.04 Singleton Controller & Slate Input Restoration`
- **Mechanics:**
  - Singleton widget owned by `BP_ThirdPersonPlayerController`.
  - Toggling debug caches prior Slate mouse cursor visibility and restores it cleanly upon close.
  - Input routing bound to `ToggleDeveloperDebug` (`~` Tilde key); console redirected to `F10`.
  - Technical caveat: Physical keyboard hardware acceptance remains a manual gate.

---

### Page 06: Reference, Roadmap & Acceptance

#### Frame 06.01: Feature Status & Verification Atlas
- **Frame Title:** `06.01 Feature Status Atlas & Verification Standards`
- **Comprehensive Status Table:**
  - Round Lifecycle: `[USER-TESTED]` (Accepted by project owner).
  - Prop Transformation (55 Catalog): `[INDEPENDENTLY VERIFIED]` (Resolved & verified).
  - Hunter Hitscan & Aim: `[INDEPENDENTLY VERIFIED]` (4x sensitivity delta verified).
  - Map1 Routing: `[INDEPENDENTLY VERIFIED]` (DefaultEngine.ini listen server routing).
  - Settings UI & Persistence: `[INDEPENDENTLY VERIFIED]` (PIE roundtrip and 720p scaling).
  - Developer Host Tools: `[INDEPENDENTLY VERIFIED]` (Dynamic host gates & clamp logic).
  - Session Teardown: `[INDEPENDENTLY VERIFIED]` (Clean DestroySession verified).
  - Physical Keyboard Acceptance: `[GAP]` (Graph verified; hardware strike unverified).
  - Packaged Shipping Build: `[REPORT-ONLY]` (P009 historical cook exit 0; fresh run pending).
  - Background Music Asset: `[GAP]` (Routing verified; audio track pending user choice).

#### Frame 06.02: Future Roadmap & Boundaries
- **Frame Title:** `06.02 Development Roadmap & Strict Boundaries`
- **Approved Future Milestones:**
  - Additional transformable props in Map1.
  - User resolution of background music track.
  - Steam Online Subsystem & internet matchmaking (AppID 480).
  - In-game voice communications (VOIP).
- **Strict Scope Exclusions:**
  - Map2 and Map3 restoration (Permanently excluded by user direction).
  - Unverified feature claims (README treated as intent, not proof).

#### Frame 06.03: Photo Replacement Checklist & Guide
- **Frame Title:** `06.03 Image Placeholder Inventory & Maintenance Guide`
- **Owner Instructions:**
  To replace any placeholder with a real game screenshot:
  1. Capture photo in-game at indicated aspect ratio / resolution.
  2. Select the placeholder card (`IMG-...`).
  3. Paste photo directly into the image fill layer.
  4. Hide or delete the instructions overlay subgroup.
- **Complete Placeholder Count:** 18 curated image slots.

---

### Page 99: Design System Components & Reusable Cards

#### Frame 99.01: Typography, Color Palette & Badges
- **Display Swatches:** Deep Navy (`#101827`), Slate (`#243248`), Cyan (`#30D5E8`), Warm Orange (`#FFAD59`), Debug Violet (`#B69CFF`), Paper (`#F4F7FB`), Text Muted (`#AFC0D4`).
- **Typography Ramp:** Display Title (48px), Section Header (32px), Card Subhead (22px), Body Copy (16px), Caption/Footnote (13px).
- **Status Chips:** `[USER-TESTED]`, `[INDEPENDENTLY VERIFIED]`, `[REPORT-ONLY]`, `[PLANNED]`, `[EXCLUDED]`, `[GAP]`.

#### Frame 99.02: Numbered Callout & Arrow Components
- **Callout Pattern:** Numbered circular indicator (1-5) + Control Name + Concise Purpose + Resulting State + Status Badge.
- **Connector Styling:** Solid cyan for player navigation; solid orange for combat actions; dotted violet for developer debug routes.

#### Frame 99.03: Reusable Image Placeholder Card
- **Specification:** Dark slate card (`#1e293b`), dashed border (`#475569`), camera glyph, bold `IMAGE TO ADD` title, alt-description, required dimensions, and capture instructions.
