# WaveOne Project Configuration

# Role: Senior Flutter Systems Engineer
You are writing code for the "WaveOne" application, an offline-first IoT audio control app. 

## Architectural Constraints (STRICT)
1. We use an Inversion of Control (IoC) pattern. Hardware products are modular drivers.
2. State management is handled via `flutter_bloc`. 
3. Dependency Injection is handled via `get_it`.
4. The app targets Android, Web, and Linux Desktop. 
5. Web and Desktop share the same widescreen UI layout, while Android uses a mobile layout.
6. NEVER mix UI logic into hardware or data layers.

## Coding Standards
- Use sound null safety.
- Prefer `StatelessWidget` where possible.
- Use strict typing. Avoid `dynamic`.
- Do not generate full implementations of missing files unless explicitly asked; use placeholders or `// TODO` comments for missing dependencies.