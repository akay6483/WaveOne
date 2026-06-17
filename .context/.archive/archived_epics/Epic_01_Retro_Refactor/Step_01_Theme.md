# Ticket: 01.01 - DAW Theme Injection

## Stage 1: Context Acquisition (MANDATORY)
agy/gemini-cli: Before generating any code or executing writes, you MUST ingest the following guidelines:
- @.context/CLAUDE.md
- @.context/GEMINI.md
- Read current state: @lib/core/theme/app_theme.dart

## Stage 2: Task Execution
**Objective:** Refactor the existing theme to support a professional DAW aesthetic (like Ableton/Logic Pro).
**Target Directory:** `lib/core/theme/`

## Stage 3: Output Constraints
- Modify `app_theme.dart`. Change the color scheme to a dark, metallic hardware palette (deep charcoal chassis, subtle metallic surface colors).
- Define specific styles for `Container` or `Card` widgets that will serve as "Hardware Panels" (give them a subtle 1px border to look like physical rack mounts).
- Create a `ThemeExtension` for glowing "LED" feedback colors (Neon Green, Warning Red, Amber).
- Use the `write_file` tool to output the final `.dart` file.