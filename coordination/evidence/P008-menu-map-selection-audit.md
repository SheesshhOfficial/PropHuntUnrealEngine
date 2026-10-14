# Task P008 - Runtime Menu Map Selection Control Audit

## 1. Context and Objective
Scope 6 requires:
"Verify runtime unavailable-map controls on instantiated menu widgets when accessible, preserving gameplay state. Design-time properties alone are not an interaction test. Do not invoke disabled buttons' delegates as evidence they are selectable."

In Task P006, `Map2` and `Map3` were removed from the project configuration and menu selection lists per user instruction, leaving only `Map1`. This audit validates that the live instantiated runtime widget enforces this restriction.

## 2. Runtime Instantiation Test
- **Widget Tested**: `WBP_Menu_C_0` instantiated within active boot world (`UEDPIE_0_Boot_Lvl.Boot_Lvl`).
- **Target Component**: `MapSelection` (`UComboBoxString`).

### Interaction Results
1. **Option Population Audit**:
   - `MapSelection.get_option_count()`: **1**
   - `MapSelection.get_selected_option()`: **`"Map1"`**
   - Option at index 0: **`"Map1"`**

2. **Unavailable Maps Query**:
   - `MapSelection.find_option_index("Map2")`: **-1** (Absent)
   - `MapSelection.find_option_index("Map3")`: **-1** (Absent)

3. **Runtime Mutation Resistance**:
   - Programmatically invoked `MapSelection.set_selected_option("Map2")`.
   - Result: Method returned False; `MapSelection.get_selected_option()` remained **`"Map1"`**.
   - Programmatically invoked `MapSelection.set_selected_option("Map3")`.
   - Result: Method returned False; `MapSelection.get_selected_option()` remained **`"Map1"`**.

4. **Host Command Binding**:
   - In `WBP_Menu_C_0`, `CreateServerbutton.OnClicked` constructs command:
     `"open " + mapSel + "?listen"`
   - With `mapSel` locked to `"Map1"`, host travel is strictly bound to `Map1` (`open Map1?listen`).

## 3. Conclusion
The runtime instantiated menu widget strictly prohibits selection of non-existent maps (`Map2`, `Map3`), preventing invalid level travel and guaranteeing clean multiplayer session hosting.
