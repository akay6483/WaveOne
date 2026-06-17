# Ticket: 11 - Integrate V1 WiFi Product Views & Navigation Shell

## Stage 1: Context Acquisition (MANDATORY)
@google/gemini-cli: Before generating any code, you MUST ingest the baseline architecture, the global theme, the raw translated components, and the current dashboard host:
- @GEMINI.md
- @lib/core/theme/app_theme.dart
- @lib/core/theme/responsive_layout.dart
- @.context/translation_inbox/control_dashboard_view.dart
- @.context/translation_inbox/device_connect_screen_raw.dart
- @.context/translation_inbox/main_navigation_shell_raw.dart
- @lib/products/waveone_v1_wifi/ui/waveone_dashboard.dart

## Stage 2: Task Execution
**Objective:** Integrate the decoupled React Native translated UI components into the V1 WiFi product module. Wire up mock state, enforce strict `ResponsiveLayout` architecture, and apply standard `AppTheme` rules.
**Target Directory:** `lib/products/waveone_v1_wifi/ui/`

## Stage 3: Output Constraints

**1. File Placement & Renaming**
- Read the raw files from the translation inbox.
- Create their finalized versions strictly in `lib/products/waveone_v1_wifi/ui/`:
  - `control_dashboard_view.dart`
  - `device_connect_screen.dart`
  - `main_navigation_shell.dart`

**2. Refactor `main_navigation_shell.dart` (Responsiveness)**
- Refactor the component to use the project's `ResponsiveLayout` wrapper.
- **Mobile Layout (`mobileBody`):** Use the existing `BottomNavigationBar` implementation.
- **Desktop Layout (`desktopBody`):** Return a `Scaffold` containing a `Row`. The left side must be a `NavigationRail` mirroring the tab items (Devices, Control, DSP). The right side must be an `Expanded` widget containing the `child` screen body.
- Apply strict `Theme.of(context)` styling to the `NavigationRail` matching the `BottomNavigationBar` colors via `AppColorsExtension`.

**3. Wire Up `waveone_dashboard.dart` (Host State)**
- Update the dashboard to act as the stateful parent holding the current tab index (`_selectedIndex`), active mode, and knob angles.
- In the `build` method, return the newly refactored `MainNavigationShell`.
- Pass the appropriate screen into the shell's `child` parameter based on `_selectedIndex`:
  - Index 0: `DeviceConnectScreen()`
  - Index 1: `ControlDashboardView()`
  - Index 2: A simple placeholder `Container(child: Center(child: Text('DSP View')))` until translated.

**4. Integrate `control_dashboard_view.dart`**
- Inside `waveone_dashboard.dart`, pass the required mock state variables (`mainVolAngle`, `activeMode`, etc.) down to `ControlDashboardView`.
- Wire up the callback functions (`onMainVolTurned`, `onOpenAttenuation`, `onOpenPresets`, `onOpenRemote`) to trigger the modals built in previous tasks (`showModalBottomSheet` for Remote/Presets, `showDialog` for Attenuation).
- **State Management Deferral:** Place `// TODO: Refactor knob state/modal triggers to use WaveOneBloc.` above these host callbacks.

**5. Integrate `device_connect_screen.dart`**
- Adapt the raw layout to serve as the local WiFi/Bluetooth discovery scanner.
- In `waveone_dashboard.dart`, pass a mock list of `DeviceUIModel` entries to visualize discovered hardware.
- Implement a mock toggle for the `activeMode` (WiFi vs Bluetooth).

**6. Execution Rule**
- Ensure NO core widgets or core UI folders are polluted with these product-specific views.
- Ensure all styling strictly relies on `AppColorsExtension` and `colorScheme`. Remove hardcoded hex values.
- Use the `write_file` tool to output the generated code directly to disk. Run `flutter format .` via shell command upon completion. Do NOT just print markdown blocks to the terminal.