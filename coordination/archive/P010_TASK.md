# Task P010 - Redesign pause menu and implement Leave Session

Status: READY
Owner: Antigravity
Reviewer: Codex

## Goal
Deliver the first implemented UI redesign: a polished pause menu with safe Resume, Settings, Leave Session and Quit Game actions. Validate client leave/rejoin and host departure/rehosting before broader UI replacement.

## Read first
AGENTS.md, PROJECT.md, coordination/UI_DESIGN_BRIEF.md, coordination/archive/P009_REPORT.md, P009-session-cleanup-diagnostics.md and REPORT_TEMPLATE.md.

## Scope
1. Inspect and screenshot the current pause menu, its usages, controller show/hide/input-focus logic and MenuGameinstance fault/session handling. Record dirty packages and input hashes. Verify the same WBP_MainMenu asset may be used elsewhere before changing its layout. Back up/hash-verify affected assets before edits.
2. Allowed product assets: WBP_MainMenu at Content/Core/Widgets/MainMenu/UI/WBP_MainMenu.uasset; MenuGameinstance at Content/Core/Map/MenuGameinstance.uasset; BP_ThirdPersonPlayerController at Content/Core/BluePrints/BP_ThirdPersonPlayerController.uasset. A small new UI confirmation/status widget under Content/Core/Widgets/ is permitted if necessary and explicitly inventoried. Do not resave other assets globally.
3. Apply the shared design brief to the pause presentation: clear hierarchy, Resume primary, Settings, Leave Session, Quit Game; consistent role accents, readable panels, responsive hover/press/focus and short transitions. Preserve actual settings bindings, labels and all existing functional flows. Preserve Map1 selection and disabled Map2/Map3 behavior without restoring maps. Do not redesign unrelated screens in this task.
4. Implement a normal Leave Session button calling a shared GameInstance leave operation. Use existing supported DestroySession/online APIs; inspect actual session behavior. Handle success, failure and no-session cases, duplicate requests and network/travel error re-entry. Return to Boot_Lvl cleanly and restore input/cursor/menu focus. Do not let missing-session failure trap the player; record the fallback used. Avoid bypassing cleanup through OpenLevel alone when a live session exists.
5. Host leave shows a simple confirmation explaining that other players disconnect; cancel preserves the game. Client leave affects only that client. Resume closes menu and restores normal input; existing Quit Game remains a distinct application-exit action. Preserve unsaved editor work and normal round logic.
6. Compile/save only scoped assets. Capture focused graph/property diffs and actual screenshots at 720p/1080p/ultrawide, keyboard/controller focus behavior, confirmation/cancel/leaving/failure states. Use supported Unreal tooling; no downloaded art/fonts/plugins or fake player data.
7. Run local normal host/discovery/join flow with two players. Test client leave to Boot_Lvl, host remains active, client rediscovers/rejoins; then host confirms leave, client handles departure, both can create/join again without restarting. Check actual session/player/widget state for duplicates/stale entries. Test Resume/cancel input restoration. Use task-owned bounded sessions and preserve user sessions.
8. Keep missing music unchanged. Stop task-owned tests, restore transient play settings including any Live Coding preference modified by P009 if original value can be established. Do not guess unknown original settings. Record before/after hashes and unchanged surrounding inputs.
9. Save screenshots, exact tool results, graphs, logs, backup paths and pass/fail matrix under coordination/evidence/P010-*. If leave flow fails, gather evidence and report partial instead of expanding gameplay scope. Shipping rebuild is deferred until cleanup is reviewed; P009 package/menu evidence remains incomplete.

## Boundaries
No lifecycle retesting, Map2/Map3 restoration, prop tagging, music fix, source/config/plugin edits, installs, global saves, public online tests, Git changes, task/history/archive edits or existing backup deletion. UI must use real existing game/session state. No force-killing user sessions or discarding unsaved work.

## Acceptance checks
- Actual redesigned pause UI with screenshots, clear hierarchy, responsive interactions and usable focus/scaling.
- Resume/Settings/Quit behavior preserved and Leave confirmation/cancel/progress/error handling works.
- Client leave/rejoin and host departure/new hosting demonstrated through normal actions with session/world/widget evidence.
- Only scoped assets deliberately changed; verified backups and focused diffs retained; no Blueprint compile errors.
- All unavailable checks explicit; packaged multiplayer is not claimed from PIE results.

## Required report
Task ID P010 using REPORT_TEMPLATE.md. COMPLETE only when UI and leave/cleanup checks pass; PARTIAL for outstanding implementation/validation; BLOCKED if safe editing cannot start. Include before/after screenshots and evidence. Stop for Codex review.
