# Figma workflow and feature atlas - detailed design brief

## Design objective
Make a carefully art-directed game guide that a new player can follow and the owner can maintain. Use a designed typographic title lockup 'SHEESHH / PROP HUNT' (working title), compact subtitle 'Hide in plain sight. Hunt before time runs out.', contrasting Hunter/Prop graphic badges and restrained geometric motifs. Treat this as a documentation cover, not a replacement in-game logo. No generic blank corporate template, enormous prose blocks or repeated screenshot walls.

Palette: deep navy #101827, slate #243248, cyan #30D5E8, warm orange #FFAD59, paper #F4F7FB; readable muted text #AFC0D4 on dark backgrounds. Hunter accent orange, Prop accent cyan, developer/debug violet #B69CFF. Use available readable fonts; no font installation. Bold title and section hierarchy, restrained rounded cards, fine separators, consistent alignment, 8-point spacing. Distinguish screen navigation arrows, gameplay action arrows and developer-only dotted connectors. Use textual labels as well as colors.

## File organization
Pages: 00 Cover & Navigation; 01 Launch & Sessions; 02 Hunter Journey; 03 Prop Journey; 04 Pause & Settings; 05 Developer Debug; 06 Outcomes & Reference; 99 Components & Image Slots.
Use numbered frames and human-readable layer names. Suggested presentation frame 1920x1080 with 80px margins and 12-column grid. For dense annotated screens use additional continuation frames rather than shrinking text. Suggested title48-64px, section32px, body20-24px, caption16-18px. Screen photo slots 960x540 or 800x450; full image slot1600x900 where needed. Preserve original photo aspect ratios, including editor chrome unless a clearly labeled crop improves the annotation. Use auto-layout for text/callout cards if supported.

## Overall journey map
Launch -> Boot/Main Menu -> Host or Find/Join -> session/lobby/loading if evidenced -> Map1 match. Split into two parallel lanes: HUNTER and PROP. Both share round timer/outcome flow and an adjacent PAUSE branch -> Resume / Settings / Leave as actually authored. Settings splits into current Gameplay/Audio/Video/Appearance categories (verify actual current names; historical Costume labels may differ). Developer Debug is a dotted side branch triggered by the Tilde route, with its own host/client restrictions, not a normal settings category. Connect outcomes back to the actually supported next action; don't invent rematch.

## Frame specification
00.01 Cover: designed title lockup, subtitle, date, UE5.7, working title note, role badges and optional gameplay hero placeholder. Provide a clickable navigation list to all pages where supported.
00.02 What is the game?: short approachable pitch, two role cards, timed hide-and-seek loop, current Map1 scope, evidence legend. Explain role differences without claiming unverified details.
00.03 Full journey: clean connector diagram, separate gameplay/pause/debug routing, legend and branch labels. Lay it out as a journey, not a feature checklist.

01.01 Start screen: largest suitable existing menu screenshot; numbered pointer dots on each real button/input. Adjacent callouts list visible label, purpose, resulting screen/state and relevant restriction. Verify actual controls (host, browser/join, name, settings, quit etc.); do not infer authentication from player-name entry. Use a new current-shot placeholder if evidence is historical.
01.02 Host: annotate available host controls and host outcome; missing dialog/success photos get placeholders. Distinguish intended session flow from tests actually supported.
01.03 Find/Join: existing browser evidence with row/buttons/refresh/back annotations; explain available fields, loading/empty/failure/busy states. Missing-state pictures get separate slots. IP joining only if actual UI supports it.
01.04 Entering Map1: lobby/loading/spawn sequence only where implemented; otherwise omit invented screens and document the real transition with placeholders for spawn/role assignment.

02.01 Hunter overview: orange role banner, goal, gameplay photo slot, HUD overlay annotations for actual timer/health/role/crosshair/other indicators. Missing HUD labels marked 'verify HUD detail'.
02.02 Search and aim: small action sequence and camera/aim screenshots or slots; list verified controls, search purpose and limitations.
02.03 Shoot and deal damage: Aim -> Fire -> Hit feedback -> Damage/elimination flow, with distinct target-before, shot/hit and damage-feedback slots. Do not invent numerical damage, floating damage text, penalty for missed shots or kill effects. Clearly mark unverified feedback as capture/inspection needed.
02.04 Damage received / elimination: player health/outcome progression when supported, screenshot slots and concise behavior explanation; unsupported death/spectator screens remain labeled gaps.
02.05 Hunter round result: actual supported win/lose conditions, result photo slot, next action only when evidenced.

03.01 Prop overview: cyan role banner, survival goal, gameplay slot and annotated actual HUD.
03.02 Transform sequence: matched side-by-side BEFORE and AFTER image rectangles with prominent transformation arrow; optional target-selection third slot. Caption desired same-camera position, original form, target object and transformed form. Explain actual trigger/eligibility/change count where inspected, no invented values.
03.03 Hide and reposition: environment/prop examples, movement and rotation-lock if actually implemented; placeholders for normal versus locked orientation where evidence missing.
03.04 Taunt / cues / constraints: document only inspected features; screenshots or 'audio cue context' slot and description. Avoid presenting an audio cue as a visible UI effect without proof.
03.05 Damage / survival / elimination: before-hit/after-hit matched slots, health or feedback annotations if supported; route to result.
03.06 Prop round result: survive-until-timer and other actual outcomes, screenshot slot, link back to overall journey.

04.01 Pause menu: adjacent to both role lanes in the overview; screenshot with arrows for actual Resume/Settings/Leave etc. Explain whether this opens an overlay, and whether multiplayer continues; if unknown label it unknown rather than assume game freezes.
04.02 Settings overview: annotate profile, category rail, values, Apply, Discard/Back, status feedback. Explain shared versus role-specific settings without inventing functionality.
04.03 Gameplay settings: current screen screenshot if available, otherwise full-size placeholder. Describe each inspected control (including sensitivity only if here in actual UI) with scope/range if evidenced.
04.04 Audio: current Codex-settings-live.png; annotate sliders, percentages and action buttons, explain saved values and Apply/Discard. Distinguish numerical routing validation from audibility testing.
04.05 Video: current Codex-settings-video-live.png; arrows for Overall Graphics, Texture, Shadow, View Distance, Anti Aliasing and V-Sync plus Apply. Clarify quality selection/persistence as supported.
04.06 Appearance/Costume: screenshot slot; verify actual category label and behavior. If UI exists but features are unfinished, describe that status instead of invented unlock/shop mechanics.
04.07 Apply/Discard story: three state cards 'Saved -> Edited/Unsaved -> Applied' plus 'Discard -> previous values'; actual before/after photos or slots. Back navigation and reopening captured only when available.
04.08 Leave flow: confirmation -> leaving -> menu if actually supported, historical screenshots labeled, failure/unavailable state noted. Quit is distinct from Leave.

05.01 Debug overview: purple visual identity, purpose, current Codex-debug-1920-preview.png labeled ASSET PREVIEW, Tilde input route labeled physically untested. Keep ordinary gameplay settings distinct.
05.02 Diagnostic fields: arrows to FPS/frame time/map/network role/ping/player count/build as actually visible. Explain unavailable values versus errors.
05.03 Host actions: Hunter Count -> commit; Server Prop -> transform; Start Round -> confirm -> started/disabled. Explain dynamic player-count bound, local authoritative host restriction, boot/client denial and duplicate-start prevention. Slots for real host/client states and action outcomes.
05.04 Open/close state: singleton ownership and cursor restoration, Close and reopen; physical key/focus acceptance gaps kept in technical note.

06.01 Results and round loop: role outcomes, actual next-step navigation, missing screenshots and user-tested lifecycle badge.
06.02 Feature map: implemented/static-inspected/runtime-tested/user-tested/planned/unknown labels with specific evidence types. Separate current game from future roadmap.
06.03 Future work: more Map1 props, music decision, internet/Steam matchmaking, voice, performance/UI polish. Map2/Map3 excluded.
06.04 Photo checklist and maintenance: all blank slots in a compact owner-facing list; explain replacement without disturbing arrows/text. Link source docs and evidence manifest. Technical caveats here and small footnotes; avoid cluttering every player-facing caption with source hashes.

## Annotation pattern
Reusable callout component: numbered dot + visible control name + one-sentence purpose + resulting behavior/state + optional status badge. Match number to a circular marker on the photo and an arrow ending exactly on that control. Position callouts outside the photo; route elbows through margins. Allow enough spacing to keep arrows/copy distinct. For missing screenshots, arrows may target named future-control areas only as a clearly labeled planned annotation; do not pretend positions were measured.

## Placeholder contract
Every missing photo uses an editable rectangle at final image dimensions, neutral/slate fill, dashed border, centered camera icon or simple drawn image glyph and editable text. Name 'IMG-[section]-[shot]'. Display 'IMAGE TO ADD', a specific alt description (e.g. 'Prop player before transforming into a Map1 vase, same camera angle as AFTER'), desired resolution/aspect ratio, and concise capture instructions. No real screenshot? Keep the rectangle; don't substitute stock art or a copied unrelated menu.
Store ID, page/frame/node, role, desired shot, before/after pair relationship, dimensions, status and replacement steps in the CSV. Include hero, current main menu, host dialog, join success/failure, Map1 spawn, Hunter HUD, hit/damage/elimination, Prop HUD, before/after transformation, rotation-lock/taunt if supported, pause current, missing settings categories, host/client debug and results. Trim nonexistent features after inspection and document why.
Prefer a component image-fill layer with text/instruction overlay in a separate subgroup so the user can select the fill rectangle and paste/replace the image, then hide the instruction subgroup. Do not require deleting and rebuilding an entire frame.

## Sources and evidence labels
Reuse SCREENSHOT_MANIFEST.csv, verify files exist. Current live audio/video captures are strongest presentation photos. Latest Debug preview is layout evidence, not runtime evidence. Historical menu/browser/pause captures remain visibly labeled historical. Current documentation from P014 contains unreviewed claims (e.g. exact prop inventory counts, object examples and input details); independently inspect targeted evidence before adopting those as facts. No game changes or new test sessions are required to make this design.

## Finishing standard
Inspect cover, overall flow, one detailed Hunter frame, matched Prop transform frame, annotated video settings and Debug at actual size. Check every page for overflow, overlapping arrows, illegible text, uncropped screenshot distortion and placeholder selectability. Use native editable Figma components where possible; keep diagrams vector, not flattened. Return actual file/node links and a short coverage checklist with remaining image slots counted. Never state the file is created until its existence is verified through the connected tooling.
