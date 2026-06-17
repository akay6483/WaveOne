# Epic: 01 - DAW Layout Fix & Retro UI Refactor

## 1. Epic Objective
Fix the broken scaffold layouts in the current WaveOne repository and refactor the existing flat widgets to mimic a professional DAW hardware interface (e.g., Ableton, FL Studio). 

## 2. Global Context Acquisition
- @.context/CLAUDE.md
- @.context/GEMINI.md

## 3. Sequential Execution Plan
- [x] **Step 01: DAW Theme Injection** -> Assigned to: Integration Engineer (Ticket: `Step_01_Theme.md`)
      *Goal: Update `lib/core/theme/app_theme.dart` with physical chassis colors and LED feedback gradients.*
- [x] **Step 02: Fix Dashboard Scaffold** -> Assigned to: Integration Engineer (Ticket: `Step_02_Dashboard_Layout.md`)
      *Goal: Repair the broken `waveone_dashboard.dart` layout using `lib/core/ui` responsive wrappers to create a "Hardware Rack" shell.*
- [x] **Step 03: Global Widgets Refactor** -> Assigned to: UI Engineer (Ticket: `Step_03_Core_Widgets.md`)
      *Goal: Refactor existing components in `lib/core/widgets/` to use tactile, DAW-style styling.*
- [x] **Step 04: Product Widgets Refactor** -> Assigned to: UI Engineer (Ticket: `Step_04_Product_Widgets.md`)
      *Goal: Refactor the components in `lib/products/waveone_v1_wifi/ui/widgets/` to match the new hardware aesthetic.*