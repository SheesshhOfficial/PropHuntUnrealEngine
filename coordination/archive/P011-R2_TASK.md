# Task P011-R2 - Recoverable menu flows and honest runtime evidence

Status: READY
Owner: Antigravity
Reviewer: Codex

## Goal and read first
Finish the existing home/host/browser milestone before HUD work. Read AGENTS.md, PROJECT.md, coordination/UI_DESIGN_BRIEF.md, coordination/evidence/P011-R1-CODEX_REVIEW.md and archived P011-R1 task/report. Preserve accepted labels, Map1 art and all unrelated changes.

## Allowed scope
Content/Core/Widgets/WBP_Menu.uasset and WBP_Server.uasset, existing T_Map1_Background/T_Map1_Preview, small inventoried menu/status widgets if necessary. This correction explicitly allows the minimal failure/success callback dispatcher change in Content/Core/Map/MenuGameinstance.uasset needed for recoverable menu session states. Preserve existing advertised flags, names/slots, Map1 travel and LeaveGameSession semantics. No gameplay/controller/HUD/maps/config/plugins/source edits, installs, engine upgrades, commits or pushes. Back up and hash every touched existing asset before supported Unreal editing. Do not resave unrelated packages.

## Implementation
1. Minimal async callback contract between GameInstance and menu: real create-session failure restores Host and shows player-facing error/retry; success retains normal travel. Prevent duplicate creation, clean up callback bindings, keep Back behavior safe during pending operations. Never fake OSS success or delete session state to manufacture a pass.
2. Home has clear Host/Find choices and actual bound player-name area; readable host panel has labeled defaults and Back. Existing Settings/Quit remain reachable where supported; do not invent settings. Map1 remains sole choice. Retain secondary labeled direct-IP action.
3. Add visible Refresh to browser. Real searching, empty, error and results states; scoped joining state and recoverable failure. Clear Back and predictable keyboard focus. Real server rows only. Prevent overlapping requests and stale callbacks after Back/reopening. Long names stay readable. Apply short hover/focus/press feedback consistent with design brief; report gamepad limits.
4. Capture visible runtime home/host/browser at 720p/1080p/ultrawide with native supported Slate-inclusive tooling. Preview or composite images must be labeled and cannot substitute for live layering/input evidence. Preserve original captures. If capture/input tooling prevents acceptance, mark PARTIAL and explain instead of claiming COMPLETE.
5. Execute ordinary Host button -> client Find/Refresh -> returned row Join -> actual pause Leave -> host Leave -> second advertised host/discovery/join cycle. Record exact actions, raw timestamped logs, worlds, names/slots and player counts. Direct GameInstance calls or delegate broadcasts are separately labeled diagnostic evidence, not ordinary pointer/keyboard interaction proof. No direct-IP substitute. Validate genuine pending/failure/duplicate behavior where safely reachable; unavailable tests explicit.
6. Correct previous overstatements, record concise graph/property changes and actual tool outputs. Full-path JSON SHA256 manifests include all touched/new textures/widgets and baseline/backup comparison. Compile affected assets; stop task-owned sessions, restore settings/map and preserve unsaved user work.

## Acceptance and report
COMPLETE only when recoverable async states, readable navigation, keyboard interactions, genuine live captures and two normal advertised-session cycles pass. Otherwise PARTIAL/BLOCKED with exact remaining gaps. Independent safe work continues after non-blocking failures. Replace coordination/IMPLEMENTATION_REPORT.md using REPORT_TEMPLATE.md with Task ID P011-R2, then stop. Do not edit task/history or proceed to HUD.
