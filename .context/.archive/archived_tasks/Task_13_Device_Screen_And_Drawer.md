# Task 13: Scaffold "My Devices" Screen and Global Drawer

## Objective
Build the root device selection screen and its attached hamburger menu based on strict visual constraints.

## Step 1: Create the Global Drawer
Create `lib/core/widgets/global_drawer.dart`.
- Return a `Drawer` widget.
- **Header:** A `Column` containing the App Logo (`Image.asset`), the title "WaveOne", and the text "Version 1.0.0". Add a subtle divider below it.
- **Menu Items:** Use `ListTile` for the following items. Use `Theme.of(context).colorScheme.primary` for the leading icons.
  1. "Device Info" (Icon: `Icons.info_outline`)
  2. "Global Settings" (Icon: `Icons.settings`)
  3. "Support" (Icon: `Icons.help_outline`)
  4. "Privacy Policy" (Icon: `Icons.shield_outlined`)
- Add `// TODO: Wire up navigation routing` to the `onTap` events.

## Step 2: Create the Device Selection Screen
Create `lib/products/waveone_v1_wifi/ui/device_selection_screen.dart`.
- Return a `Scaffold`.
- **AppBar:** Title text "My Devices". No leading icon. Ensure the `endDrawer` automatically populates the hamburger menu icon on the right.
- **Drawer:** Set `endDrawer: const GlobalDrawer()`.
- **Floating Action Button:** Add a `FloatingActionButton` at the bottom right with a simple `+` icon (`Icons.add`).

## Step 3: Scaffold the Device List (Body)
- The body must be a padded `ListView.separated`.
- Mock two device cards using standard `Container` or `Card` widgets with subtle borders:
  - **Card 1 (Connected):** Image on the left, Title "WaveOne V1", Subtitle "Connected". Trailing icon: A small circle (`Icons.circle`) colored Neon Green.
  - **Card 2 (Disconnected):** Image on the left, Title "PV Acoustics 2.1", Subtitle "Disconnected". Trailing icon: A small circle colored Grey.
- Ensure all styling uses `Theme.of(context).colorScheme` (no hardcoded hex colors).

## Step 4: Execution
- Output the generated code to the specified files.
- Run `flutter format .`.