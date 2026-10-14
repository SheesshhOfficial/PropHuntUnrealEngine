# Task P011-R4 - Safe browser closure and remaining UI acceptance

Status: READY
Owner: Antigravity
Reviewer: Codex

User authorized proceeding on 2026-10-07. Execute one additional P011-R4 implementation attempt, followed by final Codex review. Do not start another task.
Read AGENTS.md, PROJECT.md, coordination/UI_DESIGN_BRIEF.md and coordination/evidence/P011-R3-CODEX_REVIEW.md. Preserve accepted R3 work.

Allowed scope: Content/Core/Widgets/WBP_Menu.uasset, Content/Core/Widgets/WBP_Server.uasset and minimal existing Content/Core/Map/MenuGameinstance.uasset menu-session callbacks only, with verified backups and supported Unreal edits. No other gameplay/maps/HUD/config/plugins/source changes.
Fix Back during pending search: retain request ownership until completion/cancellation, prevent reopen starting an overlapping query, and ignore obsolete callbacks without populating stale rows. Add actionable real host/join failure states and verify callback lifecycle cleanup. Test Back/reopen during active search and genuine retry without test overrides.
Complete carried-forward home/host/player-name navigation, real keyboard/pointer interactions and pause Leave/rehost evidence, and native live captures at 720p/1080p/ultrawide. Delegate broadcasts/direct GI calls and previews remain diagnostic only. Mark PARTIAL for unavailable acceptance checks; never claim none skipped when evidence is missing.
Compile affected assets, record actual results/full-path hashes, preserve unrelated work and stop task-owned sessions safely. Required report P011-R4 using REPORT_TEMPLATE.md. No HUD transition before approval.

## Evidence and completion contract
Back/reopen test: start a real search, close before it finishes, reopen and press Refresh; record request count and whether old callbacks touch current results. A retained pending guard or supported cancellation plus callback invalidation must prevent overlapping requests. Failure recovery must show actionable player-facing feedback, restore usable controls and keep delegate ownership clean across retries/travel. No fake server rows or forced OSS state changes.
Before/after inventory and SHA256 JSON must cover all touched assets and unique verified backups. Save exact graph/property changes and compile output. Test actual pause Leave without editing the pause asset. Preserve accepted session flags, server names/slots and Map1-only travel. Report required but unavailable gamepad/capture/input checks explicitly as PARTIAL with action/error/impact/next step; continue safe independent checks. Do not repeat successful packaging builds unless a concrete relevant need arises.
When invoked by the controller, finish all test cleanup and report writing, then write its exact nonce completion marker as the final filesystem action. The marker signals stopping, not approval. Do not omit it merely because this skill normally stops after the report.
