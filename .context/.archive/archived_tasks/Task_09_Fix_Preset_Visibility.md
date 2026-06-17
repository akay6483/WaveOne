# Ticket: 09 - Fix Preset Modal Visibility on Device Control

## Stage 1: Context Acquisition (MANDATORY)
@google/gemini-cli: Before generating any code, you MUST ingest the dashboard shell to analyze the newly refactored `AppBar` logic:
- @lib/products/waveone_v1_wifi/ui/waveone_dashboard.dart

## Stage 2: Task Execution
**Objective:** The user requires the `PresetModal` trigger to be accessible from the "Device Control" panel, not just the Equalizer. Modify the `AppBar` action rendering logic so that the Preset trigger is mounted when `_selectedIndex == 0`.
**Target Directory:** `lib/products/waveone_v1_wifi/ui/`

## Stage 3: Output Constraints

**1. Update `_buildAppBarActions` (or the `actions:` array)**
- Locate the conditional block handling `_selectedIndex == 0` (Device Control).
- Inject the `IconButton` (using `Icons.queue_music` or `Icons.save`) that triggers the `showModalBottomSheet` for the `PresetModal` into this block.
- The Device Control `AppBar` should now return three actions: Mode Selector, Remote Modal, and Preset Modal.
- If the Preset button should *also* remain on the Equalizer view (`_selectedIndex == 1`), ensure that logic remains intact.

**2. Execution Rule**
- Use the `write_file` tool to overwrite `waveone_dashboard.dart` with the updated logic.
- Run `flutter format .` via shell command after writing. 
- Do NOT just print markdown blocks to the terminal.