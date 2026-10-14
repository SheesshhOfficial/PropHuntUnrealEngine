# Task P015-R1 - Build the game workflow directly in Figma workspace

Status: READY
Owner: Antigravity
Reviewer: Codex

## Goal
User rejected the manual SVG/import delivery and now reports a local Figma Plugin + WebSocket bridge with write access. Build the requested professional visual game guide INSIDE the connected Figma canvas. Deliver one organized, connected spatial workspace, not detached presentation slides or instructions for the owner to paste everything. Only missing photos should remain as labeled replacement rectangles.

## Read
AGENTS.md, PROJECT.md, coordination/P015-CODEX_REVIEW.md, coordination/documentation/FIGMA_WORKFLOW_BRIEF.md, coordination/documentation/SCREENSHOT_MANIFEST.csv, coordination/archive/P013-R3-before-Miro-documentation_REPORT.md. Prior FIGMA_WORKFLOW_CONTENT/INDEX and local SVGs are unapproved drafts; correct unsupported claims before reuse. This task supersedes prior fixed-slide/page organization and fallback completion instructions.

## Bridge and destination first
1. Discover currently available Figma MCP tools and read their schemas. Use the NEW local plugin/WebSocket write tools, not obsolete REST mutation endpoints. Inspect active connection/channel, current document and writable canvas state. Do not assume tool names or install/reconfigure dependencies.
2. If channel selection is required, select the uniquely active supported channel. If the plugin is disconnected or no safe document is identifiable, perform local content corrections first and report the precise necessary user step (for example start the bridge plugin in a chosen file). Do not request API tokens, dump credentials, loop failed calls, or substitute another manual-import package as completed work.
3. Create a dedicated new page 'PROP HUNT - GAME WORKFLOW' in the connected writable document when supported. Preserve existing pages/content. If new pages are unsupported, create the workflow in an empty non-overlapping area of the current canvas after inspecting existing bounds; record exact location. New file creation is optional capability, not a blocker when a writable connected file/page exists.
4. Verify a small new native text/shape write through node readback before batching content. Retain successful probe as part of the design or remove only the task-owned probe. Stop dependent canvas work if write access fails.

## Continuous workspace composition
Use the colors, typography, callout and placeholder specifications in the detailed brief, but replace the slide deck with this connected spatial layout:
- Top center: designed editable 'SHEESHH PROP HUNT' title lockup, short game description, role badges, navigation legend and optional hero-photo placeholder.
- Below: Launch/Main Menu with actual screenshot and numbered arrows ending on each visible control; explanatory callouts beside it. Name input is not an invented authentication/login system. Connect real Host/Find/Join routes, with screenshots or labeled missing-photo slots.
- Match entry below branches into two parallel lanes: HUNTER on left with warm orange accents, PROP on right with cyan accents. These are simultaneous roles, not sequential phases.
- Hunter lane: role goal, gameplay/HUD annotated photo slot, search/aim, fire/hit/damage sequence, health/elimination, supported outcomes. Missing damage shots get separate image rectangles with precise alt descriptions.
- Prop lane: role goal, gameplay/HUD slot, target/transform sequence, matched BEFORE and AFTER photo rectangles, hiding/movement, rotation-lock/taunt only when supported, damage/survival/elimination and supported outcomes.
- Side of gameplay: a shared PAUSE menu reached from BOTH lanes, annotated actual controls and arrows to Resume/Settings/Leave where supported. Document unknown multiplayer pause behavior rather than assuming world freezes.
- Settings branches into individual actual category screens: Gameplay, Audio, Video, Appearance/Costume (verify current labels). EACH gets its own photo or image-sized placeholder, nearby detailed control explanations and arrows. Include Apply/Discard/saved/unsaved behavior. Use current live audio/video images from the manifest.
- Debug is a separate developer branch with violet accent and a labeled Tilde route; do not place it as a normal settings category. Include diagnostics and hunter-count/Server Prop/confirmed Start Round, host/client restrictions and action-result placeholders. Latest debug preview must be labeled preview.
- End of role lanes: real round outcomes and supported next navigation; connect cleanly rather than invent rematch. Add small reference/roadmap/evidence section at the bottom edge and a visible missing-photo checklist.

Keep substantial sections as native text, vectors, image rectangles and logical groups on ONE connected page. Transparent internal frames/auto-layout containers are permitted as implementation structure, but no visible uniform slide borders, repeated 1920x1080 artboards, presentation-only pages or flattened poster. The owner should pan around one coherent workflow. Connectors route through margins and avoid crossing body text. Use spacing, light/dark region bands, section titles and subtle separators to organize the workspace; retain readable text at practical zoom. Use a title-to-outcome route and numbered navigation to make the large canvas usable.

## Images and factual accuracy
Upload/embed available actual image bytes using supported bridge operations; filesystem links are insufficient. Preserve aspect ratios; label live/historical/preview provenance. Do not reproduce secret/token/account details in the design/report.
Missing images use editable rectangle image-fill layers at intended display sizes, dashed border and a separate instruction overlay: 'IMAGE TO ADD', specific alt description, role/state, desired aspect ratio and capture instruction. Owner can replace only the rectangle fill and hide instruction text. Include matched prop BEFORE/AFTER and damage BEFORE/HIT/AFTER slots. No stock/fabricated gameplay shots.
For every control/mechanic fact use actual inspected assets or reviewed evidence. Remove unsupported numerical ammo, health, cooldown, sensitivity range, radius clamp and verification percentages from existing local documents. Unknown facts remain labeled unknown; future work remains planned. No invented login/shop/voice/internet/Map2/Map3 features. User-tested round lifecycle stays user-tested; static graph inspection is not gameplay validation. Existing game assets/source/config remain untouched.

## Deliverables and validation
- ACTUAL native editable canvas in connected Figma with designed title, annotated menu, connected parallel role lanes, pause/settings/debug branches and replacement placeholders.
- Update documentation/FIGMA_WORKFLOW_CONTENT.md to reflect actual canvas text; FIGMA_IMAGE_PLACEHOLDERS.csv with actual node IDs, sizes and instructions; FIGMA_WORKFLOW_INDEX.md with real file/page/root links and no manual import step. Record node IDs/bounds for each major region and source provenance.
- Use node readback to prove native text, image fills, vectors, grouping and placeholders exist in Figma. Inspect overview and representative menu/Hunter/Prop-transform/settings/debug regions using supported screenshots/exports. Fix overlapping arrows, clipping, unreadable text, aspect distortion and disconnected branches. Merely reporting node creation success is not visual QA.
- Save overview/region exports under documentation/figma_review/ if tools support export. Disclose any inspection/export limitation explicitly.
- Verify every required branch and missing-image record; report actual counts and file/page URL. No claim COMPLETE from local files, account access, read-only file access or rest API success alone.

## Boundaries, failures and stop
Allowed: new Figma page/task-owned canvas nodes, documentation files and IMPLEMENTATION_REPORT.md. Do not alter existing Figma designs, Miro boards, Unreal files, project configuration, task/history, bridge installation/configuration or background controller. No commits/pushes/messages/sharing changes. Preserve prior local assets; no destructive cleanup.
Continue safe independent factual/documentation corrections after bridge failures. Record action, exact error, attempts, impact and next step. If the bridge truly cannot write, report PARTIAL/BLOCKED with concrete plugin/channel condition; don't make the owner import the whole design as the deliverable. Replace IMPLEMENTATION_REPORT.md using REPORT_TEMPLATE.md and stop for Codex review. COMPLETE requires actual connected canvas plus checks; do not execute another milestone.
