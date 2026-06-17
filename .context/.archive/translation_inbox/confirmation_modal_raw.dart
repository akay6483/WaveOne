import 'package:flutter/material.dart';
import 'package:waveone_app/core/theme/app_theme.dart'; // Adjust path as necessary

class ConfirmationModal extends StatelessWidget {
  // Note: 'visible' has been stripped. Flutter's Navigator handles visibility natively.
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
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final themeColors = Theme.of(context).colorScheme;

    // Use the passed-in color, or default to the primary theme color
    final finalConfirmColor = confirmButtonColor ?? themeColors.primary;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      // insetPadding handles the React Native "width: 85%" layout constraint
      insetPadding: const EdgeInsets.symmetric(horizontal: 30.0), 
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: colors.modalBackground,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Wrap content tightly
          children: [
            // --- Title ---
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: themeColors.onSurface,
              ),
            ),
            
            const SizedBox(height: 10),
            
            // --- Message ---
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: colors.textMuted,
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
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: themeColors.surfaceContainerHighest),
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 16,
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
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      confirmButtonLabel,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white, // Ensuring high contrast on colored buttons
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