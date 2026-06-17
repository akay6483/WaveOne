# Ticket: 08 - Integrate Core Remote Modal & Apply Theme

## Stage 1: Context Acquisition (MANDATORY)
@google/gemini-cli: Before generating any code, you MUST ingest the architecture, theme extensions, raw component data, and the dashboard shell:
- @GEMINI.md
- @lib/core/theme/app_theme.dart
- @.context/translation_inbox/remote_modal_raw.dart
- @lib/products/waveone_v1_wifi/ui/waveone_dashboard.dart

## Stage 2: Task Execution
**Objective:** Migrate the updated `RemoteModal` into the core widget library. Apply strict theming using specific `AppColorsExtension` keys, and wire it into the `waveone_dashboard.dart` shell as a native `showModalBottomSheet`.
**Target Directories:** `lib/core/widgets/` and `lib/products/waveone_v1_wifi/ui/`

## Stage 3: Output Constraints

**1. Create `lib/core/widgets/remote_modal.dart`**
- Read from `@.context/translation_inbox/remote_modal_raw.dart`.
- Refactor the component to a `StatefulWidget` to track mock state (e.g., Play/Pause, Mute toggles).
- **State Management Deferral:** Add `// TODO: Refactor remote hardware commands and state to map to WaveOneBloc events.` above state variables and `onPressed` callbacks.
- **Strict Theming (NO HARDCODED HEX):**
  - Background: `Theme.of(context).extension<AppColorsExtension>()!.remoteModalBg`
  - Button Text: `Theme.of(context).extension<AppColorsExtension>()!.remoteButtonText`
  - Power Text: `Theme.of(context).extension<AppColorsExtension>()!.remotePowerText`
  - Play/Pause Text: `Theme.of(context).extension<AppColorsExtension>()!.remotePlayText`
  - EQ Text: `Theme.of(context).extension<AppColorsExtension>()!.remoteEqText`
  - Fills: Use `Theme.of(context).colorScheme.primary` (Play) and `Theme.of(context).colorScheme.error` (Power) for backgrounds.

**2. Update `lib/products/waveone_v1_wifi/ui/waveone_dashboard.dart`**
- Import `package:waveone/core/widgets/remote_modal.dart`.
- In the AppBar actions of the primary control view, add an `IconButton` (using `Icons.settings_remote`).
- Add logic: `showModalBottomSheet(context: context, isScrollControlled: true, builder: (context) => const RemoteModal())`.
- Ensure the modal is properly sized for both mobile and desktop constraints.

**3. Execution Rule**
- Use the `write_file` tool to output the files. Run `flutter format .` via shell command after writing. Do NOT just print markdown blocks to the terminal.