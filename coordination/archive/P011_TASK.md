# Task P011 - Redesign home, hosting and server browser

Status: READY
Owner: Antigravity
Reviewer: Codex

## Goal
Replace the boot/menu/server-browser presentation with a cohesive polished arcade interface, preserving working advertised-session creation, discovery and joining. Implement real Unreal widgets, not mockup-only deliverables.

## Read first
AGENTS.md, PROJECT.md, coordination/UI_DESIGN_BRIEF.md, coordination/archive/P010-R1_REPORT.md, P007 host/discovery evidence and REPORT_TEMPLATE.md.

## Scope and product assets
1. Inspect Boot_Lvl widget creation to identify active home/menu wrappers and actual event bindings. Capture current live screenshots, widget trees and relevant graph state. Product scope: Content/Core/Widgets/WBP_Menu.uasset, Content/Core/Widgets/WBP_Server.uasset and Content/Core/Map/UI_Bootlvl.uasset (only if it is the actual boot wrapper). A small new shared button/status widget under Content/Core/Widgets/ is allowed if required and inventoried. Do not edit maps, game instance/session logic, controller, pause/settings/HUD or other gameplay assets. If the active wrapper differs, report it instead of replacing unrelated assets.
2. Record status/input hashes, editor identity and dirty packages; preserve user work. Create unique hash-verified pre-edit backups of all affected assets under coordination/backups/P011-<timestamp>/ before mutations. Export focused binding/graph/widget inventories for review.

## Codex screen design
- Home: cinematic existing Map1 imagery or existing background media, charcoal/navy legibility overlay, a strong PROP HUNT title and small player identity area. Left navigation with PLAY prominent, Host Game/Find Game, Settings and Quit clearly grouped. Large right-side Map1 preview card with concise hide-or-hunt description. No fake ranks, currencies, rewards, map choices or stats.
- Host: focused elevated panel with server name and existing supported slot/player settings. Map1 preview and fixed map selection; cyan Create Session primary, clear Back secondary. Show creating/busy/failure states from actual callbacks and disable duplicate submission. Preserve actual configured session flags and gameplay settings.
- Browser: spacious server panel with server name, players and ping columns. Readable rows, clear Join, Refresh and Back; empty/searching/failure states. Direct-IP connection remains available in a secondary expandable or compact panel. Handle long names/ping/slot values without overlap. Never fill the browser with fake entries as runtime evidence.
- Colors: #101522 base, #1C2434 panels, #F4F6FA text; cyan #27D8E8 for primary/prop identity, orange #FF9347 for hunter accents. Use bold readable typography, consistent 8-unit spacing, restrained rounded cards/borders. The home screen should feel like a game, with map art and visual hierarchy, not a plain centered form.
- Interactions: native hover/press/focus styling, brief 120-180ms panel transitions, loading progress and readable error/retry. Do not add costly per-frame animations or flashing. Keyboard/controller navigation must have explicit focus targets and no traps; preserve cursor/input mode. If controller injection is unavailable, report it rather than claim it tested.

## Implementation and verification
3. Preserve widget variable names/public APIs/event bindings used by gameplay/session code. Refactor layout and visual state only. Loading/error state wiring may connect existing callback outputs within scoped widget graphs; do not change core session logic or silently substitute direct OpenLevel for CreateAdvancedSession.
4. Keep Map1 only. Map2/Map3 remain unavailable; no restoration, new map choices or hidden travel changes. Preserve player name/settings persistence and existing direct-IP behavior.
5. Compile all edited widgets, capture diagnostics, save individually only when valid. Requery persisted layout/style/bindings. Compare focused graphs to ensure session actions and data bindings remain intact.
6. Capture actual runtime UI at 1280x720, 1920x1080 and 2560x1080: home, host ready/busy, browser searching/empty/populated and join/error states when reachable. Prefer a true combined viewport/Slate screenshot; clearly label separate-layer composites and do not use them alone to claim layering/clipping correctness. Do not generate illustration/mockup substitutes. Capture provenance/resolution/state for every image.
7. Exercise normal home navigation, Host creation callback->Map1 listen travel, client Refresh/Find->real server row->Join, direct-IP path as separate diagnostic, Back/settings navigation, and existing pause Leave/rehost. Verify long names and keyboard focus without changing production content. Keep bounded task-owned tests; restore settings and prior map, preserve user sessions.
8. Save exact tool outputs, state screenshots, before/after graph diffs, hash/change inventory, verified backup paths and test matrix under coordination/evidence/P011-*. Finish safe independent checks after failures. No packaged rebuild in this UI milestone; packaged-menu validation remains a required later check.

## Do not change
No source/config/plugins, session GameInstance logic, pause/HUD/settings redesign, map assets, prop tagging, music, installs/downloads, builds/cook/packaging, public online access, global saves, Git operations, task/history/archive edits or backup deletion. Do not invent user-facing functionality/data to make screens look complete.

## Acceptance checks
- Implemented home/host/browser visibly follow the detailed direction with real screen evidence and responsive scaling.
- Existing named-session host/discovery/join bindings and observed flows preserved; async buttons cannot duplicate requests.
- Empty/loading/failure/long-name states clear; keyboard focus usable, controller unavailability explicit.
- Only scoped assets deliberately edited with verified backups; no compile errors; all evidence accurately distinguishes live/composite/untested results.
- Task-owned sessions cleaned up and transient preferences restored; no multiplayer claim based on direct commands alone.

## Required report
Task ID P011 using REPORT_TEMPLATE.md. COMPLETE only when UI and host/discovery/join regression checks pass; PARTIAL for outstanding implementation/testing, BLOCKED if safe editing cannot start. Include actual screenshots for visual review, exact changed assets, backups and diagnostics. Stop for Codex review.
