import 'dart:math' as math;
import 'package:flutter/material.dart';

class Knob extends StatelessWidget {
  // --- UI Properties ---
  final double size;
  final String label;
  final String valueText;
  final double currentAngle;
  final ImageProvider? dialBaseImage;
  final ImageProvider? indicatorImage;

  // --- Styling Properties (Passed down to replace useTheme) ---
  final bool isDarkTheme;
  final Color iconColor;
  final Color textMutedColor;

  // --- Configuration ---
  final double minVal;
  final double maxVal;
  final double step;

  // --- Callbacks ---
  // Emits the newly calculated angle and index so the parent can update state/play audio
  final void Function(double newAngle, int newIndex)? onKnobTurned;

  // --- Angle Constants ---
  static const double minDeadZoneDeg = 135;
  static const double maxDeadZoneDeg = 225;
  static const double deadZoneSweep = 90;
  static const double liveZoneSweep = 270;
  static const double startAngle = maxDeadZoneDeg;

  const Knob({
    super.key,
    required this.size,
    required this.label,
    required this.valueText,
    required this.currentAngle,
    this.dialBaseImage,
    this.indicatorImage,
    this.isDarkTheme = true,
    this.iconColor = Colors.white,
    this.textMutedColor = Colors.grey,
    this.minVal = 0,
    this.maxVal = 100,
    this.step = 1,
    this.onKnobTurned,
  });

  // --- Pure Math Helpers ---
  double _getActualValueFromAngle(double angle) {
    final relativeAngle = (angle - startAngle + 360) % 360;
    final percent = relativeAngle / liveZoneSweep;
    final rawValue = minVal + percent * (maxVal - minVal);
    final snappedValue = (rawValue / step).round() * step;
    return math.min(math.max(snappedValue, minVal), maxVal);
  }

  int _getIndexFromValue(double value) {
    return ((value - minVal) / step).round();
  }

  int _getIndexFromAngle(double angle) {
    final actualValue = _getActualValueFromAngle(angle);
    return _getIndexFromValue(actualValue);
  }

  // --- Gesture Handler Factory ---
  //
  // WHY a factory instead of a plain _handlePanUpdate method:
  //
  // The TSX uses Reanimated's `rotation` SharedValue, which is mutated on every
  // onUpdate frame (`rotation.value = newAngle`). This means `previousAngle`
  // always reflects the *live, mid-gesture* angle — not the angle at the time
  // the widget was last built.
  //
  // The original Dart translation read `currentAngle` (a constructor parameter)
  // inside `_handlePanUpdate`. Because `currentAngle` is captured at build time
  // and the parent only rebuilds *after* a frame completes, it was stale for the
  // entire duration of a pan gesture. This caused two concrete bugs:
  //
  //   1. Dead-zone direction snap  (`if (currentAngle < 180)`) used the
  //      pre-gesture angle for every frame, potentially snapping to the wrong
  //      boundary mid-drag.
  //
  //   2. Parked-knob guard (`angleDiff > deadZoneSweep`) compared the new touch
  //      angle against the frozen build-time angle instead of the last committed
  //      frame angle, allowing or blocking jumps incorrectly.
  //
  // FIX: `_buildGestureDetector` creates a single-element List<double> — a
  // mutable heap object — that is seeded with `currentAngle` on pan start and
  // updated on every pan frame, exactly mirroring `rotation.value` semantics.
  // A List is used because Dart closures capture variables by reference only for
  // objects; a plain `double` local would not be mutable across closure calls.
  // This holds no widget state and is recreated on every build, so it is fully
  // compatible with StatelessWidget and the BLoC/get_it architecture.
  GestureDetector _buildGestureDetector(Widget child) {
    // Mirrors Reanimated's `rotation` SharedValue: mutable, frame-accurate.
    // Seeded in onPanStart so each gesture begins from the correct committed angle.
    final liveAngle = [currentAngle]; // List<double> — mutable reference type

    void handlePanStart(DragStartDetails _) {
      // Re-seed at gesture start in case the widget was rebuilt between gestures.
      liveAngle[0] = currentAngle;
    }

    void handlePanUpdate(DragUpdateDetails details) {
      if (onKnobTurned == null) return;

      final center = Offset(size / 2, size / 2);
      final x = details.localPosition.dx - center.dx;
      final y = details.localPosition.dy - center.dy;

      // Calculate angle with Y-axis flipped to put 0° at 12 o'clock,
      // matching: Math.atan2(x, -y) in the TSX.
      final angleRad = math.atan2(x, -y);
      double newAngle = ((angleRad * 180) / math.pi + 360) % 360;

      // Read the live mid-gesture angle — equivalent to `rotation.value` in TSX.
      final double previousAngle = liveAngle[0];

      final bool touchInDeadZone =
          newAngle >= minDeadZoneDeg && newAngle <= maxDeadZoneDeg;

      if (touchInDeadZone) {
        // Snap to whichever dead-zone boundary is nearest based on current
        // live angle, not the stale build-time `currentAngle`.
        if (previousAngle < 180) {
          newAngle = minDeadZoneDeg;
        } else {
          newAngle = maxDeadZoneDeg;
        }
      } else {
        final bool knobWasParked =
            previousAngle == minDeadZoneDeg || previousAngle == maxDeadZoneDeg;

        if (knobWasParked) {
          double angleDiff = newAngle - previousAngle;
          if (angleDiff > 180) angleDiff -= 360;
          if (angleDiff < -180) angleDiff += 360;

          if (angleDiff.abs() > deadZoneSweep) {
            newAngle = previousAngle;
          }
        }
      }

      // Commit the resolved angle so the next frame reads it correctly —
      // equivalent to `rotation.value = newAngle` in the TSX worklet.
      liveAngle[0] = newAngle;

      final newIndex = _getIndexFromAngle(newAngle);
      onKnobTurned!(newAngle, newIndex);
    }

    return GestureDetector(
      onPanStart: handlePanStart,
      onPanUpdate: handlePanUpdate,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Knob Dial Wrapper
          _buildGestureDetector(
            SizedBox(
              width: size,
              height: size,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Base Dial Image
                  Image(
                    image:
                        dialBaseImage ??
                        AssetImage(
                          isDarkTheme
                              ? 'assets/images/dial-base.png'
                              : 'assets/images/dial-base-dark.png',
                        ),
                    width: size,
                    height: size,
                    fit: BoxFit.contain,
                  ),
                  // Rotating Indicator Image
                  Transform.rotate(
                    angle:
                        currentAngle *
                        (math.pi /
                            180), // Convert degrees to radians for Flutter
                    child: Image(
                      image:
                          indicatorImage ??
                          const AssetImage('assets/images/knob-indicator.png'),
                      width: size,
                      height: size,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 4),

          // Label Text
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: iconColor,
            ),
          ),

          const SizedBox(height: 2),

          // Value Text
          Text(
            valueText,
            style: TextStyle(fontSize: 16, color: textMutedColor),
          ),
        ],
      ),
    );
  }
}
