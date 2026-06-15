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
      remoteButtonText: Color.lerp(
        remoteButtonText,
        other.remoteButtonText,
        t,
      )!,
      remotePowerText: Color.lerp(remotePowerText, other.remotePowerText, t)!,
      remotePlayText: Color.lerp(remotePlayText, other.remotePlayText, t)!,
      remoteEqText: Color.lerp(remoteEqText, other.remoteEqText, t)!,
    );
  }
}

/// Global Theme Definitions
class AppTheme {
  // --- Light Theme ---
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // Core Material Colors
    colorScheme: const ColorScheme.light(
      surface: Color(0xFFEAF0F8), // background
      onSurface: Color(0xFF1C1C1E), // text
      primary: Color(0xFF2979FF), // primary
      error: Colors.red, // error
      surfaceContainerHighest: Color(0xFFE5E5EA), // border
    ),

    // Component Backgrounds
    cardColor: const Color(0xFFFFFFFF), // card
    scaffoldBackgroundColor: const Color(0xFFEAF0F8),
    canvasColor: const Color(0xFFFFFFFF), // drawerBackground

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF8FAFD), // headerBackground
      iconTheme: IconThemeData(color: Color(0xFF8E8E93)), // icon
      titleTextStyle: TextStyle(
        color: Color(0xFF1C1C1E),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFF5F7FA), // tabBarBackground
      selectedItemColor: Color(0xFF2979FF),
      unselectedItemColor: Color(0xFFC7C7CC), // inactiveTint
    ),

    iconTheme: const IconThemeData(color: Color(0xFF8E8E93)),

    // Custom Extension Colors
    extensions: const <ThemeExtension<dynamic>>[
      AppColorsExtension(
        textMuted: Color(0xFF5E5E63),
        inactiveTint: Color(0xFFC7C7CC),
        thumbColor: Color(0xFFE0E0E0),
        modalOverlay: Color(0x66000000), // rgba(0,0,0,0.4)
        modalBackground: Color(0xFFFAFAFC),
        remoteModalBg: Color(0xFFF1F3F6),
        remoteButtonText: Color(0xFF1C1C1E),
        remotePowerText: Color(0xFFFFFFFF),
        remotePlayText: Color(0xFFFFFFFF),
        remoteEqText: Color(0xFFFFFFFF),
      ),
    ],
  );

  // --- Dark Theme ---
  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    // Core Material Colors
    colorScheme: const ColorScheme.dark(
      surface: Color(0xFF121212), // darkBg
      onSurface: Color(0xFFE1E1E1), // darkText
      primary: Color(0xFF3DBEFF), // blueDark
      error: Colors.red,
      surfaceContainerHighest: Color(0xFF2C2C2E), // darkBorder
    ),

    // Component Backgrounds
    cardColor: const Color(0xFF1E1E1E), // darkCard
    scaffoldBackgroundColor: const Color(0xFF121212),
    canvasColor: const Color(0xFF1B1D21), // greyDarker (drawer)

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF25292E), // greyDark (header)
      iconTheme: IconThemeData(color: Color(0xFFD0D0D0)), // darkIcon
      titleTextStyle: TextStyle(
        color: Color(0xFFE1E1E1),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF25292E), // greyDark (tabBar)
      selectedItemColor: Color(0xFF3DBEFF),
      unselectedItemColor: Color(0xFF767577), // darkInactive
    ),

    iconTheme: const IconThemeData(color: Color(0xFFD0D0D0)),

    // Custom Extension Colors
    extensions: const <ThemeExtension<dynamic>>[
      AppColorsExtension(
        textMuted: Color(0xFFA0A0A0), // darkMuted
        inactiveTint: Color(0xFF767577), // darkInactive
        thumbColor: Color(0xFFF4F3F4), // darkThumb
        modalOverlay: Color(0x99000000), // rgba(0,0,0,0.6)
        modalBackground: Color(0xFF2A2A2E), // modalBackground (dark)
        remoteModalBg: Color(0xFF3A3A3A), // remoteModalBg (dark)
        remoteButtonText: Color(0xFFE1E1E1), // Matched to text in dark mode
        remotePowerText: Color(0xFFFFFFFF),
        remotePlayText: Color(0xFFFFFFFF),
        remoteEqText: Color(0xFFFFFFFF),
      ),
    ],
  );
}
