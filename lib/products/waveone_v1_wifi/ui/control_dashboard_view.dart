import 'package:flutter/material.dart';
import 'package:waveone/core/theme/app_theme.dart';
import 'package:waveone/core/theme/responsive_layout.dart';
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
    return SafeArea(
      child: ResponsiveLayout(
        mobileBody: _buildMobile(context),
        desktopBody: _buildDesktop(context),
      ),
    );
  }

  Widget _buildMobile(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final themeColors = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.sizeOf(context).width;

    // Relative sizing on mobile
    final double mainKnobSize = screenWidth * 0.60;
    final double subKnobSize = screenWidth * 0.38;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        children: [
          _buildRackPanel(
            context: context,
            title: "Main Volume",
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Knob(
                label: "Main Volume",
                size: mainKnobSize,
                currentAngle: mainVolAngle,
                valueText: mainVolText,
                onKnobTurned: onMainVolTurned,
                minVal: 0,
                maxVal: 80,
                step: 1,
                dialBaseImage: const AssetImage('assets/images/dial-base.png'),
                indicatorImage: const AssetImage('assets/images/dial-indicator-red.png'),
                isDarkTheme: true,
                iconColor: themeColors.onSurface,
                textMutedColor: colors.textMuted,
              ),
            ),
          ),
          const SizedBox(height: 12),
          _buildRackPanel(
            context: context,
            title: "Subwoofer",
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Knob(
                label: "Subwoofer",
                size: subKnobSize,
                currentAngle: subVolAngle,
                valueText: subVolText,
                onKnobTurned: onSubVolTurned,
                minVal: -14,
                maxVal: 0,
                step: 1,
                dialBaseImage: const AssetImage('assets/images/dial-base.png'),
                indicatorImage: const AssetImage('assets/images/knob-indicator.png'),
                isDarkTheme: true,
                iconColor: themeColors.onSurface,
                textMutedColor: colors.textMuted,
              ),
            ),
          ),
          const SizedBox(height: 12),
          ModeSelector(
            currentMode: activeMode,
            isExpanded: isModeExpanded,
            onModeSelected: onModeSelected,
            onToggleExpand: onToggleModeExpand,
          ),
          const SizedBox(height: 12),
          _buildRackPanel(
            context: context,
            title: "Utility Console",
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildModalButton(context, "Attenuation", Icons.tune, themeColors, onOpenAttenuation),
                  _buildModalButton(context, "Presets", Icons.save_alt, themeColors, onOpenPresets),
                  _buildModalButton(context, "Remote", Icons.settings_remote, themeColors, onOpenRemote),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final themeColors = Theme.of(context).colorScheme;

    // Fixed bounded knob sizes on desktop to avoid layout overflows
    const double mainKnobSize = 160.0;
    const double subKnobSize = 110.0;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRackPanel(
            context: context,
            title: "Main Volume",
            width: 240,
            height: 380,
            child: Knob(
              label: "Main Volume",
              size: mainKnobSize,
              currentAngle: mainVolAngle,
              valueText: mainVolText,
              onKnobTurned: onMainVolTurned,
              minVal: 0,
              maxVal: 80,
              step: 1,
              dialBaseImage: const AssetImage('assets/images/dial-base.png'),
              indicatorImage: const AssetImage('assets/images/dial-indicator-red.png'),
              isDarkTheme: true,
              iconColor: themeColors.onSurface,
              textMutedColor: colors.textMuted,
            ),
          ),
          _buildRackPanel(
            context: context,
            title: "Subwoofer",
            width: 200,
            height: 380,
            child: Knob(
              label: "Subwoofer",
              size: subKnobSize,
              currentAngle: subVolAngle,
              valueText: subVolText,
              onKnobTurned: onSubVolTurned,
              minVal: -14,
              maxVal: 0,
              step: 1,
              dialBaseImage: const AssetImage('assets/images/dial-base.png'),
              indicatorImage: const AssetImage('assets/images/knob-indicator.png'),
              isDarkTheme: true,
              iconColor: themeColors.onSurface,
              textMutedColor: colors.textMuted,
            ),
          ),
          Container(
            width: 320,
            height: 380,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: SingleChildScrollView(
              child: ModeSelector(
                currentMode: activeMode,
                isExpanded: isModeExpanded,
                onModeSelected: onModeSelected,
                onToggleExpand: onToggleModeExpand,
              ),
            ),
          ),
          _buildRackPanel(
            context: context,
            title: "Utility Console",
            width: 220,
            height: 380,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildModalButton(context, "Attenuation", Icons.tune, themeColors, onOpenAttenuation),
                  const SizedBox(height: 16),
                  _buildModalButton(context, "Presets", Icons.save_alt, themeColors, onOpenPresets),
                  const SizedBox(height: 16),
                  _buildModalButton(context, "Remote", Icons.settings_remote, themeColors, onOpenRemote),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRackPanel({
    required BuildContext context,
    required String title,
    required Widget child,
    double? width,
    double? height,
  }) {
    final theme = Theme.of(context);
    final hardwareTheme = theme.extension<HardwarePanelTheme>()!;

    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: hardwareTheme.panelDecoration,
      child: Stack(
        children: [
          // Corner screws (tactile detail)
          Positioned(top: 6, left: 6, child: _buildScrew(theme)),
          Positioned(top: 6, right: 6, child: _buildScrew(theme)),
          Positioned(bottom: 6, left: 6, child: _buildScrew(theme)),
          Positioned(bottom: 6, right: 6, child: _buildScrew(theme)),

          // Panel content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header Label Plate
                Center(
                  child: Container(
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
                      title.toUpperCase(),
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(child: Center(child: child)),
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

  Widget _buildModalButton(
    BuildContext context,
    String label,
    IconData icon,
    ColorScheme themeColors,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          border: Border.all(color: themeColors.surfaceContainerHighest),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: themeColors.onSurface),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: themeColors.onSurface,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
