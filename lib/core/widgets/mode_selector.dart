import 'package:flutter/material.dart';
import 'package:waveone/core/theme/app_theme.dart';

// --- Data Structure ---
class ModeData {
  final String label;
  final IconData icon;

  const ModeData({required this.label, required this.icon});
}

class ModeSelector extends StatelessWidget {
  final String currentMode;
  final bool isExpanded;
  final ValueChanged<String> onModeSelected;
  final VoidCallback onToggleExpand;

  const ModeSelector({
    super.key,
    required this.currentMode,
    required this.isExpanded,
    required this.onModeSelected,
    required this.onToggleExpand,
  });

  // --- Static Configuration ---
  static const List<ModeData> modesData = [
    ModeData(label: 'AUX1', icon: Icons.cable),
    ModeData(label: 'AUX2', icon: Icons.settings_input_component),
    ModeData(label: 'AUX3', icon: Icons.settings_input_hdmi),
    ModeData(label: 'USB/BT', icon: Icons.usb),
    ModeData(label: '5.1 Analogue', icon: Icons.surround_sound),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = theme.colorScheme;
    final colors = theme.extension<AppColorsExtension>()!;
    final ledColors = theme.extension<LedColors>()!;
    final hardwareTheme = theme.extension<HardwarePanelTheme>()!;

    final Color textColor = themeColors.onSurface;
    final Color primaryColor = themeColors.primary;
    final Color inactiveColor = colors.inactiveTint;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: hardwareTheme.panelDecoration,
      child: Stack(
        children: [
          // Corner screws (tactile detail)
          Positioned(top: 6, left: 6, child: _buildScrew(theme)),
          Positioned(top: 6, right: 6, child: _buildScrew(theme)),
          Positioned(bottom: 6, left: 6, child: _buildScrew(theme)),
          Positioned(bottom: 6, right: 6, child: _buildScrew(theme)),

          // Main Layout
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // --- Header Section ---
                GestureDetector(
                  onTap: onToggleExpand,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Header Label Plate
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: theme.brightness == Brightness.dark
                                ? const Color(0xFF131416)
                                : const Color(0xFFCBD5E1),
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              color: theme.brightness == Brightness.dark
                                  ? const Color(0xFF25282F)
                                  : const Color(0xFF94A3B8),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            "MODE ROUTER",
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              color: textColor,
                            ),
                          ),
                        ),
                        Icon(
                          isExpanded ? Icons.expand_less : Icons.expand_more,
                          size: 20,
                          color: textColor,
                        ),
                      ],
                    ),
                  ),
                ),

                // --- Collapsible Content Section ---
                if (isExpanded) ...[
                  const SizedBox(height: 12),
                  Container(
                    decoration: hardwareTheme.recessedDecoration,
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: modesData.map((modeItem) {
                          final bool isSelected = modeItem.label == currentMode;

                          return GestureDetector(
                            onTap: () => onModeSelected(modeItem.label),
                            behavior: HitTestBehavior.opaque,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // LED Indicator above icon
                                  Container(
                                    width: 6,
                                    height: 6,
                                    margin: const EdgeInsets.only(bottom: 8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isSelected ? ledColors.green : ledColors.green.withValues(alpha: 0.2),
                                      boxShadow: isSelected ? ledColors.greenGlow(blur: 6, spread: 1) : null,
                                      border: Border.all(
                                        color: isSelected ? Colors.white : Colors.black54,
                                        width: 0.5,
                                      ),
                                    ),
                                  ),
                                  // Icon Container
                                  SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: Center(
                                      child: Icon(
                                        modeItem.icon,
                                        size: 20,
                                        color: isSelected ? primaryColor : inactiveColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  // Label Text
                                  Text(
                                    modeItem.label,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                      color: isSelected ? primaryColor : textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrew(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      width: 5,
      height: 5,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: isDark
              ? [const Color(0xFF717684), const Color(0xFF2C2E33)]
              : [const Color(0xFFCBD5E1), const Color(0xFF475569)],
        ),
        border: Border.all(
          color: isDark ? const Color(0xFF1E2024) : const Color(0xFF64748B),
          width: 0.5,
        ),
      ),
    );
  }
}
