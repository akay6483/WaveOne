# Ticket: [Ticket_ID] - [Title]

## Stage 1: Context Acquisition (MANDATORY)
@google/gemini-cli: Before generating any code or executing writes, you MUST use the `read_many_files` tool or `@` syntax to ingest the following architectural guidelines:
- @.context/architecture_refs/ioc_rules.md
- @.context/architecture_refs/bloc_state_rules.md

## Stage 2: Task Execution
**Objective:** [Insert granular task, e.g., "Scaffold the UI Bloc for WaveOne V1 WiFi Dashboard"]
**Target Directory:** `lib/products/waveone_v1_wifi/ui/`

## Stage 3: Output Constraints
- Strictly utilize `get_it` for dependency injection as defined in the context files.
- Ensure zero UI logic leaks into the BLoC layer.
- Use the `write_file` tool to output the final `.dart` files directly to the target directory. Do NOT just print markdown blocks to the terminal.