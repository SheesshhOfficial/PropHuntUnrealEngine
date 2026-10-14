# P012-R2 Verification Evidence: Settings Discard Contract & SoundMix Lifecycle

## Overview
This document records the verification and implementation details for Task P012-R2:
1. **Committed Settings Snapshot**: Implemented `SnapshotCommittedSettings` in `WBP_MainMenu`, called on widget construction after loading saved values and on every successful `Btn_ApplySettings` click. Stores baseline committed values into `CommittedMusicVolume`, `CommittedSFXVolume`, `CommittedSensitivity`, and `CommittedOverallGraphics`.
2. **Discard Contract on Back / Exit**: Wired full rollback sequence in `WBP_MainMenu`. Backing out or exiting without applying invokes `SetSoundMixClassOverride` using `CommittedMusicVolume` and `CommittedSFXVolume`, resetting audio mixer levels to the baseline committed snapshot. Video options are refreshed back via `SetVideoOptions`, ensuring any unapplied changes are discarded.
3. **SoundMix Modifier Ownership & Lifecycle**: Removed duplicate `PushSoundMixModifier` call on `Btn_ApplySettings`. SoundMix modifier is now pushed exactly once upon construct, establishing idempotent ownership and preventing modifier accumulation over repeated open/apply cycles.
4. **Boot vs Gameplay Navigation**: Maintained caller context branching via `bOpenedFromBoot` set by `WBP_Menu`. Boot back cleanly removes `WBP_MainMenu` from viewport; in-game pause back switches to pause menu index 0 without destroying sessions.
5. **Compilation & Manifest Integrity**: Verified clean compilation across all widgets (`WBP_MainMenu`, `WBP_Menu`, `WBP_DeveloperDebugPanel`), 0 dirty packages, and generated full-path 21-asset SHA256 manifest in `coordination/evidence/P012-R2-final-hashes.json`.
