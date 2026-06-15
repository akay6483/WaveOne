# Ticket: 10 - Integrate Global Utility Drawer & Utility Pages

## Stage 1: Context Acquisition (MANDATORY)
@google/gemini-cli: Before generating any code, you MUST ingest the baseline architecture, the global theme, the raw translated utility components, and the current dashboard shell:
- @GEMINI.md
- @lib/core/theme/app_theme.dart
- @.context/translation_inbox/info_page_dart_raw.dart
- @.context/translation_inbox/privacy_policy_page_raw.dart
- @.context/translation_inbox/settings_menu_raw.dart
- @.context/translation_inbox/support_page_raw.dart
- @lib/products/waveone_v1_wifi/ui/waveone_dashboard.dart

## Stage 2: Task Execution
**Objective:** Migrate the four raw utility pages into the core widget library. Build a responsive, global settings navigation system (an `endDrawer` for mobile, and a `NavigationRail` trailing action for desktop) to host these views.
**Target Directories:** `lib/core/widgets/` and `lib/products/waveone_v1_wifi/ui/`

## Stage 3: Output Constraints

**1. File Placement & Renaming**
- Read the four raw files from the translation inbox.
- Create their finalized versions strictly in `lib/core/widgets/`:
  - `info_page.dart`
  - `privacy_policy_page.dart`
  - `settings_menu.dart`
  - `support_page.dart`
- **CRITICAL:** Explicitly ignore any references to `preset_modal`. Do not generate or modify it.

**2. Scaffold `lib/core/widgets/global_settings_drawer.dart`**
- Create this new file as a `StatelessWidget` returning a `Drawer`.
- The Drawer must contain a `ListView` with a header ("WaveOne Settings") and `ListTile` items for: "Settings", "Support", "Privacy Policy", and "About / Info".
- Tapping a tile must use `Navigator.push` to navigate to a new basic `Scaffold` hosting the respective component. These host scaffolds must have standard AppBars with back buttons.
- Apply `Theme.of(context).extension<AppColorsExtension>()!` for text colors and icons to maintain strict theme compliance.

**3. Wire Up Mock State & Deferrals (In the Host Scaffolds)**
- **Settings Menu:** When pushing to the Settings host Scaffold, wrap `SettingsMenu` in a temporary `StatefulWidget` to hold mock state (`currentThemeMode`, `isHapticsEnabled`, `isAudioEnabled`). Provide `setState` callbacks to update these. Add: `// TODO: Refactor settings state injection to use WaveOneBloc or SettingsBloc.`
- **Support Page:** Pass mock empty `() {}` callbacks for `onContactSupport` and `onReportIssue`. Add: `// TODO: Refactor support actions to trigger native URL launcher events via Bloc.`

**4. Integrate with Dashboard Shell (`waveone_dashboard.dart`)**
- **Mobile Layout:** Assign `endDrawer: const GlobalSettingsDrawer()` to the mobile `Scaffold`. Ensure the `AppBar` has no conflicting trailing actions so the hamburger menu auto-generates.
- **Desktop Layout:** Locate the `NavigationRail`. Add a `trailing` widget at the bottom of the rail containing an `IconButton` (`Icons.menu` or `Icons.settings`). Wrap it to open the drawer/side-panel appropriately.

**5. Execution Rule**
- Ensure NO hardcoded hex colors exist in the migrated utility pages. Rely purely on `Theme.of(context).colorScheme` and `AppColorsExtension`.
- Use the `write_file` tool to output the generated code directly to disk. Run `flutter format .` via shell command upon completion. Do NOT just print markdown blocks to the terminal.