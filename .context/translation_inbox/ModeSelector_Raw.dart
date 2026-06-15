import 'package:flutter/material.dart';

// --- Data Structure ---
class ModeData {
  final String label;
  final IconData icon;

  const ModeData({
    required this.label,
    required this.icon,
  });
}

class ModeSelector extends StatelessWidget {
  // --- UI & State Properties ---
  final String currentMode;
  final bool isExpanded;
  
  // --- Styling Properties ---
  final Color cardColor;
  final Color borderColor;
  final Color textColor;
  final Color primaryColor;
  final Color inactiveColor;

  // --- Callbacks ---
  final ValueChanged<String> onModeSelected;
  final VoidCallback onToggleExpand;

  // --- Static Configuration ---
  // Mapped from Expo vector icons to standard Flutter Material Icons
  static const List<ModeData> modesData = [
    ModeData(label: 'AUX1', icon: Icons.cable), // Mapped from audio-input-stereo-minijack
    ModeData(label: 'AUX2', icon: Icons.settings_input_component), // Mapped from audio-input-rca
    ModeData(label: 'AUX3', icon: Icons.settings_input_hdmi), // Mapped from settings-input-component
    ModeData(label: 'USB/BT', icon: Icons.usb), // Mapped from usb
    ModeData(label: '5.1 Analogue', icon: Icons.surround_sound), // Mapped from surround-sound-5-1
  ];

  const ModeSelector({
    super.key,
    required this.currentMode,
    required this.isExpanded,
    required this.cardColor,
    required this.borderColor,
    required this.textColor,
    required this.primaryColor,
    required this.inactiveColor,
    required this.onModeSelected,
    required this.onToggleExpand,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 16, right: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1),
      ),
      // Using clipBehavior to mirror React Native's overflow: "hidden"
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // --- Header Section ---
          GestureDetector(
            onTap: onToggleExpand,
            behavior: HitTestBehavior.opaque, // Ensures the entire row is clickable
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
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    size: 24,
                    color: textColor,
                  ),
                ],
              ),
            ),
          ),

          // --- Collapsible Content Section ---
          if (isExpanded)
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: borderColor, width: 1),
                ),
              ),
              padding: const EdgeInsets.only(bottom: 10),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: modesData.map((modeItem) {
                    final bool isSelected = modeItem.label == currentMode;

                    return GestureDetector(
                      onTap: () => onModeSelected(modeItem.label),
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
                                  color: isSelected ? primaryColor : inactiveColor,
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