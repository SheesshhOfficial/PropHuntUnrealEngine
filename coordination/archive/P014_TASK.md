# Task P014 - Game documentation and visual Miro board

Status: READY
Owner: Antigravity
Reviewer: Codex

## Goal and authorization
The user requests well-organized, thorough game documentation with existing photos/screenshots, produced through Antigravity's connected Miro integration. Create one cohesive documentation board and a local, maintainable companion document. This is documentation only; the earlier direct Codex gameplay/UI implementation authorization does not require Codex to implement this milestone.

## Read first
AGENTS.md, PROJECT.md, coordination/documentation/MIRO_DOCUMENTATION_BRIEF.md, coordination/documentation/SCREENSHOT_MANIFEST.csv, coordination/ROADMAP.md, coordination/TASK_HISTORY.md, and coordination/archive/P013-R3-before-Miro-documentation_REPORT.md. Read README as intended-feature context, not proof. Consult targeted reviews and reports only for the section being authored; review qualifications take precedence over unqualified report claims.

## Scope
1. Inventory actual relevant assets, source and config read-only. Document observed architecture and input bindings without guessing. No game edits or new gameplay tests are required.
2. Write documentation/GAME_DOCUMENTATION.md with relative screenshot links, a contents section, feature/status matrix, gameplay, systems, screen guide, architecture, setup/testing, known limitations, roadmap and evidence index. Explain relevant behavior in plain language, with exact asset names in developer references.
3. Use the connected Miro integration to create a NEW board titled 'Sheeshh Prop Hunt — Game Documentation'. Do not overwrite existing boards. If there are multiple connected destinations and no safe default, finish local documentation and ask which destination; do not invent a board URL or connection success.
4. Build ordered frames per the brief. Upload/embed real screenshots, give every image a caption and provenance label, add an architecture diagram and player journey, and provide readable feature/testing tables or cards. This is a visual knowledge base, not a pile of pasted Markdown.
5. Save documentation/MIRO_BOARD_INDEX.md containing the actual board URL/ID, frame links/IDs when supported, maintenance instructions and documentation date. Maintain local documents as the source of truth. Do not change permissions or invite users.
6. Validate local links and screenshot paths, reconcile statuses with reviewed evidence, inspect the completed Miro board using supported view/export capabilities, and fix overlap/unreadable layouts. If board inspection is unavailable, state the limitation. Local-drive links alone do not make Miro images accessible: actually upload/embed them.

## Boundaries
Allowed: new documentation/ files, board creation/content using connected Miro, and coordination/IMPLEMENTATION_REPORT.md. Do not modify Unreal assets, Config, Source, project descriptor, README, PROJECT, task/history, background controller, or existing Miro boards. No installs, commits, pushes, engine upgrades, emails or external messages. No new stock/generated pictures presented as game screenshots. No exhaustive directory/log dump; use targeted evidence and a small curated gallery.

## Acceptance
- Local documentation and matching Miro board cover all required frames, with navigable overview and useful developer references.
- At least the two current live Settings screenshots and current Debug preview are embedded with honest labels. Historical menu/browser/pause images may supplement them, clearly dated and qualified.
- Actual implementation, user-tested behavior, independently verified behavior, report-only evidence, planned work and unknowns remain distinct. Current UI changes have no fresh packaged-game validation.
- Round lifecycle is USER-TESTED. Steam/internet matchmaking, voice chat, more Map1 props and music resolution are future work. Do not schedule Map2/Map3 restoration.
- No invented gameplay screenshots, architecture, controls, connections or multiplayer passes. Missing gameplay/Map1 photos are documented as a gap, with a future capture list.
- Existing boards and unrelated local changes are preserved. Report actual board URL and exact deliverable paths.

## Failure handling and report
Continue safe local documentation if Miro operations fail. Record action, exact error, attempts, impact and next step; stop only dependent board work. Avoid repeated failing/polling calls. Replace coordination/IMPLEMENTATION_REPORT.md using REPORT_TEMPLATE.md; use COMPLETE only when all deliverables and verification succeed, otherwise PARTIAL/BLOCKED with precise gaps. Stop for Codex review. Do not implement another milestone or run the background loop.
