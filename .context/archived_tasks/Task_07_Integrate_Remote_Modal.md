# Ticket: 07 - Integrate Remote Modal & Refactor RN Patterns

## Stage 1: Context Acquisition (MANDATORY)
@google/gemini-cli: Before generating any code, you MUST ingest the baseline architecture, the global theme, the raw translated component, and the current dashboard shell:
- @GEMINI.md
- @lib/core/theme/app_theme.dart
- @.context/translation_inbox/remote_modal_raw.dart
- @lib/products/waveone_v1_wifi/ui/waveone_dashboard.dart

## Stage 2: Task Execution
**Objective:** Migrate the raw `RemoteModal` into the V1 WiFi widgets directory. Refactor it to remove the React Native `visible` boolean pattern, apply strict global theming to the `_RemoteButton` class, and wire it into the `waveone_dashboard.dart` shell as a native `showDialog`.
**Target Directories:** `lib/products/waveone_v1_wifi/ui/widgets/` and `lib/products/waveone_v1_wifi/ui/`

## Stage 3: Output Constraints

**1. Create `lib/products/waveone_v1_wifi/ui/widgets/remote_modal.dart`**
- Read the raw code from `@.context/translation_inbox/remote_modal_raw.dart`.
- **Strip RN Pattern:** Remove the `visible` property from the constructor and the `if (!visible) return...` check.
- **Strip Overlay:** Remove the outer root `Container` (which uses `colors.modalOverlay`). The `build` method should directly return the inner `Container` (the actual 380px wide modal) wrapped in a `Dialog` widget with a transparent background.
- **Strict Theming:** Audit the `_RemoteButton` private class. Remove `Colors.grey[800]` and `Colors.white`. Map these to your `AppColorsExtension` (e.g., using `surfaceContainer` or `buttonBackground` for the shape, and standard text/icon colors for the foreground).
- **State Deferral:** Add `// TODO: Refactor callbacks to dispatch hardware events via WaveOneBloc` above the `_RemoteButton` instantiations.

**2. Update `lib/products/waveone_v1_wifi/ui/waveone_dashboard.dart`**
- Import the new `remote_modal.dart` component.
- Locate the `AppBar` in the active "Device Control" view (next to the Mode Selector `IconButton`).
- Add a new `IconButton` (using `Icons.settings_remote`).
- In the `onPressed` callback, invoke `showDialog(context: context, builder: (context) => RemoteModal(onClose: () => Navigator.of(context).pop()));`.
- **State Deferral:** Add `// TODO: Refactor remote trigger visibility based on active product connection state` above the button.

**3. Execution Rule**
- Use the `write_file` tool to output the files. Run `flutter format .` via shell command on the workspace after writing. Do NOT just print markdown blocks to the terminal.