# Ticket: 06 - Integrate Mode Selector Modal & Apply Theme

## Stage 1: Context Acquisition (MANDATORY)
@google/gemini-cli: Before generating any code, you MUST ingest the baseline architecture, the global theme, the raw translated component, and the current dashboard shell:
- @GEMINI.md
- @lib/core/theme/app_theme.dart
- @.context/translation_inbox/ModeSelector_Raw.dart
- @lib/products/waveone_v1_wifi/ui/waveone_dashboard.dart

## Stage 2: Task Execution
**Objective:** Migrate the raw `ModeSelector` into the V1 WiFi widgets directory. Refactor it into a temporary `StatefulWidget` using strict global theming, and wire it into the `waveone_dashboard.dart` shell as a native `showModalBottomSheet`.
**Target Directories:** `lib/products/waveone_v1_wifi/ui/widgets/` and `lib/products/waveone_v1_wifi/ui/`

## Stage 3: Output Constraints

**1. Create `lib/products/waveone_v1_wifi/ui/widgets/mode_selector.dart`**
- Read the raw code from `@.context/translation_inbox/ModeSelector_Raw.dart`.
- Convert `ModeSelector` into a `StatefulWidget` to temporarily track local state (e.g., active mode string). 
- **State Management Deferral:** Add this exact comment above the state variable: `// TODO: Refactor activeMode to be injected via BlocBuilder`.
- Strip out the passed color properties (`cardColor`, `borderColor`, etc.) from the constructor. 
- Replace all color assignments in the `build` method using strict theming:
  - Backgrounds/Surfaces: `Theme.of(context).extension<AppColorsExtension>()!.modalBackground` (or closest equivalent).
  - Inactive Text/Icons: `Theme.of(context).extension<AppColorsExtension>()!.textMuted` (or inactive equivalent).
  - Active Mode: `Theme.of(context).colorScheme.primary`.

**2. Update `lib/products/waveone_v1_wifi/ui/waveone_dashboard.dart`**
- Import the new `mode_selector.dart` component.
- Locate the `AppBar` (or the top control section of the active "Device Control" view).
- Add an `IconButton` (using `Icons.tune` or `Icons.settings_input_component`).
- In the `onPressed` callback, invoke `showModalBottomSheet(context: context, builder: (context) => const ModeSelector())`.
- **State Management Deferral:** Add this exact comment above the `onPressed` logic: `// TODO: Refactor modal trigger and mode state to listen to WaveOneBloc.`

**3. Execution Rule**
- Use the `write_file` tool to output the files. Run `flutter format .` via shell command on the workspace after writing. Do NOT just print markdown blocks to the terminal.