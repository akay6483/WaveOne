import 'package:flutter/material.dart';
import 'package:waveone/core/theme/app_theme.dart';

class RemoteModal extends StatelessWidget {
  final VoidCallback onClose;

  const RemoteModal({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = theme.colorScheme;
    final hardwareTheme = theme.extension<HardwarePanelTheme>()!;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        decoration: hardwareTheme.panelDecoration.copyWith(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        width: 380, // Responsive constraint
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- Header ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Icon(
                      Icons.settings_remote,
                      color: themeColors.onSurface,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Remote",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: themeColors.onSurface,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(Icons.close, color: themeColors.onSurface, size: 22),
                        onPressed: onClose,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // --- Grid Container ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: hardwareTheme.recessedDecoration,
                padding: const EdgeInsets.all(16),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    // TODO: Refactor callbacks to dispatch hardware events via WaveOneBloc
                    _RemoteButton(
                      icon: Icons.power_settings_new,
                      label: "Power",
                      onPress: () {},
                    ),
                    _RemoteButton(
                      icon: Icons.play_arrow,
                      label: "Play",
                      onPress: () {},
                    ),
                    _RemoteButton(
                      icon: Icons.settings,
                      label: "Setup",
                      onPress: () {},
                    ),
                    _RemoteButton(
                      icon: Icons.volume_up,
                      label: "Vol +",
                      onPress: () {},
                    ),
                    _RemoteButton(
                      icon: Icons.volume_down,
                      label: "Vol -",
                      onPress: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Private widget to encapsulate button styling
class _RemoteButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPress;

  const _RemoteButton({
    required this.icon,
    required this.label,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColorsExtension>()!;
    final themeColors = theme.colorScheme;

    return GestureDetector(
      onTap: onPress,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: colors.remoteModalBg,
              shape: BoxShape.circle,
              border: Border.all(color: themeColors.surfaceContainerHighest, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  offset: const Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ),
            child: Icon(icon, color: colors.remoteButtonText, size: 28),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(color: colors.remoteButtonText, fontSize: 11, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
