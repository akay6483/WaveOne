# Ticket: 08 - Debug Modal Visibility & AppBar Rendering

## Stage 1: Context Acquisition (MANDATORY)
@google/gemini-cli: Before generating any code, you MUST ingest the dashboard shell to identify why the Remote and Preset Modal triggers are failing to render in the UI tree:
- @lib/products/waveone_v1_wifi/ui/waveone_dashboard.dart

## Stage 2: Task Execution
**Objective:** The user reports that the `IconButton` triggers for the `RemoteModal` and `PresetModal` are missing from the UI on both Android and Desktop. Audit the conditional rendering logic and layout structure inside `waveone_dashboard.dart` and fix the widget tree so the icons are always accessible in their respective views.
**Target Directory:** `lib/products/waveone_v1_wifi/ui/`

## Stage 3: Output Constraints

**1. Audit the `AppBar` across Responsive Layouts**
- Ensure that BOTH the `mobileBody` and `desktopBody` layouts possess a top-level `AppBar` or header `Row`. If the `desktopBody` (NavigationRail layout) is missing an `AppBar`, wrap the `Row` inside a `Scaffold` that includes a unified `AppBar`.

**2. Fix Conditional Action Rendering**
- Locate the `actions: []` array in the `AppBar`.
- Implement robust conditional logic based on the `_selectedIndex`:
  - If `_selectedIndex == 0` (Device Control): Show the Remote `IconButton` (and Mode Selector if applicable).
  - If `_selectedIndex == 1` (Equalizer): Show the Preset `IconButton`.
- Ensure there are no syntax errors causing the `actions` array to render empty.

**3. Execution Rule**
- Use the `write_file` tool to overwrite `waveone_dashboard.dart` with the fixed layout. 
- Run `flutter format .` via shell command after writing. 
- Do NOT alter the underlying Modal widgets themselves; only fix the dashboard shell's routing triggers.