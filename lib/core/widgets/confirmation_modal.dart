import 'package:flutter/material.dart';
import 'package:waveone/core/theme/app_theme.dart';

class ConfirmationModal extends StatelessWidget {
  final String title;
  final String message;
  final String confirmButtonLabel;
  final Color? confirmButtonColor;

  // Callbacks
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const ConfirmationModal({
    super.key,
    required this.title,
    required this.message,
    required this.confirmButtonLabel,
    this.confirmButtonColor,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    // Fetch theme colors
    final theme = Theme.of(context);
    final colors = theme.extension<AppColorsExtension>()!;
    final themeColors = theme.colorScheme;
    final hardwareTheme = theme.extension<HardwarePanelTheme>()!;

    // Use the passed-in color, or default to the primary theme color
    final finalConfirmColor = confirmButtonColor ?? themeColors.primary;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        padding: const EdgeInsets.all(22.0),
        decoration: hardwareTheme.panelDecoration.copyWith(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Wrap content tightly
          children: [
            // --- Title ---
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                color: themeColors.onSurface,
              ),
            ),

            const SizedBox(height: 12),

            // --- Message ---
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: colors.textMuted,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 24),

            // --- Button Row ---
            Row(
              children: [
                // Cancel Button
                Expanded(
                  child: TextButton(
                    onPressed: onCancel,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: BorderSide(
                          color: themeColors.surfaceContainerHighest,
                        ),
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: themeColors.onSurface,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Confirm Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: onConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: finalConfirmColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      confirmButtonLabel,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
