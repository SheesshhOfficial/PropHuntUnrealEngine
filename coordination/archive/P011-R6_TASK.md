# Task P011-R6 - Verify real menu interactions and live presentation

Status: READY
Owner: Antigravity
Reviewer: Codex

## Goal
Close remaining menu acceptance evidence after accepted P011-R5 serialization/Join fixes. Read AGENTS.md, PROJECT.md, coordination/UI_DESIGN_BRIEF.md and coordination/evidence/P011-R5-CODEX_REVIEW.md. User review-and-proceed authorizes one verification attempt plus final review; no HUD implementation.

## Scope
Verification and coordination/evidence/report files only. Do not modify/resave product assets, maps, config/source/plugins or existing backups. No installs/commits/pushes. Preserve unsaved user work and stop only task-owned sessions. Existing supported Unreal tooling may launch PIE and restore original play settings/map.

## Checks
1. Establish available supported Slate/viewport input and capture capabilities. Use actual pointer/keyboard events through supported editor/UI tooling, not OnClicked broadcasts/direct GameInstance calls. Physical HID driver telemetry or video is not required. If tooling lacks normal input/capture, document the actual attempted supported action and returned error; do not invent driver/crash claims. Continue independent checks, then stop PARTIAL with a concise interactive playtest checklist rather than rerun identical diagnostics or redesign assets.
2. Actual home/host/player-name/navigation including Back, browser Refresh/Back, keyboard focus, long names, pending/empty/error/results presentation. Verify immediate search Back/reopen via normal input if possible. Verify normal enabled Host -> actual returned server-row Join -> pause Leave/confirmation -> returned enabled Host. Diagnostic R5 cycles already accepted; repeat only needed normal-interaction gates.
3. Native live still screenshots at 1280x720,1920x1080,2560x1080 showing home/host/browser with provenance and actual UI layering. Single-client live captures may independently validate presentation when multi-client capture is unavailable. No preview/mockup/composite as live proof; preserve originals.
4. Safely reachable genuine host/join/search failure and retry with clear user feedback and returned controls; do not fake OSS state, delete sessions or force test properties. Record unavailable real failures explicitly. Distinguish callback-only diagnostics.
5. Inventory current assets/hashes to verify no product changes, record exact actions/outcomes/raw logs. Restore settings/map safely and write IMPLEMENTATION_REPORT.md for P011-R6 using template. COMPLETE only with carried-forward gates; otherwise PARTIAL/BLOCKED. No claims of full milestone verification.

## Finish
Do not edit task/history or begin another milestone. After all tools/cleanup/report writes, write controller's exact nonce completion marker as final filesystem action, then stop. This marker is required for automated review even when report is PARTIAL; it is not approval.
