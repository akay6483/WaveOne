import 'package:flutter/material.dart';
import 'package:waveone/core/theme/app_theme.dart';

class RemoteModal extends StatelessWidget {
  final VoidCallback onClose;

  const RemoteModal({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final themeColors = Theme.of(context).colorScheme;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          color: colors.modalBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: themeColors.surfaceContainerHighest),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              offset: const Offset(0, -4),
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
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: themeColors.onSurface,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(Icons.close, color: themeColors.onSurface),
                        onPressed: onClose,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- Grid Container ---
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
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
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    return GestureDetector(
      onTap: onPress,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: colors.remoteModalBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: colors.remoteButtonText, size: 32),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(color: colors.remoteButtonText, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
