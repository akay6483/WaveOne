import 'package:flutter/material.dart';
import 'package:waveone/core/theme/app_theme.dart';

// --- Data Structure ---
class ModeData {
  final String label;
  final IconData icon;

  const ModeData({required this.label, required this.icon});
}

class ModeSelector extends StatefulWidget {
  const ModeSelector({super.key});

  @override
  State<ModeSelector> createState() => _ModeSelectorState();
}

class _ModeSelectorState extends State<ModeSelector> {
  // TODO: Refactor activeMode to be injected via BlocBuilder
  String _activeMode = 'AUX1';
  bool _isExpanded = false;

  // --- Static Configuration ---
  // Mapped from Expo vector icons to standard Flutter Material Icons
  static const List<ModeData> modesData = [
    ModeData(label: 'AUX1', icon: Icons.cable),
    ModeData(label: 'AUX2', icon: Icons.settings_input_component),
    ModeData(label: 'AUX3', icon: Icons.settings_input_hdmi),
    ModeData(label: 'USB/BT', icon: Icons.usb),
    ModeData(label: '5.1 Analogue', icon: Icons.surround_sound),
  ];

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _selectMode(String mode) {
    setState(() {
      _activeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColorsExtension>()!;

    final Color cardColor = colors.modalBackground;
    final Color borderColor = theme.colorScheme.surfaceContainerHighest;
    final Color textColor = theme.colorScheme.onSurface;
    final Color primaryColor = theme.colorScheme.primary;
    final Color inactiveColor = colors.textMuted;

    return Container(
      margin: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // --- Header Section ---
          GestureDetector(
            onTap: _toggleExpand,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mode',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    size: 24,
                    color: textColor,
                  ),
                ],
              ),
            ),
          ),

          // --- Collapsible Content Section ---
          if (_isExpanded)
            Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: borderColor, width: 1)),
              ),
              padding: const EdgeInsets.only(bottom: 10),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: modesData.map((modeItem) {
                    final bool isSelected = modeItem.label == _activeMode;

                    return GestureDetector(
                      onTap: () => _selectMode(modeItem.label),
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Icon Container
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: Center(
                                child: Icon(
                                  modeItem.icon,
                                  size: 20,
                                  color: isSelected
                                      ? primaryColor
                                      : inactiveColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            // Label Text
                            Text(
                              modeItem.label,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
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
      ),
    );
  }
}
