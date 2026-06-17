import 'package:flutter/material.dart';

/// Custom semantic colors specific to AcousticOne/WaveOne
/// Translates the highly specific keys from colors.tsx
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color textMuted;
  final Color inactiveTint;
  final Color thumbColor;
  final Color modalOverlay;
  final Color modalBackground;
  final Color remoteModalBg;
  final Color remoteButtonText;
  final Color remotePowerText;
  final Color remotePlayText;
  final Color remoteEqText;

  const AppColorsExtension({
    required this.textMuted,
    required this.inactiveTint,
    required this.thumbColor,
    required this.modalOverlay,
    required this.modalBackground,
    required this.remoteModalBg,
    required this.remoteButtonText,
    required this.remotePowerText,
    required this.remotePlayText,
    required this.remoteEqText,
  });

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? textMuted,
    Color? inactiveTint,
    Color? thumbColor,
    Color? modalOverlay,
    Color? modalBackground,
    Color? remoteModalBg,
    Color? remoteButtonText,
    Color? remotePowerText,
    Color? remotePlayText,
    Color? remoteEqText,
  }) {
    return AppColorsExtension(
      textMuted: textMuted ?? this.textMuted,
      inactiveTint: inactiveTint ?? this.inactiveTint,
      thumbColor: thumbColor ?? this.thumbColor,
      modalOverlay: modalOverlay ?? this.modalOverlay,
      modalBackground: modalBackground ?? this.modalBackground,
      remoteModalBg: remoteModalBg ?? this.remoteModalBg,
      remoteButtonText: remoteButtonText ?? this.remoteButtonText,
      remotePowerText: remotePowerText ?? this.remotePowerText,
      remotePlayText: remotePlayText ?? this.remotePlayText,
      remoteEqText: remoteEqText ?? this.remoteEqText,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
    covariant ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) {
      return this;
    }
    return AppColorsExtension(
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      inactiveTint: Color.lerp(inactiveTint, other.inactiveTint, t)!,
      thumbColor: Color.lerp(thumbColor, other.thumbColor, t)!,
      modalOverlay: Color.lerp(modalOverlay, other.modalOverlay, t)!,
      modalBackground: Color.lerp(modalBackground, other.modalBackground, t)!,
      remoteModalBg: Color.lerp(remoteModalBg, other.remoteModalBg, t)!,
      remoteButtonText: Color.lerp(remoteButtonText, other.remoteButtonText, t)!,
      remotePowerText: Color.lerp(remotePowerText, other.remotePowerText, t)!,
      remotePlayText: Color.lerp(remotePlayText, other.remotePlayText, t)!,
      remoteEqText: Color.lerp(remoteEqText, other.remoteEqText, t)!,
    );
  }
}

/// ThemeExtension for glowing LED feedback indicators.
class LedColors extends ThemeExtension<LedColors> {
  final Color green;
  final Color red;
  final Color amber;

  const LedColors({
    required this.green,
    required this.red,
    required this.amber,
  });

  @override
  ThemeExtension<LedColors> copyWith({
    Color? green,
    Color? red,
    Color? amber,
  }) {
    return LedColors(
      green: green ?? this.green,
      red: red ?? this.red,
      amber: amber ?? this.amber,
    );
  }

  @override
  ThemeExtension<LedColors> lerp(
    covariant ThemeExtension<LedColors>? other,
    double t,
  ) {
    if (other is! LedColors) {
      return this;
    }
    return LedColors(
      green: Color.lerp(green, other.green, t)!,
      red: Color.lerp(red, other.red, t)!,
      amber: Color.lerp(amber, other.amber, t)!,
    );
  }

  /// High-blur glow effects simulating real physical LEDs
  List<BoxShadow> greenGlow({double blur = 8.0, double spread = 1.0}) => [
        BoxShadow(
          color: green.withValues(alpha: 0.6),
          blurRadius: blur,
          spreadRadius: spread,
        ),
        BoxShadow(
          color: green.withValues(alpha: 0.2),
          blurRadius: blur * 2,
          spreadRadius: spread * 0.5,
        ),
      ];

  List<BoxShadow> redGlow({double blur = 8.0, double spread = 1.0}) => [
        BoxShadow(
          color: red.withValues(alpha: 0.6),
          blurRadius: blur,
          spreadRadius: spread,
        ),
        BoxShadow(
          color: red.withValues(alpha: 0.2),
          blurRadius: blur * 2,
          spreadRadius: spread * 0.5,
        ),
      ];

  List<BoxShadow> amberGlow({double blur = 8.0, double spread = 1.0}) => [
        BoxShadow(
          color: amber.withValues(alpha: 0.6),
          blurRadius: blur,
          spreadRadius: spread,
        ),
        BoxShadow(
          color: amber.withValues(alpha: 0.2),
          blurRadius: blur * 2,
          spreadRadius: spread * 0.5,
        ),
      ];
}

/// ThemeExtension for skeletal DAW Hardware Panels and racks.
class HardwarePanelTheme extends ThemeExtension<HardwarePanelTheme> {
  final BoxDecoration panelDecoration;
  final BoxDecoration recessedDecoration;
  final Color panelColor;
  final Color borderColor;

  const HardwarePanelTheme({
    required this.panelDecoration,
    required this.recessedDecoration,
    required this.panelColor,
    required this.borderColor,
  });

  @override
  ThemeExtension<HardwarePanelTheme> copyWith({
    BoxDecoration? panelDecoration,
    BoxDecoration? recessedDecoration,
    Color? panelColor,
    Color? borderColor,
  }) {
    return HardwarePanelTheme(
      panelDecoration: panelDecoration ?? this.panelDecoration,
      recessedDecoration: recessedDecoration ?? this.recessedDecoration,
      panelColor: panelColor ?? this.panelColor,
      borderColor: borderColor ?? this.borderColor,
    );
  }

  @override
  ThemeExtension<HardwarePanelTheme> lerp(
    covariant ThemeExtension<HardwarePanelTheme>? other,
    double t,
  ) {
    if (other is! HardwarePanelTheme) {
      return this;
    }
    return HardwarePanelTheme(
      panelDecoration: BoxDecoration.lerp(panelDecoration, other.panelDecoration, t)!,
      recessedDecoration: BoxDecoration.lerp(recessedDecoration, other.recessedDecoration, t)!,
      panelColor: Color.lerp(panelColor, other.panelColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
    );
  }
}

/// Global Theme Definitions
class AppTheme {
  // --- Light Theme (Analog Silver/Grey Chassis) ---
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // Core Material Colors
    colorScheme: const ColorScheme.light(
      surface: Color(0xFFE2E8F0), // light gray chassis
      onSurface: Color(0xFF0F172A),
      primary: Color(0xFF2563EB),
      error: Color(0xFFEF4444),
      surfaceContainerHighest: Color(0xFFCBD5E1), // separator/border
    ),

    // Component Backgrounds
    cardColor: const Color(0xFFE2E8F0),
    scaffoldBackgroundColor: const Color(0xFFD1D5DB), // chassis outer casing
    canvasColor: const Color(0xFFF1F5F9),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFE2E8F0),
      iconTheme: IconThemeData(color: Color(0xFF64748B)),
      titleTextStyle: TextStyle(
        color: Color(0xFF0F172A),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFE2E8F0),
      selectedItemColor: Color(0xFF2563EB),
      unselectedItemColor: Color(0xFF94A3B8),
    ),

    cardTheme: CardThemeData(
      color: const Color(0xFFE2E8F0),
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: const BorderSide(
          color: Color(0xFFCBD5E1),
          width: 1,
        ),
      ),
    ),

    iconTheme: const IconThemeData(color: Color(0xFF64748B)),

    // Custom Extension Colors
    extensions: <ThemeExtension<dynamic>>[
      const AppColorsExtension(
        textMuted: Color(0xFF64748B),
        inactiveTint: Color(0xFF94A3B8),
        thumbColor: Color(0xFFE2E8F0),
        modalOverlay: Color(0x66000000),
        modalBackground: Color(0xFFF8FAFC),
        remoteModalBg: Color(0xFFF1F5F9),
        remoteButtonText: Color(0xFF0F172A),
        remotePowerText: Color(0xFFFFFFFF),
        remotePlayText: Color(0xFFFFFFFF),
        remoteEqText: Color(0xFFFFFFFF),
      ),
      const LedColors(
        green: Color(0xFF22C55E),
        red: Color(0xFFEF4444),
        amber: Color(0xFFF59E0B),
      ),
      HardwarePanelTheme(
        panelColor: const Color(0xFFE2E8F0),
        borderColor: const Color(0xFFCBD5E1),
        panelDecoration: BoxDecoration(
          color: const Color(0xFFE2E8F0),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.9),
              offset: const Offset(-1, -1),
              blurRadius: 1,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              offset: const Offset(1, 1),
              blurRadius: 2,
            ),
          ],
        ),
        recessedDecoration: BoxDecoration(
          color: const Color(0xFFCBD5E1),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: const Color(0xFF94A3B8), width: 1),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFB8C4D4), Color(0xFFDDE4EC)],
          ),
        ),
      ),
    ],
  );

  // --- Dark Theme (DAW Obsidian Metal Chassis) ---
  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    // Core Material Colors
    colorScheme: const ColorScheme.dark(
      surface: Color(0xFF1B1C1F), // dark aluminum surface plate
      onSurface: Color(0xFFE1E4EC), // light metallic text
      primary: Color(0xFF3DBEFF), // active indicator cyan/blue
      error: Color(0xFFFF0055),
      surfaceContainerHighest: Color(0xFF2D3037), // mount bezel separator
    ),

    // Component Backgrounds
    cardColor: const Color(0xFF1B1C1F),
    scaffoldBackgroundColor: const Color(0xFF0E0F11), // main chassis outer rack
    canvasColor: const Color(0xFF131417),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF16171A),
      iconTheme: IconThemeData(color: Color(0xFF8E929E)),
      titleTextStyle: TextStyle(
        color: Color(0xFFE1E4EC),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF16171A),
      selectedItemColor: Color(0xFF3DBEFF),
      unselectedItemColor: Color(0xFF5A5E6B),
    ),

    cardTheme: CardThemeData(
      color: const Color(0xFF1B1C1F),
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: const BorderSide(
          color: Color(0xFF2D3037),
          width: 1,
        ),
      ),
    ),

    iconTheme: const IconThemeData(color: Color(0xFF8E929E)),

    // Custom Extension Colors
    extensions: <ThemeExtension<dynamic>>[
      const AppColorsExtension(
        textMuted: Color(0xFF8E929E),
        inactiveTint: Color(0xFF5A5E6B),
        thumbColor: Color(0xFFD1D5DB),
        modalOverlay: Color(0xAA000000),
        modalBackground: Color(0xFF16171A),
        remoteModalBg: Color(0xFF141518),
        remoteButtonText: Color(0xFFE1E4EC),
        remotePowerText: Color(0xFFFFFFFF),
        remotePlayText: Color(0xFFFFFFFF),
        remoteEqText: Color(0xFFFFFFFF),
      ),
      const LedColors(
        green: Color(0xFF39FF14), // Glowing neon green
        red: Color(0xFFFF0055),   // Glowing warning red
        amber: Color(0xFFFF9F0A), // Glowing amber
      ),
      HardwarePanelTheme(
        panelColor: const Color(0xFF1B1C1F),
        borderColor: const Color(0xFF2D3037),
        panelDecoration: BoxDecoration(
          color: const Color(0xFF1B1C1F),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: const Color(0xFF2D3037), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.04),
              offset: const Offset(0, 1),
              blurRadius: 0,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              offset: const Offset(1, 2),
              blurRadius: 4,
            ),
          ],
        ),
        recessedDecoration: BoxDecoration(
          color: const Color(0xFF0F1012),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: const Color(0xFF1F2125), width: 1),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0C0D0E), Color(0xFF15171A)],
          ),
        ),
      ),
    ],
  );
}
