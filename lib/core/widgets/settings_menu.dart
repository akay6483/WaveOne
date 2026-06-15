import 'package:flutter/material.dart';
import 'package:waveone/core/theme/app_theme.dart';

class SettingsMenu extends StatelessWidget {
  // Pass the state down from BLoC/Parent
  final ThemeMode currentThemeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  final bool isHapticsEnabled;
  final ValueChanged<bool> onHapticsChanged;

  final bool isAudioEnabled;
  final ValueChanged<bool> onAudioChanged;

  const SettingsMenu({
    super.key,
    required this.currentThemeMode,
    required this.onThemeModeChanged,
    required this.isHapticsEnabled,
    required this.onHapticsChanged,
    required this.isAudioEnabled,
    required this.onAudioChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final themeColors = Theme.of(context).colorScheme;

    return Container(
      color: themeColors.surface,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Display Theme",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: themeColors.onSurface,
            ),
          ),
          const SizedBox(height: 10),

          // --- Theme Toggle ---
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(4),
            child: Row(
              children: [
                _buildThemeTab(
                  ThemeMode.light,
                  Icons.wb_sunny_outlined,
                  "Light",
                  themeColors,
                  colors,
                ),
                _buildThemeTab(
                  ThemeMode.dark,
                  Icons.nightlight_round_outlined,
                  "Dark",
                  themeColors,
                  colors,
                ),
                _buildThemeTab(
                  ThemeMode.system,
                  Icons.settings_suggest_outlined,
                  "Auto",
                  themeColors,
                  colors,
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // --- Preferences Card ---
          Text(
            "Preferences",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: themeColors.onSurface,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                // Haptics Switch
                _buildSwitchRow(
                  icon: Icons.vibration,
                  label: "Haptic Feedback",
                  value: isHapticsEnabled,
                  onChanged: onHapticsChanged,
                  themeColors: themeColors,
                  colors: colors,
                ),
                Divider(height: 1, color: themeColors.surfaceContainerHighest),
                // Audio Switch
                _buildSwitchRow(
                  icon: Icons.volume_up_outlined,
                  label: "Audio Feedback",
                  value: isAudioEnabled,
                  onChanged: onAudioChanged,
                  themeColors: themeColors,
                  colors: colors,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeTab(
    ThemeMode mode,
    IconData icon,
    String label,
    ColorScheme themeColors,
    AppColorsExtension colors,
  ) {
    final isActive = currentThemeMode == mode;
    return Expanded(
      child: GestureDetector(
        onTap: () => onThemeModeChanged(mode),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? themeColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 24,
                color: isActive ? themeColors.onPrimary : colors.inactiveTint,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive ? themeColors.onPrimary : colors.inactiveTint,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchRow({
    required IconData icon,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
    required ColorScheme themeColors,
    required AppColorsExtension colors,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          Icon(icon, size: 22, color: themeColors.onSurface),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 16, color: themeColors.onSurface),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: themeColors.primary,
            inactiveTrackColor: colors.inactiveTint,
            thumbColor: WidgetStateProperty.resolveWith((states) {
              return colors.thumbColor;
            }),
          ),
        ],
      ),
    );
  }
}
