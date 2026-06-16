# Task 11b: Patch UI Integration Compilation Errors

## Objective
Resolve the compilation errors preventing `flutter run` from building the WaveOne application. This requires fixing a Material Icon typo and aligning the constructor signatures between `ControlDashboardView` and `ModeSelector`.

## Requirements

### 1. Fix Invalid Material Icons (`main_navigation_shell.dart`)
- Open `lib/products/waveone_v1_wifi/ui/main_navigation_shell.dart`.
- Locate all instances of `Icons.wifi_outline`.
- Replace them with `Icons.network_wifi` (or `Icons.wifi` if preferred).
- Ensure no other invalid icon names exist in the `BottomNavigationBar` or `NavigationRail` items.

### 2. Align Component Signatures (`control_dashboard_view.dart` & `mode_selector.dart`)
- **Option A (Preferred - Top-Down State):** - Open `lib/products/waveone_v1_wifi/ui/widgets/mode_selector.dart`.
  - Update the `ModeSelector` constructor to explicitly accept the state parameters being passed to it by the dashboard: `final String currentMode;`, `final bool isExpanded;`, `final ValueChanged<String> onModeSelected;`, and `final VoidCallback onToggleExpand;`.
  - Revert `ModeSelector` to a `StatelessWidget` if it is currently a `StatefulWidget`, allowing the parent `waveone_dashboard.dart` to manage the mock state as designed in Task 11.
  - Open `lib/products/waveone_v1_wifi/ui/control_dashboard_view.dart` and ensure that when it invokes `ModeSelector(...)`, it does **not** pass any color parameters (like `cardColor` or `textColor`). `ModeSelector` must rely entirely on `Theme.of(context)` internally.

### 3. Execution Constraints
- Do not alter the overarching `ResponsiveLayout` logic.
- Output the generated code for both modified files and write them directly to the disk.
- Run code formatting (`flutter format .`) upon completion.