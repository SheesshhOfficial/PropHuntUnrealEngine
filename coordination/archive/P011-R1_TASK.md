# Task P011-R1 - Finish menu presentation and verify actual flows

Status: READY
Owner: Antigravity
Reviewer: Codex

## Goal
Correct the visible P011 design and evidence gaps. Deliver a genuinely usable polished home/host/browser and prove normal advertised host/discovery/join still works.

## Read first
AGENTS.md, PROJECT.md, UI_DESIGN_BRIEF.md, coordination/archive/P011_REPORT.md, P011 screenshots and P010-R1 session evidence.

## Observed review findings
P011-menu-1080p shows blank/unlabeled input controls, a distracting purple city background, no real Map1 preview image and technical 'LISTEN & ADVANCED SESSIONS' text. Fixed '5 MINUTE' and '2-5' rules are not established by current runtime settings (prior timer was 5:30). P011-live-pie-menu is black. Hash evidence truncates file paths. Session lifecycle document describes static wiring, not actual timestamped regression tests. Host click now removes every widget before async creation; failure may leave no usable menu and duplicate submissions are not substantiated.

## Allowed product scope
Content/Core/Widgets/WBP_Menu.uasset and Content/Core/Widgets/WBP_Server.uasset only; new small presentation/status widgets under Content/Core/Widgets/ if needed and inventoried. Do not edit core session GameInstance, controller, pause/HUD/settings/maps/source/config/plugins. Back up/hash-verify all affected assets in a unique directory before editing; preserve existing backups/evidence and unsaved work.

## Design corrections
1. Home: title/header, clear Host Game and Find Game primary choices, player-name area and Map1 artwork. Use a genuine existing Map1 scene image/asset rather than city media as the featured map; creating a presentation texture from a native Map1 capture is allowed, without editing the map. Darken/simplify the background so foreground hierarchy is clear. Use actual displayed player name; retain bindings.
2. Put host configuration in its own readable panel with explicit Server Name, Players and Map labels, visible current values/defaults, adequate 44px-equivalent interactive heights, and Back. Map1 is the only map. Avoid a stack of unexplained empty boxes. Direct IP is a labeled secondary field/action. Settings/Quit navigation must remain reachable if already supported; do not invent new settings logic.
3. Browser: real name/players/ping row headings, clear Refresh/Back, scoped Join progress and empty/searching/error states. Remove developer wording and unsupported rules/claims. Display verified runtime-derived rules only, or omit those facts entirely. No fake server rows in verification evidence.
4. Keep cyan/orange accents and dark navy panels, but obtain colors from actual runtime renders rather than claiming hex colors alone establish quality. Responsive focus/hover/press states and short native transitions required; retain keyboard navigation.

## Functional corrections and tests
5. Inspect Host click->Remove All Widgets->GameInstance call. Do not leave user without UI during async failure. Within scoped widget logic, provide clear pending/progress and recoverable failure/back state and lock duplicate submissions; use actual available existing callbacks/state. If failure recovery requires a core GameInstance change outside scope, document exact proposed change and mark that item blocked rather than silently broaden scope. Preserve session flags, server name/slots and normal Map1 travel.
6. Run actual two-player advertised CreateAdvancedSession flow using HOST GAME, then client's browser discovery and returned row JOIN. Record timestamped raw outputs/world/session/player evidence and test server name/slots data. Re-test Leave/rehost via the implemented pause action. Graph wiring, starting PIE or direct IP connection alone is not a regression pass.
7. Test host/back, search empty/loading/results/failure where safely reachable, long server name, keyboard focus and direct-IP path as separately labeled diagnostic. Never delete/set session state to fake outcomes. Gamepad unavailability explicit.
8. Capture actual visible runtime screenshots at 720p/1080p/ultrawide for home/host/browser. A black frame or design-time render cannot prove runtime UI. Use supported capture including Slate; if only separate layers are possible, label composites and explicitly exclude live layering/input claims. Preserve original black capture and explain its failure; don't rename/render mockups as live proof.
9. Write machine-readable full absolute/relative path SHA256 manifests (JSON/CSV, no formatted table truncation). Independently compare baseline/final and backup hashes. If original evidence lacks complete paths, record that limit; do not invent it. Compile/save scoped assets, retain graph/property diffs and exact tool results.
10. Stop task-owned sessions and restore settings/map safely. Save P011-R1 evidence and replace implementation report. Do not proceed to HUD until review.

## Acceptance checks
- Inputs labeled with usable defaults; home shows actual Map1 art and clear navigation; technical/unverified rule copy removed.
- Browser real loading/empty/error/results states and focus behavior evidenced; responsive layouts readable.
- Actual named-session host/discovery/join and leave/rehost logs prove preserved flows; pending/failure/duplicate states explicit.
- Native runtime images genuinely show the UI; capture/provenance limits disclosed.
- Verified backups, untruncated hashes and changed-asset inventory; no compile errors or unrelated edits.

## Required report
P011-R1 using REPORT_TEMPLATE.md. COMPLETE only when design and real session regressions pass; PARTIAL for remaining failed/unavailable checks; BLOCKED if safe editing cannot start. Stop for Codex review.
