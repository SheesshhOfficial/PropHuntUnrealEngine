# Agreed Roadmap - 2026-10-06

1. P009: Session cleanup plus Windows packaged-game validation. Fix only observed blockers through separately reviewed tasks. Round lifecycle accepted as USER-TESTED, not independently certified. P008 gameplay claims are retained as reported evidence; its review was not completed before the user redirected scope.
2. UI and widget redesign: Codex inventories existing screens and supplies a cohesive visual/interaction brief to Antigravity, then reviews implementation in staged milestones. Cover boot/main menu, hosting/joining/server browser, lobby/role/map selection, settings, HUD, pause/disconnect/error feedback and match results. Preserve gameplay/session bindings.
   Initial direction: energetic arcade Prop Hunt style; dark navy/charcoal surfaces, vivid cyan and warm orange team accents, bold readable type, clear primary actions, polished role badges, restrained animated backgrounds and short responsive hover/press/focus transitions. HUD prioritizes timer, role, health and prop-change count with uncluttered feedback. Controller/keyboard focus, scaling across resolutions, readable contrast and reduced-motion behavior are part of the design. This is an initial direction to refine against actual screenshots/widget inventory, not permission for a global speculative resave.
   Deliver a concrete screen-by-screen design and interaction/state specifications before implementation; validate screenshots and real host/join/gameplay flows after changes. Antigravity implements; Codex reviews. No visual mockup should be presented as implemented UI.
3. Add more transformable props to Map1 with clear interaction affordances and supported gameplay validation.
4. Resolve missing background music based on user preference (restore intended asset, replace, or intentionally remove). No default silent removal.
5. Steam/internet matchmaking, voice chat, and performance work as separately scoped milestones with appropriate real environment evidence. Additional UI polish follows actual use/testing.

Map2/Map3 are excluded indefinitely unless the user later requests adding them. Do not schedule their restoration.

Finish criteria for each milestone are explicit; do not repeat passed tests without a relevant change, evidence gap or reproduced failure. No commits/pushes/installations implied by this roadmap.
