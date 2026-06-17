# Ticket: 01.03 - Global Widgets DAW Refactor

## Stage 1: Context Acquisition (MANDATORY)
agy/gemini-cli: Before generating any code or executing writes, you MUST ingest the following guidelines:
- @.context/CLAUDE.md
- @.context/GEMINI.md
- Read the theme: @lib/core/theme/app_theme.dart
- Read all files in: @lib/core/widgets/

## Stage 2: Task Execution
**Objective:** Refactor all existing widgets in `lib/core/widgets/` to implement the DAW hardware aesthetic.
**Target Directory:** `lib/core/widgets/`

## Stage 3: Output Constraints
- Do NOT alter the constructors, parameters, or gesture logic of these widgets.
- Apply `BoxDecoration`, `LinearGradient`, and `BoxShadow` (neumorphism) to make flat sliders look like recessed DAW faders, and flat circles look like tactile metallic knobs.
- Replace any hardcoded colors with calls to `Theme.of(context).colorScheme` or our new LED extension.
- Use the `write_file` tool to output the updated `.dart` files directly to the target directory.