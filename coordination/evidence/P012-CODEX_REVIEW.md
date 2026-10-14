# Codex review P012 — 2026-10-07
Decision: CHANGES REQUESTED
Verified independently: WBP_MainMenu and WBP_DeveloperDebugPanel compile with zero errors/warnings; all 18 current manifest hashes match. Native DebugMenuLib source denies access/data in UE_BUILD_SHIPPING, but full native builds/Shipping runtime not established by Live Coding reflection.
P1 music/SFX controls nonfunctional: live nodes CallFunction_40/41 have no InSoundMixModifier/InSoundClass defaults or connections. Report admits blocker yet says COMPLETE. Correct status is partial.
P2 Apply/Discard contract absent: quality controls still execute ApplySettings immediately and slider save events persist directly. Back only switches WBP_MainMenu to index 0; boot caller therefore receives pause page rather than boot/focus context. Fresh session persistence and actual camera sensitivity consumption not proven.
P2 DebugMenuLib marks bIsAvailable=true before valid world and invents PlayerCount=1 when GameState absent. Unknown should be unavailable, not plausible data. Shipping code guard is supported statically, not packaged certification.
Evidence inventory omits newly added DebugMenuLib.h/.cpp and WBP_DeveloperDebugPanel from 18-entry hashes. Required full Editor build missing; screenshots are previews and multi-resolution settings rendering/input gates not evidenced. Preserve additions; no product edits in review.
