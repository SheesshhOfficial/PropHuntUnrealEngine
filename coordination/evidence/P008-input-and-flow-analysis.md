# Task P008 - Enhanced Input and Blueprint Execution Flow Analysis

## 1. Enhanced Input Mapping Contexts
The project uses Unreal Engine's Enhanced Input subsystem with mappings defined in `/Game/Core/Input/`:

### IMC_Default (`/Game/Core/Input/IMC_Default`)
- `IA_ChangeProp` -> **E** (Key mapping, Value Type: `Digital (bool)`)
- `IA_shoot` -> **Left Mouse Button** (Key mapping, Value Type: `Digital (bool)`)
- `IA_Move` -> **W, S, A, D** / Up, Down, Left, Right (Axis2D)
- `IA_Jump` -> **Space Bar** (Digital bool)
- `IA_spawnProp` -> **X** (Digital bool)
- `IA_RotationLock` -> **R** (Digital bool)
- `IA_Taunt` -> **T** (Digital bool)

### IMC_MouseLook (`/Game/Core/Input/IMC_MouseLook`)
- `IA_MouseLook` -> **Mouse 2D** (Axis2D)

Both mapping contexts are added to `UEnhancedInputLocalPlayerSubsystem` during pawn initialization (`AddMappingContext`, Priority `0`).

---

## 2. Prop Transformation Flow (`BP_propChar`)

### Input Binding
In `BP_propChar`:
- Event `EnhancedInputAction IA_ChangeProp` -> `Triggered` pin triggers custom event `Change Prop on Server`.

### Network & Gameplay Logic
1. **`Change Prop on Server`**:
   - Declared as `Run on Server`, `Reliable`.
   - Checks branch: `PropChangesLeft > 0`.
2. **Detection Trace**:
   - Executes `Sphere Trace By Channel`:
     - Channel: `Visibility` (or default object trace channel)
     - Start: `GetActorLocation() + Vector(0, 0, 10)`
     - End: `GetActorLocation() + Vector(0, 0, 10)`
     - Radius: `100.0`
3. **Actor & Mesh Validation**:
   - On `OutHit.HitActor`: Casts to `StaticMeshActor`.
   - Checks if hit actor's `StaticMeshComponent.StaticMesh` is contained in `PropAllowedMesh` array (44 valid meshes) **OR** if hit actor has Actor Tag `'Prop'`.
   - Checks that hit mesh != current `PropMesh.StaticMesh`.
4. **Multicast Update**:
   - Calls `UpdateMeshMulticast(NewMesh, ...)` (`NetMulticast`, `Reliable`).
   - Inside `UpdateMeshMulticast`:
     - Sets `PropMesh.SetStaticMesh(NewMesh)`.
     - Updates collision profile and bounds.
     - On Server: Decrements `PropChangesLeft` (`PropChangesLeft = PropChangesLeft - 1`), resets `SpawnPropsLeft = 3`.
     - On Client: Mesh and transform replicate via multicast RPC and Actor replication.

---

## 3. Hunter Shooting and Damage Flow (`BP_ThirdPersonCharacter`)

### Input Binding
In `BP_ThirdPersonCharacter`:
- Event `EnhancedInputAction IA_shoot` -> `Started` pin triggers `Start Fire on Server`.
- `Completed` pin triggers `Stop Fire on Server`.

### Network & Gameplay Logic
1. **`Start Fire on Server`**:
   - Declared as `Run on Server`, `Reliable`.
   - Sets looping timer (`SetTimerByFunctionName` or `SetTimerByEvent`) calling `FireRifle` every fire interval.
2. **Client Aim Coordination (`FireRifle`)**:
   - Calls `Get Client Camera Action` (`Client`, `Reliable` RPC back to owning controller).
   - Client fetches local camera location and forward vector (`FollowCamera.GetWorldLocation()`, `FollowCamera.GetForwardVector()`).
   - Client invokes `LineTraceOnserver(CameraLocation, ForwardVector)` (`Run on Server`, `Reliable` RPC).
3. **Server Hit Resolution (`LineTraceOnserver` -> `F_RifleLinerace`)**:
   - Server performs `Line Trace By Channel`:
     - Start: `CameraLocation`
     - End: `CameraLocation + ForwardVector * MaxRange` (10,000 units)
   - Checks `OutHit.HitActor.Tags`:
     - If hit actor has Tag `'REAL'` (assigned to genuine prop character `BP_propChar`):
       - Calls `Apply Damage`:
         - DamagedActor: `HitActor`
         - BaseDamage: `5.0`
         - DamageTypeClass: `DamageType`
       - Calls Client RPC `HitmarkerMulticast` / hit sound / crosshair animation.
4. **Prop Health Processing (`BP_propChar.Event AnyDamage`)**:
   - Receives `Damage` (5.0).
   - Computes `Heath = FMath::Clamp(Heath - Damage, 0.0, 100.0)`.
   - Replicates updated `Heath` to HUD via `HeathBar.SetPercent(Heath / 100.0)`.
   - If `Heath <= 0.0`:
     - Triggers elimination sequence: ragdoll/destruction, updates alive prop count, checks round end conditions.
