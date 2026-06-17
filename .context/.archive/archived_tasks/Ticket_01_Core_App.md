# Ticket: 01 - Scaffold Core Application and Responsive Layout

## Stage 1: Context Acquisition (MANDATORY)
@google/gemini-cli: Before generating any code or executing writes, you MUST ingest the baseline architectural constraints defined in the root configuration file:
- @GEMINI.md

## Stage 2: Task Execution
**Objective:** Generate the foundational Flutter code to bootstrap the app for Android, Web, and Linux Desktop, including a responsive layout wrapper and the dependency injection locator.
**Target Directories:** `lib/core/theme/`, `lib/core/locator/`, and `lib/`

## Stage 3: Output Constraints

**1. Create `lib/core/theme/responsive_layout.dart`**
- Write a `ResponsiveLayout` stateless widget that takes two child widgets: `mobileBody` and `desktopBody`.
- Use `LayoutBuilder`. If the `maxWidth` is less than 800, return `mobileBody`. Otherwise, return `desktopBody` (shared by Web and Linux).

**2. Create `lib/core/locator/locator_setup.dart`**
- Create a void function `setupLocator()`.
- Inside, instantiate the `get_it` instance.
- Leave `// TODO: Register DriverRegistry` and `// TODO: Register DriverSession` comments inside the function. Do not attempt to write or import these classes yet.

**3. Populate `lib/main.dart`**
- Write the standard `void main() async` entry point.
- Ensure `WidgetsFlutterBinding.ensureInitialized()` is called (required for Linux/Android native bindings).
- Call `setupLocator()`.
- Create the root `WaveOneApp` stateless widget using `MaterialApp`.
- Set the `home`
 property to use the `ResponsiveLayout` widget, passing in dummy `Scaffold` widgets for mobile and desktop (e.g., "WaveOne Mobile" and "WaveOne Desktop/Web").

**Execution Rule:** Use the `write_file` tool to output the final `.dart` files directly to their respective directories. Do NOT just print markdown blocks to the terminal.