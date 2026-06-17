import 'package:flutter/material.dart';
import 'package:waveone_app/core/theme/app_theme.dart'; // Adjust import based on your project structure

/// Enum to map to the image assets used in RemoteModal.tsx
enum RemoteButtonType {
  defaultBtn,
  red,
  blue,
  purple,
}

class RemoteModal extends StatelessWidget {
  final bool visible;
  final VoidCallback onClose;

  // --- Externalized Callbacks (Complete 21-Button Mapping) ---
  final VoidCallback onPower;
  final VoidCallback onMute;
  final VoidCallback onSetup;
  final VoidCallback onVolUp;
  final VoidCallback onVolDown;
  final VoidCallback onPlayPause;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final VoidCallback onEq;
  final VoidCallback onRpt;
  final VoidCallback onUsd;
  final VoidCallback onDigit0;
  final VoidCallback onDigit1;
  final VoidCallback onDigit2;
  final VoidCallback onDigit3;
  final VoidCallback onDigit4;
  final VoidCallback onDigit5;
  final VoidCallback onDigit6;
  final VoidCallback onDigit7;
  final VoidCallback onDigit8;
  final VoidCallback onDigit9;

  const RemoteModal({
    super.key,
    required this.visible,
    required this.onClose,
    required this.onPower,
    required this.onMute,
    required this.onSetup,
    required this.onVolUp,
    required this.onVolDown,
    required this.onPlayPause,
    required this.onPrev,
    required this.onNext,
    required this.onEq,
    required this.onRpt,
    required this.onUsd,
    required this.onDigit0,
    required this.onDigit1,
    required this.onDigit2,
    required this.onDigit3,
    required this.onDigit4,
    required this.onDigit5,
    required this.onDigit6,
    required this.onDigit7,
    required this.onDigit8,
    required this.onDigit9,
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();

    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final themeColors = Theme.of(context).colorScheme;

    return Container(
      color: colors.modalOverlay,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: colors.remoteModalBg,
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
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 10),
          width: 340, // Strict RN maxWidth constraint
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // --- Header ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.settings_remote, color: themeColors.onSurface),
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
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // --- Grid Container ---
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 20, // Horizontal margin equivalent
                runSpacing: 10, // Vertical margin equivalent
                children: [
                  // --- ROW 1 ---
                  _RemoteButton(label: "Power", icon: Icons.power_settings_new, type: RemoteButtonType.red, textColor: colors.remotePowerText, onPress: onPower),
                  _RemoteButton(label: "Mute", icon: Icons.volume_off, type: RemoteButtonType.defaultBtn, textColor: colors.remoteButtonText, onPress: onMute),
                  _RemoteButton(label: "Setup", icon: Icons.settings, type: RemoteButtonType.purple, textColor: colors.remoteButtonText, onPress: onSetup),
                  
                  // --- ROW 2 ---
                  _RemoteButton(label: "Vol +", icon: Icons.volume_up, type: RemoteButtonType.defaultBtn, textColor: colors.remoteButtonText, onPress: onVolUp),
                  _RemoteButton(label: "Play", icon: Icons.play_arrow, type: RemoteButtonType.blue, textColor: colors.remotePlayText, onPress: onPlayPause),
                  _RemoteButton(label: "Vol -", icon: Icons.volume_down, type: RemoteButtonType.defaultBtn, textColor: colors.remoteButtonText, onPress: onVolDown),
                  
                  // --- ROW 3 ---
                  _RemoteButton(label: "Prev", icon: Icons.skip_previous, type: RemoteButtonType.defaultBtn, textColor: colors.remoteButtonText, onPress: onPrev),
                  _RemoteButton(label: "EQ", icon: Icons.equalizer, type: RemoteButtonType.purple, textColor: colors.remoteEqText, onPress: onEq),
                  _RemoteButton(label: "Next", icon: Icons.skip_next, type: RemoteButtonType.defaultBtn, textColor: colors.remoteButtonText, onPress: onNext),
                  
                  // --- ROW 4 (Text Inside Buttons) ---
                  _RemoteButton(label: "RPT", type: RemoteButtonType.defaultBtn, textColor: colors.remoteButtonText, onPress: onRpt),
                  _RemoteButton(label: "U/SD", type: RemoteButtonType.defaultBtn, textColor: colors.remoteButtonText, onPress: onUsd),
                  _RemoteButton(label: "0", type: RemoteButtonType.defaultBtn, textColor: colors.remoteButtonText, onPress: onDigit0),
                  
                  // --- ROW 5 ---
                  _RemoteButton(label: "1", type: RemoteButtonType.defaultBtn, textColor: colors.remoteButtonText, onPress: onDigit1),
                  _RemoteButton(label: "2", type: RemoteButtonType.defaultBtn, textColor: colors.remoteButtonText, onPress: onDigit2),
                  _RemoteButton(label: "3", type: RemoteButtonType.defaultBtn, textColor: colors.remoteButtonText, onPress: onDigit3),
                  
                  // --- ROW 6 ---
                  _RemoteButton(label: "4", type: RemoteButtonType.defaultBtn, textColor: colors.remoteButtonText, onPress: onDigit4),
                  _RemoteButton(label: "5", type: RemoteButtonType.defaultBtn, textColor: colors.remoteButtonText, onPress: onDigit5),
                  _RemoteButton(label: "6", type: RemoteButtonType.defaultBtn, textColor: colors.remoteButtonText, onPress: onDigit6),
                  
                  // --- ROW 7 ---
                  _RemoteButton(label: "7", type: RemoteButtonType.defaultBtn, textColor: colors.remoteButtonText, onPress: onDigit7),
                  _RemoteButton(label: "8", type: RemoteButtonType.defaultBtn, textColor: colors.remoteButtonText, onPress: onDigit8),
                  _RemoteButton(label: "9", type: RemoteButtonType.defaultBtn, textColor: colors.remoteButtonText, onPress: onDigit9),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Private Widget to Encapsulate ImageBackground Styling ---
class _RemoteButton extends StatelessWidget {
  final String label;
  final IconData? icon; // Optional: If null, label renders inside button
  final RemoteButtonType type;
  final Color textColor;
  final VoidCallback onPress;

  const _RemoteButton({
    required this.label,
    this.icon,
    required this.type,
    required this.textColor,
    required this.onPress,
  });

  String _getAssetPath() {
    switch (type) {
      case RemoteButtonType.red:
        return 'assets/images/button-red.png';
      case RemoteButtonType.blue:
        return 'assets/images/button-blue.png';
      case RemoteButtonType.purple:
        return 'assets/images/button-purple.png';
      case RemoteButtonType.defaultBtn:
      default:
        return 'assets/images/button-default.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 80,
        // Using a Column so buttons with labels below align perfectly
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Replaces React Native's ImageBackground cleanly
            SizedBox(
              width: 80,
              height: 80,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Base Image
                  Image.asset(
                    _getAssetPath(),
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                  // Render Icon if provided, otherwise render text inside the image
                  if (icon != null)
                    Icon(icon, color: Colors.white, size: 32)
                  else
                    Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
            
            // Render label below ONLY if an icon was used inside
            if (icon != null) ...[
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ] else ...[
              // Invisible spacer to keep grid row height uniform
              const SizedBox(height: 8),
              const Text("", style: TextStyle(fontSize: 14)),
            ]
          ],
        ),
      ),
    );
  }
}