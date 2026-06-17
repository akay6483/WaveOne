# Ticket: 04 - Integrate Composite Attenuation Modal

## Stage 1: Context Acquisition (MANDATORY)
@google/gemini-cli: Before generating any code, you MUST ingest the baseline architectural constraints, the existing atomic widget, the raw staged UI component, and the current testing dashboard:
- @GEMINI.md
- @lib/core/widgets/knob.dart
- @.context/translation_inbox/AttenuationModal_Raw.dart
- @lib/products/waveone_v1_wifi/ui/waveone_dashboard.dart

## Stage 2: Task Execution
**Objective:** Migrate the raw `AttenuationModal` into the core shared widgets layer. Refactor the V1 dashboard's local testing state to support 5 distinct knobs instead of 1, and render the new composite modal in the view.
**Target Directories:** `lib/core/widgets/` and `lib/products/waveone_v1_wifi/ui/`

## Stage 3: Output Constraints

**1. Component Integrity (STRICT READ-ONLY)**
- Do NOT modify `lib/core/widgets/knob.dart`. Treat it as immutable.

**2. Create `lib/core/widgets/attenuation_modal.dart`**
- Read the code from `@.context/translation_inbox/AttenuationModal_Raw.dart`.
- Write it directly into `lib/core/widgets/attenuation_modal.dart`.
- Ensure the import statement points correctly to `knob.dart` (e.g., `import 'knob.dart';`).

**3. Update `lib/products/waveone_v1_wifi/ui/waveone_dashboard.dart`**
- Remove the single `_currentKnobValue` state variable.
- Initialize 5 distinct state variables for the angles (e.g., `_frontLeftAngle`, `_frontRightAngle`, `_centerAngle`, `_rearLeftAngle`, `_rearRightAngle`), defaulting to `0.0`.
- Update the `build` method's `body` to render the `AttenuationModal` in the center of the screen.
- Pass appropriate dummy styling colors (e.g., `Colors.black87` for background, `Colors.white` for text).
- Map the 5 state variables to their respective `...Angle` parameters.
- Pass computed strings (e.g., `"${_frontLeftAngle.toInt()} dB"`) to the `...Text` parameters.
- Map the 5 `on...Turned` callbacks to update their respective state variables via `setState()`.

**4. Execution Rule**
- Use the `write_file` tool to output the files. Run `flutter format .` via shell command after writing. Do NOT just print markdown blocks to the terminal.