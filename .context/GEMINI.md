# WaveOne Project Architecture & Constraints

## 1. Core Architecture (STRICT)
- **Inversion of Control (IoC):** The app is a generic shell. Hardware products are modular drivers loaded dynamically.
- **State Management:** `flutter_bloc` (strictly separated from UI).
- **Dependency Injection:** `get_it`.
- **Routing:** `go_router` utilizing a `ShellRoute` to handle responsive navigation layouts.

## 2. Visual Paradigm: The "DAW Hardware" Aesthetic
- The UI MUST mimic physical audio hardware (Ableton, Logic Pro, analog mixing desks).
- **Widgets:** Use Neumorphism (`BoxShadow` arrays, `LinearGradient` borders) to create tactile knobs, recessed sliders, and metallic faceplates. No flat web styling.
- **Feedback:** Use glowing LED effects (high-blur shadows with colors from `Theme.of(context).extension<LedColors>()`) for active states.
- **Layouts:** Screens act as "Racks". Group components into distinct panels with subtle borders. Mobile = Vertical Rack stack. Desktop = Horizontal Mixing Desk.

## 3. Directory Boundaries
- `lib/core/widgets/`: ONLY for shared, global components (e.g., generic knobs, sliders).
- `lib/products/[product_name]/ui/screens/`: Routable Scaffold pages.
- `lib/products/[product_name]/ui/widgets/`: Components strictly unique to a specific product.

## 4. Coding Standards
- Use sound null safety.
- Prefer `StatelessWidget`.
- Never mix BLoC/hardware logic inside widget `build()` methods.