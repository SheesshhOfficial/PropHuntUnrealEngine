# Miro documentation brief

Documentation date: 2026-10-12 (Asia/Calcutta). Product working name: Sheeshh Prop Hunt / SheeshhPropHuntYT. Do not invent a release name, platform promise or publishing date.

## Board design
Use numbered frames arranged in a clear reading order, a compact navigation overview, dark navy titles, light readable body cards, cyan accents and restrained orange role accents. Use large enough text for normal board zoom. Keep paragraphs short; connect diagrams with labeled arrows. Status labels must include words, not color alone. Images should retain aspect ratio. Crop editor chrome only if useful, keep originals, and label crops; do not alter depicted gameplay. Give screenshots source filenames and capture-context labels.

## Required frames / companion chapters
1. START HERE: game pitch, document date, quick navigation, current scope, evidence legend.
2. GAMEPLAY: hunter/prop roles, core hide/find/transform loop, timed rounds and win conditions. Verify details from assets or label README claims. Round lifecycle accepted by user; no independent blanket certification.
3. PLAYER JOURNEY: boot -> host/browser/join -> Map1 -> pause/settings -> leave/results, with observed versus intended paths distinguished. Historical session tests do not establish all normal-input paths.
4. SYSTEMS AND ARCHITECTURE: UE 5.7, Blueprint gameplay plus C++ module; Boot_Lvl, Map1, GameInstance/session layer, controllers, GameMode, hunter/prop characters, widgets, settings SaveGame/GameUserSettings. Derive actual connections from targeted inspection. Online subsystem currently Null; Steam settings are not proof of internet matchmaking.
5. UI GALLERY: current live Settings audio/video; current Debug asset preview; historical menu/browser/pause images where useful. Describe interaction/state behaviors and the status of remaining input/focus tests. Do not imply old previews depict current live screens.
6. DEVELOPER DEBUG: hunter count, server prop transformation and confirmed round start; local authoritative host restrictions, boot/client denial, singleton/cursor handling, Tilde route and physical-key acceptance gap. Debug is a developer aid, not a player-settings feature.
7. SETTINGS AND SAVE DATA: graphics/audio/sensitivity/profile categories; Apply/Discard and persistence; hunters/props sensitivity consumers. Inspect profile/cosmetics behavior before claiming functionality. Explain that loudness routing and numeric state checks do not establish subjective audibility.
8. TESTING AND BUILD: editor target, supported build pattern from PROJECT; concise reproducible checklists and result/status matrix. P009 historical Shipping cook success is reviewed evidence, not current packaged menu/network acceptance. Current UI has clean Blueprint compilation/runtime checks but no fresh package test.
9. KNOWN ISSUES: physical keyboard/editable text/F10/exact focus acceptance; fresh packaged validation; name initialization accessing absent PlayerState in a two-client startup; incomplete shared-RPC caller/Shipping regression evidence. Inspect later reviewed records before retaining older session issues as current defects. Distinguish unresolved acceptance gaps from reproduced bugs.
10. ROADMAP: more Map1 transformable props; replace/restore/remove missing background music after user choice; separately scoped Steam/internet matchmaking, voice chat, performance and remaining UI polish. Map2/Map3 explicitly excluded.
11. EVIDENCE AND MAINTENANCE: links to local source docs/reviews, actual board index, screenshot provenance, change log and how to update after future milestones.

## Evidence discipline
Current direct implementation record: coordination/archive/P013-R3-before-Miro-documentation_REPORT.md. Eight changed assets and backup/final hashes: coordination/evidence/Codex-UI-Takeover-hashes.json. Do not rerun coordination/codex_ui_takeover.py: it is historical authoring provenance, not a current idempotent updater.
P009: read the Codex review qualification at the end of coordination/archive/P009_REPORT.md before summarizing. Cook success does not prove packaged discovery/join/connection or cleanup.
P010/P011: use final review/history qualifications, not outdated COMPLETE claims. README still describes hunter count in Settings; the user moved developer controls to Debug. Resolve such contradictions in the new documentation without silently rewriting source documents.
The supplied screenshots do not include an established current gameplay/Map1 gallery. List desired future captures (Map1 overview, hunter HUD, prop disguise, round result, host/client comparison) instead of fabricating them.

## Token efficiency
Start with PROJECT, this brief, current archived report and the curated manifest. Read only targeted asset/config sections and reviewed records needed to fill gaps. Reuse concise verified facts across local/Miro deliverables. No repeated testing, polling, full log ingestion or speculative refactoring.
