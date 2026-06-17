# Task 14: Scaffold V1 WiFi Control Dashboard

## Objective
Assemble the product-specific control dashboard using the previously translated core widgets (Knob, Mode Selector).

## Step 1: Update the Dashboard Scaffold
Open `lib/products/waveone_v1_wifi/ui/waveone_dashboard.dart`.
- Return a `Scaffold`.
- **AppBar:** - Leading: A back arrow (`IconButton` with `Icons.arrow_back`) to return to the Device Screen.
  - Title: Centered text "WaveOne V1".
  - Trailing Action: A Power button (`IconButton` with `Icons.power_settings_new`). Set the icon color to a bright warning Red.
  - Remove any existing BottomNavigationBar or side rails (we are simplifying the architecture).

## Step 2: Scaffold the Body Layout
- The `body` should be a vertically scrolling `SingleChildScrollView` containing a `Column`.
- **Top Section (Main Volume):** Center the previously translated `Knob` widget. Make it take up roughly 50% of the screen width.
- **Middle Section (Status):** Below the knob, add a `Text` widget displaying "Current Input: --" with a muted text color.
- **Bottom Section (Mode Selectors):** Below the status text, arrange the previously translated `ModeSelector` buttons. Use a `Wrap` or a constrained `Row` to lay out the 5 buttons (AUX 1, AUX 2, AUX 3, USB/BT, 5.1 Analogue) horizontally, allowing them to wrap to the next line if necessary to prevent overflow.

## Step 3: State & Execution
- Keep the `// TODO: Refactor to BlocBuilder` comments intact for the active mode state and knob angles.
- Write the generated code to the disk.
- Run `flutter format .`.