import 'package:flutter/material.dart';
import 'package:waveone/core/theme/app_theme.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final themeColors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: themeColors.surface,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 30),
            child: Center(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      isDark
                          ? 'assets/images/darkAO.png'
                          : 'assets/images/lightAO.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "AcousticOne",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: themeColors.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Info Card
          Text(
            "App Information",
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
                _buildRow(
                  "App Version",
                  "1.0.0 (Build 1)",
                  themeColors,
                  colors,
                ),
                Divider(height: 1, color: themeColors.surfaceContainerHighest),
                _buildRow("Developer", "AcousticOne Team", themeColors, colors),
              ],
            ),
          ),

          const Spacer(),

          // Footer
          Center(
            child: Text(
              "© 2026 AcousticOne. All rights reserved.",
              style: TextStyle(fontSize: 12, color: colors.textMuted),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(
    String label,
    String value,
    ColorScheme themeColors,
    AppColorsExtension colors,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: themeColors.onSurface,
            ),
          ),
          Text(value, style: TextStyle(fontSize: 16, color: colors.textMuted)),
        ],
      ),
    );
  }
}
