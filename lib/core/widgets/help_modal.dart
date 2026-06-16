import 'package:flutter/material.dart';
import 'package:waveone/core/theme/app_theme.dart';

class HelpModal extends StatelessWidget {
  final VoidCallback? onClose;

  const HelpModal({super.key, this.onClose});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final themeColors = Theme.of(context).colorScheme;

    // Use this widget inside a showModalBottomSheet
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.85,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.modalBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: themeColors.surfaceContainerHighest),
              ),
            ),
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.help_outline, color: themeColors.onSurface),
                Text(
                  "Connection Help",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: themeColors.onSurface,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: themeColors.onSurface),
                  onPressed: onClose ?? () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),

          // Body
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStep(
                    "1. Ensure your device is powered on.",
                    themeColors,
                  ),
                  _buildStep(
                    "2. For Wi-Fi: Connect your phone to the device's hotspot or ensure both are on the same network.",
                    themeColors,
                  ),
                  _buildStep(
                    "3. If the device does not appear, swipe down to refresh the list.",
                    themeColors,
                  ),
                  _buildStep(
                    "Note: The app uses mDNS to discover devices dynamically over your local network.",
                    themeColors,
                  ),
                  _buildStep(
                    "4. If connection fails, check your router settings or ensure the device and phone are on the same subnet.",
                    themeColors,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(String text, ColorScheme themeColors) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          height: 1.4,
          color: themeColors.onSurface,
        ),
      ),
    );
  }
}
