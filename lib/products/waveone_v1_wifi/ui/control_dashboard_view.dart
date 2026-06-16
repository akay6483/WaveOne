import 'package:flutter/material.dart';
import 'package:waveone/core/theme/app_theme.dart';
import 'package:waveone/core/widgets/Knob.dart';
import 'package:waveone/products/waveone_v1_wifi/ui/widgets/mode_selector.dart';

class ControlDashboardView extends StatelessWidget {
  // --- UI State ---
  final String activeMode;
  final bool isModeExpanded;

  final double mainVolAngle;
  final String mainVolText;

  final double subVolAngle;
  final String subVolText;

  // --- Externalized Callbacks ---
  final void Function(double newAngle, int newIndex) onMainVolTurned;
  final void Function(double newAngle, int newIndex) onSubVolTurned;
  final ValueChanged<String> onModeSelected;
  final VoidCallback onToggleModeExpand;

  // --- Modal Triggers ---
  final VoidCallback onOpenAttenuation;
  final VoidCallback onOpenPresets;
  final VoidCallback onOpenRemote;

  const ControlDashboardView({
    super.key,
    required this.activeMode,
    required this.isModeExpanded,
    required this.mainVolAngle,
    required this.mainVolText,
    required this.subVolAngle,
    required this.subVolText,
    required this.onMainVolTurned,
    required this.onSubVolTurned,
    required this.onModeSelected,
    required this.onToggleModeExpand,
    required this.onOpenAttenuation,
    required this.onOpenPresets,
    required this.onOpenRemote,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final themeColors = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.sizeOf(context).width;

    // React Native's relative sizing: Main Knob is 65% width, Sub is 40%
    final double mainKnobSize = screenWidth * 0.65;
    final double subKnobSize = screenWidth * 0.40;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          children: [
            // --- Main Volume Knob Row ---
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Knob(
                  label: "Main Volume",
                  size: mainKnobSize,
                  currentAngle: mainVolAngle,
                  valueText: mainVolText,
                  onKnobTurned: onMainVolTurned,
                  minVal: 0,
                  maxVal: 80,
                  step: 1,
                  dialBaseImage: const AssetImage(
                    'assets/images/dial-base.png',
                  ),
                  indicatorImage: const AssetImage(
                    'assets/images/dial-indicator-red.png',
                  ),
                  isDarkTheme: true, // Controlled via theme internally usually
                  iconColor: themeColors.onSurface,
                  textMutedColor: colors.textMuted,
                ),
              ),
            ),

            // --- Subwoofer Knob Row ---
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Knob(
                  label: "Subwoofer",
                  size: subKnobSize,
                  currentAngle: subVolAngle,
                  valueText: subVolText,
                  onKnobTurned: onSubVolTurned,
                  minVal: -14,
                  maxVal: 0,
                  step: 1,
                  dialBaseImage: const AssetImage(
                    'assets/images/dial-base.png',
                  ),
                  indicatorImage: const AssetImage(
                    'assets/images/knob-indicator.png',
                  ),
                  isDarkTheme: true,
                  iconColor: themeColors.onSurface,
                  textMutedColor: colors.textMuted,
                ),
              ),
            ),

            // --- Mode Selector ---
            ModeSelector(
              currentMode: activeMode,
              isExpanded: isModeExpanded,
              onModeSelected: onModeSelected,
              onToggleExpand: onToggleModeExpand,
            ),

            // --- Utility Switches Section (Wraps precisely like Flexbox) ---
            Container(
              margin: const EdgeInsets.only(top: 20, left: 16, right: 16),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 12, // Horizontal spacing between buttons
                runSpacing: 12, // Vertical spacing if they wrap
                children: [
                  _buildModalButton(
                    "Attenuation",
                    Icons.tune,
                    themeColors,
                    onOpenAttenuation,
                  ),
                  _buildModalButton(
                    "Presets",
                    Icons.save_alt,
                    themeColors,
                    onOpenPresets,
                  ),
                  _buildModalButton(
                    "Remote",
                    Icons.settings_remote,
                    themeColors,
                    onOpenRemote,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Maps directly to the React Native `modalButton` style in index.tsx
  Widget _buildModalButton(
    String label,
    IconData icon,
    ColorScheme themeColors,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: themeColors.surfaceContainerHighest),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Hug content
          children: [
            Icon(icon, size: 20, color: themeColors.onSurface),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: themeColors.onSurface,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
