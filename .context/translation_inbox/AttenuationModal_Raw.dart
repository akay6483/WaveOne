import 'package:flutter/material.dart';
// Assuming Knob.dart is in the same directory or properly imported
import 'Knob.dart'; 

class AttenuationModal extends StatelessWidget {
  // --- UI & Theming Properties ---
  final VoidCallback onClose;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final bool isDarkTheme;

  // --- Knob States & Callbacks ---
  // Front Left
  final double frontLeftAngle;
  final String frontLeftText;
  final void Function(double newAngle, int newIndex)? onFrontLeftTurned;

  // Front Right
  final double frontRightAngle;
  final String frontRightText;
  final void Function(double newAngle, int newIndex)? onFrontRightTurned;

  // Center
  final double centerAngle;
  final String centerText;
  final void Function(double newAngle, int newIndex)? onCenterTurned;

  // Rear Left
  final double rearLeftAngle;
  final String rearLeftText;
  final void Function(double newAngle, int newIndex)? onRearLeftTurned;

  // Rear Right
  final double rearRightAngle;
  final String rearRightText;
  final void Function(double newAngle, int newIndex)? onRearRightTurned;

  // Note: subwoofer state was in the TSX interface but unused in the UI. 
  // Omitted here to match the exact visual layout of the original.

  const AttenuationModal({
    super.key,
    required this.onClose,
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
    this.isDarkTheme = true,
    
    required this.frontLeftAngle,
    required this.frontLeftText,
    this.onFrontLeftTurned,

    required this.frontRightAngle,
    required this.frontRightText,
    this.onFrontRightTurned,

    required this.centerAngle,
    required this.centerText,
    this.onCenterTurned,

    required this.rearLeftAngle,
    required this.rearLeftText,
    this.onRearLeftTurned,

    required this.rearRightAngle,
    required this.rearRightText,
    this.onRearRightTurned,
  });

  @override
  Widget build(BuildContext context) {
    // Replaces Dimensions.get("window").width * 0.38
    final double knobSize = MediaQuery.sizeOf(context).width * 0.38;

    return SafeArea(
      bottom: false,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        // Use MainAxisSize.min so it acts properly inside a bottom sheet
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            // --- Header Section ---
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.speaker, size: 24, color: iconColor),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Attenuation',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(Icons.close, size: 26, color: textColor),
                        onPressed: onClose,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(), // Removes default padding for perfect alignment
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- Knobs Grid: Row 1 (Front) ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Knob(
                  label: 'Front Left',
                  size: knobSize,
                  currentAngle: frontLeftAngle,
                  valueText: frontLeftText,
                  onKnobTurned: onFrontLeftTurned,
                  minVal: -14,
                  maxVal: 0,
                  step: 1,
                  isDarkTheme: isDarkTheme,
                  iconColor: iconColor,
                  dialBaseImage: const AssetImage('assets/images/dial-base.png'),
                  indicatorImage: const AssetImage('assets/images/dial-indicator-green.png'),
                ),
                Knob(
                  label: 'Front Right',
                  size: knobSize,
                  currentAngle: frontRightAngle,
                  valueText: frontRightText,
                  onKnobTurned: onFrontRightTurned,
                  minVal: -14,
                  maxVal: 0,
                  step: 1,
                  isDarkTheme: isDarkTheme,
                  iconColor: iconColor,
                  dialBaseImage: const AssetImage('assets/images/dial-base.png'),
                  indicatorImage: const AssetImage('assets/images/dial-indicator-green.png'),
                ),
              ],
            ),

            // --- Knobs Grid: Row 2 (Center) ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Knob(
                  label: 'Center',
                  size: knobSize,
                  currentAngle: centerAngle,
                  valueText: centerText,
                  onKnobTurned: onCenterTurned,
                  minVal: -14,
                  maxVal: 0,
                  step: 1,
                  isDarkTheme: isDarkTheme,
                  iconColor: iconColor,
                  dialBaseImage: const AssetImage('assets/images/dial-base.png'),
                  indicatorImage: const AssetImage('assets/images/knob-indicator.png'),
                ),
              ],
            ),

            // --- Knobs Grid: Row 3 (Rear) ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Knob(
                  label: 'Rear Left',
                  size: knobSize,
                  currentAngle: rearLeftAngle,
                  valueText: rearLeftText,
                  onKnobTurned: onRearLeftTurned,
                  minVal: -14,
                  maxVal: 0,
                  step: 1,
                  isDarkTheme: isDarkTheme,
                  iconColor: iconColor,
                  dialBaseImage: const AssetImage('assets/images/dial-base.png'),
                  indicatorImage: const AssetImage('assets/images/dial-indicator-blue.png'),
                ),
                Knob(
                  label: 'Rear Right',
                  size: knobSize,
                  currentAngle: rearRightAngle,
                  valueText: rearRightText,
                  onKnobTurned: onRearRightTurned,
                  minVal: -14,
                  maxVal: 0,
                  step: 1,
                  isDarkTheme: isDarkTheme,
                  iconColor: iconColor,
                  dialBaseImage: const AssetImage('assets/images/dial-base.png'),
                  indicatorImage: const AssetImage('assets/images/dial-indicator-blue.png'),
                ),
              ],
            ),
            
            // Safe Area bottom padding for devices with home indicators
            SizedBox(height: MediaQuery.paddingOf(context).bottom),
          ],
        ),
      ),
    );
  }
}