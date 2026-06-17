# Ticket: 07 - Integrate Preset & Confirmation Modals

## Stage 1: Context Acquisition (MANDATORY)
@google/gemini-cli: Before generating any code, you MUST ingest the baseline architecture, the global theme, the raw translated components, and the current dashboard shell:
- @GEMINI.md
- @lib/core/theme/app_theme.dart
- @.context/translation_inbox/preset_modal_raw.dart
- @.context/translation_inbox/confirmation_modal_raw.dart
- @lib/products/waveone_v1_wifi/ui/waveone_dashboard.dart

## Stage 2: Task Execution
**Objective:** Migrate the raw preset and confirmation modals into the shared core widgets directory. Ensure the preset modal correctly invokes the confirmation modal natively. Apply the global `AppTheme` strictly and implement mock state with BLoC deferral comments, then wire the entry point into the V1 WiFi dashboard.
**Target Directories:** `lib/core/widgets/` and `lib/products/waveone_v1_wifi/ui/`

## Stage 3: Output Constraints

**1. Create `lib/core/widgets/confirmation_modal.dart`**
- Read from `@.context/translation_inbox/confirmation_modal_raw.dart`.
- Ensure it acts as a native Flutter `Dialog` (strip React Native `visible` booleans if present).
- Replace hardcoded colors using strict theming (e.g., `Theme.of(context).extension<AppColorsExtension>()!.modalBackground`).
- Style action buttons using `Theme.of(context).colorScheme.primary` (for confirm) and `Theme.of(context).colorScheme.error` (for destructive actions).

**2. Create `lib/core/widgets/preset_modal.dart`**
- Read from `@.context/translation_inbox/preset_modal_raw.dart`.
- Import `confirmation_modal.dart`.
- Convert `PresetModal` to a `StatefulWidget` temporarily to manage a mock list of preset names and track the active preset using `setState`.
- **State Management Deferral:** Add `// TODO: Refactor preset list state and active preset to be injected via BlocBuilder.`
- **Wiring the Dependency:** Locate the actions for saving, overwriting, or deleting a preset. Wrap these to invoke the confirmation dialog using `showDialog(context: context, builder: (context) => ConfirmationModal(...))`.
- Pass appropriate mock strings to the confirmation modal (e.g., title: "Overwrite Preset?", message: "Are you sure you want to overwrite this saved EQ curve?").
- **State Management Deferral:** Add `// TODO: Refactor preset save/delete confirmation logic to trigger WaveOneBloc events.` where the confirmation returns successfully.
- Apply strict `AppColorsExtension` theming just like the confirmation modal.

**3. Triggering the Modal (Dashboard Shell)**
- In `lib/products/waveone_v1_wifi/ui/waveone_dashboard.dart`, import `package:waveone/core/widgets/preset_modal.dart` (adjust package name as needed).
- Locate the "Equalizer" view or main control view in the responsive shell.
- Add an action button (e.g., an `IconButton` with `Icons.save` or `Icons.queue_music`) to serve as the Preset menu trigger.
- Use `showModalBottomSheet(context: context, builder: (context) => const PresetModal())` in the `onPressed` callback.

**4. Execution Rule**
- Use the `write_file` tool to output the generated code directly to the designated files. Run `flutter format .` via shell command upon completion. Do NOT just print markdown blocks to the terminal.