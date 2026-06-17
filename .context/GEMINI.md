# WaveOne Project Architecture & Constraints

## 1. Core Architecture (STRICT)
- **Inversion of Control (IoC):** The app is a generic shell. Hardware products are modular drivers loaded dynamically.
- **State Management:** `flutter_bloc` (strictly separated from UI).
- **Dependency Injection:** `get_it`.
- **Routing:** `go_router` utilizing a `ShellRoute` to handle responsive navigation layouts.

## 2. Visual Paradigm: The "DAW Hardware" Aesthetic
- The UI MUST mimic physical audio hardware.
- **Widgets:** Use Neumorphism (`BoxShadow` arrays, `LinearGradient` borders) to create tactile knobs, recessed sliders, and metallic faceplates.
- **Feedback:** Use glowing LED effects via `Theme.of(context).extension<LedColors>()`.

## 3. Directory Boundaries (STRICT COMPONENT ISOLATION)
- `lib/core/widgets/`: **THE UNIVERSAL PARTS BIN.** ALL visual components (knobs, sliders, toggles, custom cards, DSP monitors) live here. There are NO product-specific widgets.
- `lib/products/[product_name]/ui/screens/`: **THE CHASSIS.** These are the only files allowed in the product UI folders. They must be pure layout files (Scaffolds) that import components from `core/widgets/` and arrange them.

## 4. Coding Standards
- Prefer `StatelessWidget`. All state is passed down from the Screen level.
- Never mix BLoC/hardware logic inside widget `build()` methods.
