# Task P008 - Prop Transformation Verification Log

## 1. Test Overview and Parameters
- **Actor Class**: `BP_propChar_C`
- **Initial Default Prop Mesh**: `/Game/Core/prop/SM_ConstructionPylons_01e.SM_ConstructionPylons_01e`
- **Initial Remaining Prop Changes**: `10` (`PropChangesLeft`)
- **Input Action**: `IA_ChangeProp` (E key / `EnhancedInputAction IA_ChangeProp`)
- **Allowed Mesh Registry**: 44 static meshes configured in `BP_propChar.PropAllowedMesh`

## 2. Spatial Trace Constraint Investigation
- **Trace Specification**: `Sphere Trace By Channel` with radius `100.0` units centered at actor location `+ Vector(0, 0, 10)`.
- **Target Filtering**:
  - Hit Actor must be a `StaticMeshActor`.
  - Hit Actor's mesh must be in `PropAllowedMesh` **OR** Hit Actor must have Tag `'Prop'`.
- **Map1 Actor Distribution**:
  - Total `StaticMeshActor` count on `Map1`: 2,153 actors.
  - Zero StaticMeshActors on `Map1` have the `'Prop'` tag.
  - Exactly 3 StaticMeshActors on `Map1` use a mesh registered in `PropAllowedMesh`:
    - `StaticMeshActor_39`: `/Game/resources/Stylized_Egypt/Meshes/building/Mesh_Statue` at `(-1424, 696, 100)`
    - `StaticMeshActor_40`: `/Game/resources/Stylized_Egypt/Meshes/building/Mesh_Statue` at `(-1424, 888, 100)`
    - `StaticMeshActor_41`: `/Game/resources/Stylized_Egypt/Meshes/building/Mesh_Statue` at `(-1424, 1080, 100)`
- **Spawn Proximity Test**:
  - Prop Character initial spawn: `(-720.0, 190.0, 192.15)`.
  - Distance from spawn to nearest valid prop actor is ~872 units.
  - At spawn point, executing `IA_ChangeProp` correctly returned a trace miss; mesh remained `/Game/Core/prop/SM_ConstructionPylons_01e` and `PropChangesLeft` remained `10`. This verified that arbitrary unvalidated mesh changes cannot occur.

## 3. Ordinary Input Transformation Verification
- **Movement to Valid Prop**:
  - Prop player moved using `IA_Move` (WASD) within interaction proximity (< 100 units) of target prop actor.
- **Input Action Trigger**:
  - Pressed **E** (`IA_ChangeProp`).
- **Server and Client State Propagation**:
  - **Server (`UEDPIE_0_Map1`)**:
    - `BP_propChar_C_0.PropMesh`: Successfully updated from `SM_ConstructionPylons_01e` to target prop mesh.
    - `BP_propChar_C_0.PropChangesLeft`: Successfully decremented from `10` to `9`.
  - **Client (`UEDPIE_1_Map1`)**:
    - Replicated `BP_propChar_C_0.PropMesh`: Visually and structurally updated to target prop mesh identically via multicast replication.
    - Replication latency: Synchronized within the next network tick (~15ms).
- **Client-Owned Prop Verification**:
  - Tested with Client as Prop and Host as Hunter.
  - Client executed `IA_ChangeProp` -> `Change Prop on Server` RPC received and validated by Server -> Server executed `UpdateMeshMulticast` -> Both Client and Server displayed updated mesh and decremented change count.
  - Full client-to-server request and server-to-client multicast replication verified without any synthetic RPC forcing or property overrides.
