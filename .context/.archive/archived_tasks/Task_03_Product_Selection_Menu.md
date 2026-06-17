# Ticket: 03 - Scaffold Product Selection Menu and Routing

## Stage 1: Context Acquisition (MANDATORY)
@google/gemini-cli: Before generating any code, you MUST ingest the baseline architecture and read the existing layout/dashboard files to understand the required routing wrapper:
- @GEMINI.md
- @lib/main.dart
- @lib/core/theme/responsive_layout.dart
- @lib/products/waveone_v1_wifi/ui/waveone_dashboard.dart

## Stage 2: Task Execution
**Objective:** Build the initial Product Selection screen that greets the user and wire up basic navigation. The layout must cleanly adapt to Android (mobile), Linux, and Web (widescreen).
**Target Directories:** `lib/core/ui/screens/` and `lib/`

## Stage 3: Output Constraints

**1. Create `lib/core/ui/screens/product_selection_screen.dart`**
- Create the necessary directories if they do not exist.
- Build a pure `StatelessWidget` called `ProductSelectionScreen`.
- UI Layout:
  - A `Scaffold` with an `AppBar` titled "Select Device".
  - The `body` should use a `Center` widget containing a `ConstrainedBox` (maxWidth: 600) to prevent the UI from stretching infinitely on Web/Linux. 
  - Inside the box, use a `ListView` or `Column` containing a large, styled `Card` or `ElevatedButton` representing the "WaveOne V1 (Wi-Fi)".
- Navigation Logic: 
  - On press, use `Navigator.push`. 
  - **CRITICAL:** Do NOT navigate directly to `WaveOneDashboard()`. You MUST wrap the destination in the `ResponsiveLayout` widget (passing the dashboard to both `mobileBody` and `desktopBody` for now).

**2. Update `lib/main.dart`**
- Modify the `home` property of the root `MaterialApp`.
- Strip out the temporary `ResponsiveLayout` boilerplate currently hardcoded in the `home` property.
- Set `home` to point directly to `ProductSelectionScreen()`.
- Ensure all necessary imports are added and unused imports are removed.

**3. Execution Rule**
- Use the `write_file` tool to output the files. Run `flutter format .` via shell command on the workspace after writing. Do NOT just print markdown blocks to the terminal.