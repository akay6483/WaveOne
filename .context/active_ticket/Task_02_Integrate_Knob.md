# Ticket: 02 - Wire Shared Knob Component to Test Dashboard

## Stage 1: Context Acquisition (MANDATORY)
@google/gemini-cli: Before generating any code, you MUST ingest the baseline architectural constraints and read the existing UI component:
- @GEMINI.md
- @lib/core/widgets/knob.dart

## Stage 2: Task Execution
**Objective:** The translated `knob.dart` file is already in place as a core shared widget. Your task is to analyze its constructor parameters and wire it into the V1 WiFi product dashboard using a temporary `StatefulWidget` for visual testing.
**Target Directory:** `lib/products/waveone_v1_wifi/ui/`

## Stage 3: Output Constraints

**1. Component Integrity (STRICT READ-ONLY)**
- Do NOT attempt to rewrite, modify, or output `lib/core/widgets/knob.dart`. Treat this file as immutable context.

**2. Update `lib/products/waveone_v1_wifi/ui/waveone_dashboard.dart`**
- Convert this file into a `StatefulWidget` temporarily (we will refactor to `flutter_bloc` later).
- Create a local state variable `double _currentKnobValue = 0.0;`.
- Build a UI layout:
  - Return a `Scaffold` with an `AppBar` titled "WaveOne V1 (Testing)".
  - In the `body`, create a `Center` widget containing a `Column` (ensure main axis alignment is centered).
  - Inside the `Column`, display a `Text` widget showing the `_currentKnobValue` rounded to 2 decimal places.
  - Below the text, instantiate the `Knob` widget imported from `package:waveone/core/widgets/knob.dart` (adjust import based on actual package name).
  - Pass `_currentKnobValue` to the Knob's value parameter.
  - In the Knob's `onChanged` callback, call `setState()` to update `_currentKnobValue` with the new value.

**3. Execution Rule**
- Use the `write_file` tool to overwrite `waveone_dashboard.dart` directly. Run `flutter format` via shell command on the target directory after writing. Do NOT just print markdown blocks to the terminal.