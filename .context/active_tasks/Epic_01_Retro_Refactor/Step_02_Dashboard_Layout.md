# Ticket: 01.02 - Fix Dashboard Scaffold & Rack Layout

## Stage 1: Context Acquisition (MANDATORY)
agy/gemini-cli: Before generating any code or executing writes, you MUST ingest the following guidelines:
- @.context/CLAUDE.md
- @.context/GEMINI.md
- Read current layout logic: @lib/core/ui/layouts/responsive_layout.dart
- Read current broken state: @lib/products/waveone_v1_wifi/ui/waveone_dashboard.dart

## Stage 2: Task Execution
**Objective:** Fix the broken scaffold in `waveone_dashboard.dart` and organize the layout into a DAW "Hardware Rack".
**Target Directory:** `lib/products/waveone_v1_wifi/ui/`

## Stage 3: Output Constraints
- Repair the scaffold logic. Ensure it correctly utilizes `ResponsiveLayout`.
- **Mobile:** The layout should be a scrollable column of hardware panels (containers with the new theme).
- **Desktop:** The layout should utilize a horizontal mixing desk paradigm (e.g., Row or Wrap).
- Ensure existing widgets from `lib/products/waveone_v1_wifi/ui/widgets/` are safely imported and placed within these new panel containers.
- Fix all overflow errors.
- Use the `write_file` tool to output the final `.dart` file.