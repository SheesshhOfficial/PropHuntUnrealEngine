# Task P012-R1 - Finish functional settings and verify debug menu

Status: READY
Owner: Antigravity
Reviewer: Codex

Read AGENTS.md, PROJECT.md, coordination/UI_DESIGN_BRIEF.md, archived P012 task/report and P012-CODEX_REVIEW.md. User review-and-proceed authorizes one correction attempt plus review. Preserve debug additions and existing session/Map1 behavior. No HUD work.

## Scope
All P012 allowed widget/save/native debug/helper and minimal local setting-consumer hooks remain allowed. Explicitly add new Music/SFX SoundClass and settings SoundMix assets under Content/Core/sound/Settings/ plus minimal SoundClass assignments on inventoried existing sound cues/waves needed by those settings. Do not replace/remove music, repair unrelated missing audio, download assets or resave the whole audio library. Inventory exact routed sounds before edits; only classify actual supported existing content. Unknown gameplay categories require documentation, not blanket assignment. Existing save compatibility preserved. No maps/online/VOIP/gameplay rules/plugins/engine upgrade/install/commit/push.

## Fixes
1. Connect music/SFX overrides to real initialized/pushed SoundMix and appropriate SoundClasses. Route inventoried existing audio so each slider affects its category, including later-spawned sound. Verify independent mute/restore readbacks and existing playable audio; absent music remains reported, not fake pass. Persist/load volumes and avoid stacking active mixes on repeated menu opens.
2. Implement staged graphics/audio/sensitivity state with explicit Apply, saved/unsaved feedback, and Back/Escape discard or clear Apply/Discard prompt. Do not save/apply on every option-change event. Live preview must restore original runtime values on discard. Existing options/current defaults load safely, valid ranges clamped, no saved user values overwritten by opening.
3. Opening from boot: Settings Back returns to original WBP_Menu with focus/cursor/input restored; never show gameplay pause page in Boot_Lvl. Opening from gameplay pause returns to that pause screen and preserves intended pause/input state without destroying sessions. Debug Close restores caller focus; repeated clicks do not stack panels.
4. Validate sensitivity at actual local camera consumer, not only saved slider property. Apply/reopen and fresh PIE/relaunch save readback for every supported control; preserve user's save/settings before tests and restore safely afterward. No deleting original save.
5. Debug validity: set available only with valid world; unknown player/session/role fields show unavailable, no invented player count. Label engine net role distinctly from Prop/Hunter gameplay role. Preserve Shipping access/data guard and confirm widget-side gate; no arbitrary commands/cheats. Gather real listen/client values, Refresh/Close. No per-frame scans.
6. Full Editor Development build for new native code using installed UE5.7 tooling; Live Coding alone insufficient. Shipping compilation/guard evidence where available, packaged runtime untested explicitly disclosed. Do not interrupt unrelated user editor work; record build blocker and continue independent checks.

## Evidence/report
Back up/hash affected existing files before supported Unreal edits. Final full-path manifest MUST include every new source/helper/debug/audio asset as well as changed assets. Record graph diffs, actual build/compile outputs and baseline/backup checks. Settings and debug previews at 720p/1080p/ultrawide clearly labeled; live captures where supported and ordinary input vs delegate diagnostics separate. If unavailable gates/audio coverage/build are blocked report PARTIAL/BLOCKED, never COMPLETE merely scoped edits finished. Restore task-owned sessions/settings/map safely, replace IMPLEMENTATION_REPORT.md for P012-R1 using template, write exact controller nonce after all cleanup/report as final filesystem action and stop. No history/task edits or next milestone.
