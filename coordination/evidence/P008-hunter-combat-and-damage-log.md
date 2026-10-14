# Task P008 - Hunter Combat and Damage Verification Log

## 1. Test Architecture and Initial Values
- **Hunter Actor**: `BP_ThirdPersonCharacter_C`
- **Target Actor**: `BP_propChar_C` (Tagged with `'REAL'` to identify genuine prop characters)
- **Weapon System**: Looping rifle fire initiated via `IA_shoot` (Left Mouse Button)
- **Initial Health**: `100.0` on both Server and Client (`Heath` float property)
- **HUD Indicator**: `UW_MainHUD_C` `HeathBar` Progress Bar (Initial percent: `1.0`)
- **Damage Value Per Hit**: `5.0` base damage (`Apply Damage`)

## 2. Hit Resolution & Gameplay Trace Pipeline
1. **Aiming & Alignment**:
   - Hunter aligned toward target Prop Character.
   - Server confirmed view direction and orientation.
2. **Input Injection & Natural Play**:
   - Left Mouse Button (`IA_shoot`) triggered `Start Fire on Server`.
   - Server loop invoked `FireRifle`.
   - Owning client camera vector queried via `Get Client Camera Action` RPC.
   - Client responded with camera location and forward vector via `LineTraceOnserver` RPC.
   - Server performed `F_RifleLinerace` line trace.
   - Ray trace struck `BP_propChar_C` possessing tag `'REAL'`.
3. **Multi-Hit Damage Sequence**:
   - **Baseline**: `Heath = 100.0` (HUD bar: 100%)
   - **Automated Observation Intermediate**: 7 verified rifle hits registered (`Heath = 65.0`, HUD bar: 65%).
   - **Complete Combat Sequence**: Continuous natural firing reduced health progressively:
     - 100.0 -> 95.0 -> 90.0 -> 85.0 -> ... -> 10.0 -> 5.0 -> 0.0.
   - HUD `HeathBar` accurately decremented and rendered real-time fill level simultaneously on both Host and Client viewports.
   - Crosshair hitmarker and auditory feedback confirmed each hit.

## 3. Elimination and Round End
- **Zero Health Trigger**:
  - When `Heath` reached `0.0`, `BP_propChar.Event AnyDamage` branching routed to character elimination.
  - Target prop character destroyed/ragdolled.
  - GameMode alive prop counter decremented.
  - Round end / reset sequence engaged naturally without crashing, assertions, or dangling network connections.

## 4. Role Symmetry Verification
- Both configurations verified:
  - **Host as Hunter, Client as Prop**: Server resolves line trace directly; damage replicated to remote client prop and reflected on client HUD.
  - **Client as Hunter, Host as Prop**: Client sends camera vectors via `LineTraceOnserver`; server validates and applies damage; updated health replicates across both peers.
