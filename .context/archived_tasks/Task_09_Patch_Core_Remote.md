# Ticket: 09 - Patch Core Remote Modal (21-Button Grid & Rendering Fix)

## Stage 1: Context Acquisition (MANDATORY)
@google/gemini-cli: Before generating any code, you MUST ingest the architecture, the theme extensions, the new raw component data, the existing widget, and the dashboard shell:
- @GEMINI.md
- @lib/core/theme/app_theme.dart
- @.context/translation_inbox/remote_modal_raw.dart
- @lib/core/widgets/remote_modal.dart
- @lib/products/waveone_v1_wifi/ui/waveone_dashboard.dart

## Stage 2: Task Execution
**Objective:** Update the existing `lib/core/widgets/remote_modal.dart` to incorporate structural fixes. This includes migrating to a full 21-button callback signature, replacing buggy `DecorationImage` implementations with explicit `Image.asset` widgets, handling dynamic label placements, and updating the dashboard shell invocation.
**Target Directories:** `lib/core/widgets/` and `lib/products/waveone_v1_wifi/ui/`

## Stage 3: Output Constraints

**1. Update Component Signature (`lib/core/widgets/remote_modal.dart`)**
- Read the structural changes from `@.context/translation_inbox/remote_modal_raw.dart`.
- Expand the `RemoteModal` constructor in our active file to explicitly include the complete 21-button callback mappings (`onPower`, `onMute`, `onSetup`, `onVolUp`, `onVolDown`, `onPlayPause`, `onPrev`, `onNext`, `onEq`, `onRpt`, `onUsd`, and `onDigit0` through `onDigit9`).
- Retain the `StatefulWidget` wrapper and all existing `// TODO: Refactor remote hardware commands and state to map to WaveOneBloc events.` comments.

**2. Refactor `_RemoteButton` Rendering Logic**
- Completely strip out the `DecorationImage` implementation inside the button builder.
- Replace it with a `Stack` or overlapping `Column` utilizing `Image.asset(_getAssetPath(), width: 80, height: 80, fit: BoxFit.contain)`.
- Ensure all asset paths use the universal `assets/` prefix (e.g., `assets/images/btn_bg.png`).
- **Dynamic Labels:** - If an `icon` is provided, render the icon *over* the image, and place the `Text` label *below* the image.
  - If NO `icon` is provided (e.g., for digits or 'RPT'), render the `Text` label *inside/over* the image itself, with an invisible spacer below to maintain grid uniform height.

**3. Maintain Strict Theming**
- Do NOT revert to hardcoded hex colors from the raw file. 
- Ensure the newly added button labels continue to pull from `Theme.of(context).extension<AppColorsExtension>()!`.
- Use `remoteButtonText`, `remotePowerText`, `remotePlayText`, etc., dynamically based on the button's function.

**4. Patch the Dashboard Shell (`lib/products/waveone_v1_wifi/ui/waveone_dashboard.dart`)**
- Locate the `RemoteModal()` invocation in the `AppBar` actions.
- Update the instantiation to pass empty/mock `() {}` callbacks for all the newly added dependencies (`onRpt`, `onUsd`, `onDigit0`...`onDigit9`).

**5. Execution Rule**
- Use the `write_file` tool to output the generated code directly to the disk for both modified files. 
- Run code formatting (`flutter format .`) upon completion.