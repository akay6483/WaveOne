# Ticket: 12 - Final UI Component Integration

## Stage 1: Context Acquisition (MANDATORY)
@google/gemini-cli: Before generating any code, ingest the baseline architecture, global theme, and relevant source files:
- @GEMINI.md
- @lib/core/theme/app_theme.dart
- @.context/translation_inbox/device_info_modal_raw.dart
- @.context/translation_inbox/help_modal_raw.dart
- @.context/translation_inbox/app_layout_shell_raw.dart
- @lib/products/waveone_v1_wifi/ui/waveone_dashboard.dart
- @lib/products/waveone_v1_wifi/ui/device_connect_screen.dart

## Stage 2: Task Execution
**Objective:** Finalize the visual testing phase by integrating the last remaining translated components (`app_layout_shell`, `device_info_modal`, `help_modal`). Wire them up via the existing `DeviceConnectScreen` callbacks and ensure strict theme compliance.
**Target Directories:** `lib/core/widgets/`, `lib/core/ui/layouts/`, and `lib/products/waveone_v1_wifi/ui/`

## Stage 3: Output Constraints

**1. File Placement & Renaming**
- Create the folders if missing.
- Migrate files strictly to:
  - `lib/core/widgets/device_info_modal.dart`
  - `lib/core/widgets/help_modal.dart`
  - `lib/core/ui/layouts/app_layout_shell.dart`

**2. Patch Invalid Material Icons (in `app_layout_shell.dart`)**
- Locate icon mappings and apply these fixes:
  - `Icons.wifi_outline` -> `Icons.network_wifi`
  - `Icons.surround_sound_outlined` -> `Icons.surround_sound`
  - `Icons.graphic_eq_outlined` -> `Icons.graphic_eq`

**3. Wire Up Modals in `waveone_dashboard.dart`**
- Locate the `DeviceConnectScreen` instantiation.
- **Help Modal:** Wire `onOpenHelp` to display: `showModalBottomSheet(context: context, isScrollControlled: true, builder: (context) => HelpModal(onClose: () => Navigator.pop(context)))`.
- **Device Info Modal:** Wire `onOpenInfo` to display: `showDialog(context: context, builder: (context) => DeviceInfoModal(...))`.
- **Mock State:** Pass mock data to the info modal (e.g., `deviceName: "WaveOne V1"`, `ipAddress: "192.168.1.15"`, `status: "Connected"`). Wrap the mock password visibility state in the dashboard's `StatefulWidget` using `setState`.
- **State Management Deferral:** Add `// TODO: Refactor DeviceInfo state and network metadata to listen to WaveOneBloc.` above the stateful properties.

**4. Strict Theming Verification**
- Audit the three new files for hardcoded hex colors. Replace any findings with: `Theme.of(context).extension<AppColorsExtension>()!.textMuted` or corresponding color tokens.

**5. Execution Rule**
- Ensure you do NOT overwrite `main_navigation_shell.dart` from Task 11.
- Use the `write_file` tool to output all files. Run `flutter format .` via shell command upon completion.