# Task P007 - Validate Map1 hosting and client joining

Status: REVIEWED_PARTIAL
Owner: Antigravity
Reviewer: Codex

## Goal
Verify actual runtime session creation, listen-server travel to Map1, and a second player's join. Distinguish session/menu flow from direct PIE networking.

## Read first
AGENTS.md, PROJECT.md, coordination/archive/P006_REPORT.md, coordination/REPORT_TEMPLATE.md.

## Scope
1. Record initial status/hashes of core assets/config/source, editor project identity, dirty packages and existing PIE sessions. Preserve unrelated unsaved work; do not stop user-owned play sessions. Record available supported tools and the exact test topology.
2. Run a bounded local test in the current project's UE 5.7 editor using supported PIE/session/UI tooling. Prefer host plus one client in separate game instances; record play mode, process model, player count, actual OnlineSubsystem, and each world's network role. Editor test preferences may be changed transiently only and must be restored. Do not save project config.
3. First test the actual Boot_Lvl host menu or the same public host event invoked by its UI. Observe CreateAdvancedSession success/failure and subsequent OpenLevel travel to Map1 with listen mode. Record menu input/method, callback result, world package, NetMode and server identity. Calling OpenLevel directly does not validate this host flow.
4. Attempt session discovery/join from the second player's normal menu or public event using the existing Null/LAN configuration. Record server-list/session result, join callback, travel result, world package, connection/PlayerState evidence, and host/client views. Direct client connection can be a separately labeled diagnostic fallback, but does not prove session discovery/join works.
5. Check runtime map controls: Map1 selected by default, Map2/Map3 buttons disabled and unable to travel. Verify no active host/session action attempts removed map paths. Observe any NetworkError/TravelError route and logs if they occur; do not manufacture failures with destructive operations.
6. If actual menu session testing is unsupported or single-process PIE restricts discovery, report the limitation precisely. Continue a direct Map1 listen-server plus one client connectivity smoke test if supported, labeled separately. Do not mark the true session flow passed from direct PIE startup.
7. After a successful connection, observe basic two-player spawning/role assignment, one prop transformation if ordinary controls/tooling support it, and visible timer/health HUD state on each side. Record observed values and propagation; do not claim shooting/round lifecycle fully tested. Unsupported interactions are skipped explicitly.
8. Keep sessions bounded (up to five minutes each; one primary attempt plus one justified diagnostic retry). Capture relevant logs, runtime object/network observations, screenshots where helpful and structured per-check results under coordination/evidence/P007-*. Poll long actions at reasonable intervals. Do not bypass assertions or mutate runtime fields to fake results.
9. Stop only test sessions created by this task. Restore transient test preferences and prior editor map when it can be done without discarding unsaved work. Record final status/hashes and any generated/user-settings changes. Replace implementation report and stop for review.

## Allowed changes
coordination/IMPLEMENTATION_REPORT.md, coordination/evidence/P007-*, normal generated logs/caches, and transient runtime/test state. No saved gameplay changes.

## Do not change
No assets/config/source/plugin edits, global saves, music fixes, engine/tool installs, rebuilds, cook/packaging, process termination, user play-session interruption, Git changes, task/history/archive edits, or scripted forced role/health/replication values. Do not access public servers/accounts or change Steam settings for this local test.

## Error handling
Continue independent observations after non-blocking failures; record action/error/attempts/impact. Stop dependent tests if hosting or joining fails. Gather evidence and propose one narrow follow-up fix instead of implementing it. Tool inability is not a gameplay failure or a pass.

## Acceptance checks
- Actual host-menu/public-event session creation and Map1 listen travel observed, or precise failure/unavailability documented.
- Actual second-player discovery/join observed separately from direct PIE networking.
- Host/client world, network role and player/connection evidence substantiate successful multiplayer claims.
- Runtime unavailable-map controls and removed-map travel behavior checked when accessible.
- Logs/results distinguish pass, fail, skipped and unverified; basic gameplay observations do not imply full replication correctness.
- Project input hashes preserved; task-owned sessions cleaned up and transient preferences restored.

## Required report
Use coordination/REPORT_TEMPLATE.md; Task ID P007. COMPLETE only when primary host/discovery/join and required runtime checks pass; PARTIAL for failed or unavailable primary checks with completed diagnostics; BLOCKED if no safe runtime test can start. Include exact reproduction steps, topology, observations, logs and recommended next scoped milestone. Stop for Codex review.

