# Task P010-R1 - Verify real session teardown and pause interactions

Status: APPROVED
Owner: Antigravity
Reviewer: Codex

## Goal
Validate P010 with actual advertised session creation/discovery/joining rather than direct open commands. Preserve the implemented UI; make only demonstrated small scoped corrections if necessary.

## Read first
AGENTS.md, PROJECT.md, coordination/archive/P010_REPORT.md, P007 host/discovery evidence, UI_DESIGN_BRIEF.md and REPORT_TEMPLATE.md.

## Findings to resolve
P010 multiplayer evidence starts with open Map1?listen and rejoins via open 127.0.0.1:7777. That does not establish a named online session exists or that DestroySession successfully removes it; it may only exercise failure fallback. LeaveGameSession and NetworkError share the DestroySession node and need re-entry/failure-state validation.

## Scope
1. Capture status/hashes, current project identity, dirty packages and existing user-owned sessions. Record actual pause UI/graph state and protect unsaved work. Preserve original P010 images/backups.
2. In bounded two-player local sessions, invoke the real MenuInstanceNewSession event or its UI handler to create an advertised session. Verify session callback/state and Map1 listen travel. Client must use FindingSession and the returned WBP_Server Join button. Do not use direct OpenLevel/IP as proof of primary session behavior.
3. Client uses normal pause Leave confirmation: verify DestroySession callback/state, return to Boot_Lvl, host remains Map1, connection/player count drops, menu/input is usable, no duplicate widgets. Client rediscovers and rejoins the same host through session browser. Record actual widget count/session identity/results.
4. Host uses Leave: verify named session destruction, client network-error return, and both peers can create/find/join a new advertised session without app restart. Capture shared error-handler/re-entry behavior; no forced session state.
5. Test modal Cancel then reopen, keyboard/gamepad focus containment, Escape behavior, duplicate confirm, Resume and Settings->Back. After cancel/reopen buttons and message/progress must reset. Test the no-session fallback separately and label it diagnostic. Do not assume graph presence establishes interaction success.
6. Record relevant raw timestamped engine/tool outputs, session callback/state, worlds/player/widget counts, exact action method, and real runtime screenshots at 720p/1080p/ultrawide with gameplay behind pause. Include focus/hover and confirmation states; no mockups as evidence. If gamepad support/tools are unavailable, explicitly mark that check skipped.
7. Only if a reproduced failure requires a small correction, back up/hash-verify affected scoped asset before editing. Allowed product assets are WBP_MainMenu and MenuGameinstance; controller may change only for a reproduced focus/input restoration bug. No redesign beyond pause functionality. Compile/save only corrected assets, preserve original error-return behavior and retest the failed check once.
8. Stop task-owned sessions, restore transient settings, capture final status/hashes and changed-asset diffs. Update implementation report and save P010-R1 evidence. Continue independent checks after tool failure; do not manufacture success.

## Do not change
No other screens, maps, source/config/plugins, music, prop lists, builds, packaging, public network, installs, Git operations, global saves, task/history/archive edits or backup deletion. Preserve user unsaved state and play sessions.

## Acceptance checks
- Actual session creation/discovery/join and named-session leave/rehost/rejoin observed; direct networking is explicitly separate.
- Client leave keeps host active; host leave clears advertised session and client returns to usable menu.
- Session callbacks/re-entry/failure fallback and modal cancel/reset/focus/resume checked with evidence.
- Scoped assets compile and unrelated inputs unchanged; raw logs and screenshots support claims.
- Unavailable checks documented honestly; packaged behavior still unverified.

## Required report
Task ID P010-R1 using REPORT_TEMPLATE.md. COMPLETE only if primary session cleanup passes; PARTIAL for remaining failures/unavailable checks, BLOCKED if safe test cannot start. Stop for Codex review.

