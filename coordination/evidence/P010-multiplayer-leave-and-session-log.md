# Task P010 - Multiplayer Leave Session & Rejoin Execution Log

## 1. Test Environment and Session Setup
- **Engine Version**: Unreal Engine 5.7.4 (Release-5.7-CL-51494982)
- **Editor PID**: 18776 (Monolith server active on port 9316)
- **Test Topology**: 2-Client Play-In-Editor (`LevelEditorPlaySettings.PlayNumberOfClients = 2`)
- **Initial State**:
  - Host World: `UEDPIE_0_Boot_Lvl.Boot_Lvl`
  - Client World: `UEDPIE_1_Boot_Lvl.Boot_Lvl`
  - Dirty Packages: `0`

---

## 2. Multi-Step Lifecycle Verification

### Step 1: Initial Session Creation and Join
1. **Host (`UEDPIE_0`)**:
   - Executed `open Map1?listen`.
   - Traveled from `UEDPIE_0_Boot_Lvl` to `UEDPIE_0_Map1.Map1`.
   - Initialized `GM_ProphuntGameMode_C_0` and bound listen port `7777`.
2. **Client (`UEDPIE_1`)**:
   - Executed `open 127.0.0.1:7777`.
   - Successfully established connection and traveled from `UEDPIE_1_Boot_Lvl` to `UEDPIE_1_Map1.Map1`.
3. **Multiplayer State Confirmed**:
   - Host `GM_ProphuntGameMode_C_0.get_num_players()` returned `2`.
   - Both peers running `BP_ThirdPersonPlayerController_C_0`.

---

### Step 2: Client Leave Session & Return to Boot_Lvl
1. **Pause Menu Triggered on Client**:
   - Instantiated `WBP_MainMenu` on Client `BP_ThirdPersonPlayerController_C_0`.
   - Initial `LeaveConfirmOverlay` visibility: `Collapsed`.
2. **Click `BTN_LeaveSession`**:
   - Evaluated `IsServer` -> returned `false` (Client context).
   - Dynamically set `Txt_LeaveMessage` text to:
     `"Are you sure you want to leave the session and return to the main menu?"`
   - `LeaveConfirmOverlay` transitioned to `Visible`.
3. **Cancel Action Tested**:
   - Triggered `BTN_CancelLeave.OnClicked`.
   - `LeaveConfirmOverlay` cleanly transitioned back to `Collapsed`.
   - Resumed gameplay unchanged.
4. **Confirm Action Executed**:
   - Re-opened modal and triggered `BTN_ConfirmLeave.OnClicked`.
   - `Txt_LeaveStatus` displayed `"Leaving session..."`.
   - `BTN_ConfirmLeave` and `BTN_CancelLeave` disabled to prevent duplicate submissions.
   - Invoked `MenuGameinstance.LeaveGameSession`:
     - Set `bIsLeavingSession = true`.
     - Called `DestroySession(PlayerController=0)`.
     - On completion / fallback: Called `OpenLevelBySoftObjectPtr('/Game/Core/Map/Boot_Lvl')`.
     - Reset `bIsLeavingSession = false`.
5. **State Observation Post-Client Leave**:
   - Client World: Successfully returned to `UEDPIE_1_Boot_Lvl.Boot_Lvl` (`Client on Map1: False`, `Client on Boot_Lvl: True`).
   - Host World: Remained active on `UEDPIE_0_Map1.Map1` (`Host on Map1: True`).
   - Player Roster: Host GameMode player count decremented cleanly from `2` to `1`. No crash, no disconnect on host.

---

### Step 3: Client Rediscovery and Rejoin
1. **Rejoin Triggered**:
   - From `UEDPIE_1_Boot_Lvl`, Client executed `open 127.0.0.1:7777`.
2. **Network Travel Completed**:
   - Client successfully re-connected to the active host server on `Map1`.
3. **State Observation Post-Rejoin**:
   - Client World: Re-joined `UEDPIE_1_Map1.Map1` (`Client back on Map1: True`).
   - Host World: Remained uninterrupted on `UEDPIE_0_Map1.Map1` (`Host on Map1: True`).
   - Player Roster: Host GameMode player count incremented back to `2`.
   - Confirmed no duplicate player controllers or stale session tokens.

---

### Step 4: Host Leave Session & Client Departure Handling
1. **Pause Menu Triggered on Host**:
   - Instantiated `WBP_MainMenu` on Host `BP_ThirdPersonPlayerController_C_0`.
2. **Click `BTN_LeaveSession`**:
   - Evaluated `IsServer` -> returned `true` (Host authority context).
   - Dynamically set `Txt_LeaveMessage` text to:
     `"You are the host. Leaving will end the session and disconnect all players."`
   - `LeaveConfirmOverlay` transitioned to `Visible`.
3. **Confirm Action Executed on Host**:
   - Triggered `BTN_ConfirmLeave.OnClicked`.
   - Status updated to `"Leaving session..."`.
   - Invoked `MenuGameinstance.LeaveGameSession` on host.
   - Host executed `DestroySession` and traveled to `UEDPIE_0_Boot_Lvl.Boot_Lvl`.
4. **Client Departure Handling**:
   - Severed connection triggered Client `MenuGameinstance.Event NetworkError`.
   - Handler executed `DestroySession` and traveled to `UEDPIE_1_Boot_Lvl.Boot_Lvl`.
5. **State Observation Post-Host Leave**:
   - Host World: Parked cleanly on `UEDPIE_0_Boot_Lvl.Boot_Lvl` (`Host on Map1: False`, `Host on Boot_Lvl: True`).
   - Client World: Parked cleanly on `UEDPIE_1_Boot_Lvl.Boot_Lvl` (`Client on Map1: False`, `Client on Boot_Lvl: True`).
   - Both peers returned to main menu without application hang, lockup, or fatal assert.

---

### Step 5: Second Complete Cycle (Rehosting & Rejoining)
1. **Re-host from Boot_Lvl**:
   - Without restarting editor or PIE, Host executed `open Map1?listen`.
   - Host arrived on `UEDPIE_0_Map1.Map1`.
2. **Re-join from Boot_Lvl**:
   - Client executed `open 127.0.0.1:7777`.
   - Client arrived on `UEDPIE_1_Map1.Map1`.
3. **Verification**:
   - Host GameMode player count: `2`.
   - Demonstrated complete end-to-end multi-round lifecycle robustness without state degradation.

---

## 3. Teardown and Preference Restoration
- Terminated PIE session via `monolith:editor_query(stop_pie)`.
- Restored `LevelEditorPlaySettings.PlayNumberOfClients` from `2` back to `1`.
- Parked editor world on `/Game/Core/Map/Boot_Lvl`.
- Verified `0` dirty packages in Unreal Editor.
