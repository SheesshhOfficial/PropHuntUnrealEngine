# Task P008 - Validate ordinary gameplay input and replication

Status: READY
Owner: Antigravity
Reviewer: Codex

## Goal
Test prop transformation and hunter damage through normal gameplay input on Map1, observing both server and client. Do not bypass gameplay logic to manufacture success.

## Read first
AGENTS.md, PROJECT.md, coordination/archive/P007_REPORT.md, P007 session/topology evidence, and coordination/REPORT_TEMPLATE.md.

## Scope
1. Record project/session identity, existing PIE and dirty packages, relevant core/config input hashes and transient play preferences. Preserve user sessions/unsaved work. Reuse P007's verified local session host/discovery/join procedure with host and one client. Record actual role, world, subsystem and network topology.
2. Inspect relevant Enhanced Input mappings and Blueprint input-to-server flows read-only to identify actual prop-change and hunter firing actions. Do not guess keys or invoke downstream RPC/multicast/damage handlers as a substitute. Supported input injection into the real local player's input action is allowed; record exactly how it was done.
3. Start a round through its normal HUD Start event. Observe which peer becomes prop and which hunter, pawn ownership and initial health/timer. If practical, test a client-owned prop so the client-to-server request is exercised; use only ordinary existing role/settings controls, not forced pawn/role mutation. If only host-prop topology can be tested, explicitly limit coverage.
4. For a prop change, record allowed mesh/current mesh and use the actual input action. Capture the resulting prop mesh object path on server and remote client after propagation, as well as relevant remaining-change count if accessible. Do not call UpdateMeshMulticast, set mesh/defaults directly, or seed RPC output.
5. For hunter shooting/damage, use normal aiming/movement/fire input against the opposing prop. Observe trace/hit results when exposed, server prop health, client replicated health/HUD, and any elimination/game-end behavior reached naturally. No direct ApplyDamage, health changes, teleport-to-hit, or state forcing. If supported input/aiming cannot reproduce a hit, record a skipped/failed interaction instead of faking it.
6. Verify runtime unavailable-map controls on instantiated menu widgets when accessible, preserving gameplay state. Design-time properties alone are not an interaction test. Do not invoke disabled buttons' delegates as evidence they are selectable.
7. Use at most two bounded sessions (up to five minutes each); stop only this task's sessions. Restore transient preferences and prior editor map without discarding unsaved work. Capture relevant raw logs, timestamps, server/client snapshots and per-check pass/fail/skip results under coordination/evidence/P008-*. Record final status/hashes and editor cleanup.
8. Propose a narrow correction task for actual failures. Do not implement gameplay repairs in this validation milestone.

## Do not change
No saved assets/configuration/source/plugins, installs, builds, cook/packaging, public-network tests, Git changes, music edits, global saves, user-session termination, task/history/archive edits, or runtime state/RPC manipulation bypassing normal gameplay. Generated logs and transient test settings are allowed; restore settings afterward.

## Acceptance checks
- Real prop input tested with server and remote-client resulting mesh paths, or precise inability/failure documented.
- Client-owned prop request coverage explicitly verified or excluded; host multicast alone is not full replication coverage.
- Normal hunter fire/hit/damage tested with server/client health and HUD observations, or explicit unavailable/failed interaction.
- Session/menu flow distinguished from direct PIE startup; equal initial HUD values do not prove update replication.
- Runtime unavailable-map controls tested when accessible; otherwise skipped explicitly.
- Logs/snapshots support each result; assets unchanged and task-owned sessions cleaned up.

## Required report
Use coordination/REPORT_TEMPLATE.md, Task ID P008. COMPLETE only if normal-input prop and combat checks pass with two-peer evidence; PARTIAL for failed/unavailable gameplay checks with completed diagnostics, BLOCKED if safe testing cannot start. Include exact reproduction inputs, topology, observations, evidence and next scoped recommendation. Stop for Codex review.
