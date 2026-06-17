# Ticket: 01.04 - Product-Specific Widgets Refactor

## Stage 1: Context Acquisition (MANDATORY)
agy/gemini-cli: Before generating any code or executing writes, you MUST ingest the following guidelines:
- @.context/CLAUDE.md
- @.context/GEMINI.md
- Read the theme: @lib/core/theme/app_theme.dart
- Read all files in: @lib/products/waveone_v1_wifi/ui/widgets/

## Stage 2: Task Execution
**Objective:** Refactor the V1 WiFi-specific widgets to match the physical hardware styling applied to the core widgets.
**Target Directory:** `lib/products/waveone_v1_wifi/ui/widgets/`

## Stage 3: Output Constraints
- Do NOT alter any existing layout boundaries that would break the dashboard scaffold.
- For items like DSP monitors or specialized toggles, use inset shadows to mimic LED screens embedded in a metal chassis.
- Use the `write_file` tool to output the updated `.dart` files directly to the target directory.