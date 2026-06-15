# Ticket: 05 - Scaffold Responsive Dashboard Shell & Apply Theme

## Stage 1: Context Acquisition (MANDATORY)
@google/gemini-cli: Before generating any code, you MUST ingest the baseline architecture and read the necessary theme and layout files:
- @GEMINI.md
- @lib/main.dart
- @lib/core/theme/app_theme.dart
- @lib/core/theme/responsive_layout.dart
- @lib/core/widgets/knob.dart
- @lib/core/widgets/attenuation_modal.dart
- @lib/products/waveone_v1_wifi/ui/waveone_dashboard.dart

## Stage 2: Task Execution
**Objective:** Refactor the temporary WaveOne Dashboard into a fully responsive navigation shell. The shell must consume `AppTheme` and `AppColorsExtension`, and serve as the host for our translated UI components.
**Target Directories:** `lib/` and `lib/products/waveone_v1_wifi/ui/`

## Stage 3: Output Constraints

**1. Component Integrity (STRICT READ-ONLY)**
- Do NOT alter `lib/core/widgets/knob.dart` or `lib/core/widgets/attenuation_modal.dart`. Treat them as immutable context.

**2. Update `lib/main.dart`**
- Ensure the root `MaterialApp` is utilizing the global theme.
- Set `theme: AppTheme.light`.
- Set `darkTheme: AppTheme.dark`.
- Set `themeMode: ThemeMode.system`.

**3. Refactor `lib/products/waveone_v1_wifi/ui/waveone_dashboard.dart`**
- Convert the dashboard into a `StatefulWidget` to manage a local `int _selectedIndex = 0;` variable.
- **State Management Deferral:** Add this exact comment above the state class: `// TODO: Refactor _selectedIndex to BlocBuilder when navigation state is moved to WaveOneBloc.`

**4. Implement the Responsive Shell**
- Utilize the `ResponsiveLayout` wrapper inside the `build` method.
- **Mobile Layout (`mobileBody`):** Return a `Scaffold`. The `body` must display the view corresponding to `_selectedIndex`. Use a `BottomNavigationBar` to switch between views ("Device Control", "Equalizer", "Settings").
- **Desktop/Web Layout (`desktopBody`):** Return a `Scaffold`. The `body` must be a `Row`. The left side of the `Row` must contain a `NavigationRail` handling the routing. The right side of the `Row` must be an `Expanded` widget displaying the selected view.

**5. Theme Integration for Hosted Components**
- In the primary "Device Control" view, instantiate the `Knob` and `AttenuationModal` components.
- Do NOT use hardcoded hex colors anywhere in this file. 
- Fetch custom AcousticOne colors (for backgrounds, dividers, etc.) strictly using: `Theme.of(context).extension<AppColorsExtension>()!`.

**6. Execution Rule**
- Use the `write_file` tool to overwrite `main.dart` and `waveone_dashboard.dart` directly. Run `flutter format .` via shell command on the workspace after writing. Do NOT just print markdown blocks to the terminal.