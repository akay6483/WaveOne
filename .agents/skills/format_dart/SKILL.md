---
name: format_dart
description: Formats a specific Dart file to meet project linting standards.
parameters:
  target_file:
    type: string
    description: The relative path to the dart file to format
---

```bash
dart format "$target_file"