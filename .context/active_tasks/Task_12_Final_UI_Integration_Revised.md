# Ticket: 12 - Final UI Integration (Revised & Optimized)

## Stage 1: Context Acquisition (MANDATORY)
@google/gemini-cli: Ingest the current UI state. Treat these files as the source of truth for the dashboard shell and widget tree:
- @GEMINI.md
- @lib/core/ui/layouts/app_layout_shell.dart
- @lib/products/waveone_v1_wifi/ui/waveone_dashboard.dart
- @.context/translation_inbox/device_info_modal_raw.dart
- @.context/translation_inbox/help_modal_raw.dart

## Stage 2: Task Execution
**Objective:** Mechanically place the final 3 translated components, fix their icons, encapsulate local state within the modals, and wire them to the dashboard. 

## Stage 3: Output Constraints

**1. File Relocation & Renaming**
- Move and rename the following files exactly as specified:
  - `app_layout_shell_raw.dart` -> `lib/core/ui/layouts/app_layout_shell.dart`
  - `device_info_modal_raw.dart` -> `lib/core/widgets/device_info_modal.dart`
  - `help_modal_raw.dart` -> `lib/core/widgets/help_modal.dart`

**2. Patch Icons in `app_layout_shell.dart`**
- Perform these exact string replacements to fix icon mappings:
  - `Icons.wifi_outline` -> `Icons.network_wifi`
  - `Icons.surround_sound_outlined` -> `Icons.surround_sound`
  - `Icons.graphic_eq_outlined` -> `Icons.graphic_eq`

**3. Refactor `device_info_modal.dart` (Self-Contained State)**
- Convert `DeviceInfoModal` into a `StatefulWidget`.
- Remove `showPassword` and `onTogglePassword` from the constructor parameters.
- Initialize `bool _showPassword = false;` inside the State class.
- Update the toggle icon's `onTap` to call `setState(() { _showPassword = !_showPassword; });`.
- Ensure all styling uses `Theme.of(context).extension<AppColorsExtension>()!`.

**4. Wire Up Modals in `waveone_dashboard.dart`**
- Locate the `DeviceConnectScreen` instantiation.
- **Help Modal:** Wire `onOpenHelp` to display: `showModalBottomSheet(context: context, isScrollControlled: true, builder: (context) => const HelpModal())`.
- **Device Info Modal:** Wire `onOpenInfo` to display: `showDialog(context: context, builder: (context) => const DeviceInfoModal())`.
- **State Management Deferral:** Place `// TODO: Refactor DeviceInfo state and network metadata to listen to WaveOneBloc.` above the modal triggers.

**5. Execution Rule**
- Write all generated code directly to the disk.
- Run `flutter format .` upon completion.