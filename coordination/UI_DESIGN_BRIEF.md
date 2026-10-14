# UI Design Direction - Prop Hunt Arcade

Owner: Codex. Implementer: Antigravity. Applies to staged UI milestones, not permission to modify all widgets in one task.

## Visual system
Aim for a polished competitive arcade game: charcoal/navy backdrop (#101522), elevated panels (#1C2434), warm white text (#F4F6FA), cyan prop accent (#27D8E8), orange hunter accent (#FF9347), and restrained red for danger. Use accents purposefully rather than neon on every surface. Bold, readable headings; regular-weight readable labels; consistent spacing on an 8-unit grid. Reuse existing licensed/local fonts or Unreal defaults until a font choice is supplied; do not download/install assets.

Large clear primary actions, soft panel corners, subtle borders and shadows, compact role badges, map artwork from existing assets. Use translucent panels only where text stays legible. Keep gameplay visible behind pause/HUD. No excessive blur, flashing, particle backgrounds or expensive per-frame UI logic.

## Interactions
Hover/focus: brighter border and slight emphasis (up to 1.02 scale). Press: quick visual compression. Transitions: 120-180ms fade/slide. Keyboard/gamepad focus must receive the same clarity as hover; enabled controls have predictable navigation. Honor existing reduced-motion settings if available; otherwise animations must remain subtle and optional in the design. Disabled items read as unavailable, never as clickable. Async session operations have progress, success/error and retry states; prevent duplicate submissions. No technical debug strings in player UI.

## Screen directions
- Boot/home: strong game title, central PLAY action, Host/Join secondary actions, Settings and Quit with clear hierarchy. Attractive existing Map1 imagery, clean player-name area, compact connection status.
- Host/lobby: focused configuration card, Map1 artwork/name, player-slot/role controls, clear Create/Start actions, player roster and ready state using actual supported game data. Do not invent functionality.
- Server browser: readable rows with server name, player count, ping and one clear Join action; searching/loading/empty/error states and Refresh. Keep direct-IP entry available but secondary.
- HUD: centered dominant round timer, small role chip, clean health presentation, prop-change count for props and weapon feedback for hunters. Feedback for hit, damage and role assignment without obscuring aiming. Use actual bound data.
- Pause: Resume primary, Settings secondary, Leave Session clearly separated, Quit Game last. Role/session context panel. Leave confirmation for host explains that connected players will disconnect. Visible leaving progress and actionable failure state.
- Settings: grouped tabs for graphics/audio/input using actual supported settings, readable labels and values, obvious Apply/Back with preserved persistence.
- Results: clear winning team, role-color treatment, concise actual match data, and existing supported next-round/menu actions. Do not add fake scores or progression.
- Errors/disconnect: plain player-facing explanation, return to menu/retry as supported; no raw stack traces.

## Quality gates
Inventory and screenshots of actual widgets before replacing layouts. Preserve public functions, graph bindings, variable names and gameplay/session behavior unless task explicitly changes them. Verify 1280x720, 1920x1080 and ultrawide layout with safe anchors/DPI; controller/keyboard focus, long player/server names, disabled/loading/error states. Compile, back up before saving, capture real before/after screenshots and test flows. Each task names exact assets and functional changes. Never claim screenshots/mockups are implemented UI.

## Implementation order
P010: redesigned pause menu plus missing Leave Session and cleanup validation.
Then home/host/server browser, HUD/results, and settings/error states in reviewable tasks. Packaged menu-host/discovery/cleanup validation follows the functional changes. More Map1 props, music and online/voice/performance remain later phases. Map2/Map3 remain excluded.
