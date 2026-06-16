import 'package:flutter/material.dart';
import 'package:waveone/core/theme/app_theme.dart';

class AppLayoutShell extends StatelessWidget {
  final bool isDbReady;
  final Widget currentBody;

  // Tab Navigation
  final int selectedTabIndex;
  final ValueChanged<int> onTabSelected;

  // Drawer Actions
  final VoidCallback onSupportTapped;
  final VoidCallback onPrivacyTapped;

  const AppLayoutShell({
    super.key,
    required this.isDbReady,
    required this.currentBody,
    required this.selectedTabIndex,
    required this.onTabSelected,
    required this.onSupportTapped,
    required this.onPrivacyTapped,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final themeColors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // --- Loading State ---
    if (!isDbReady) {
      return Scaffold(
        backgroundColor: const Color(0xFF121212),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/favicon.png', width: 100, height: 100),
              const SizedBox(height: 20),
              const CircularProgressIndicator(color: Colors.blue),
            ],
          ),
        ),
      );
    }

    // --- Ready State (Drawer + Tabs) ---
    return Scaffold(
      backgroundColor: themeColors.surface,
      appBar: AppBar(
        backgroundColor: themeColors.surfaceContainerHighest,
        elevation: 0,
        iconTheme: IconThemeData(color: themeColors.primary),
        title: Image.asset(
          isDark ? 'assets/images/darkAO.png' : 'assets/images/lightAO.png',
          width: 40,
          height: 40,
          fit: BoxFit.contain,
        ),
        centerTitle: false,
      ),
      drawer: _buildDrawer(themeColors, colors),
      body: currentBody,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTabIndex,
        onTap: onTabSelected,
        backgroundColor: themeColors.surfaceContainerHighest,
        selectedItemColor: themeColors.primary,
        unselectedItemColor: colors.inactiveTint,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.network_wifi),
            activeIcon: Icon(Icons.wifi),
            label: "Devices",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.surround_sound),
            activeIcon: Icon(Icons.surround_sound),
            label: "Control",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.graphic_eq),
            activeIcon: Icon(Icons.graphic_eq),
            label: "DSP",
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(ColorScheme themeColors, AppColorsExtension colors) {
    return Drawer(
      backgroundColor: themeColors.surface,
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.help_outline, color: themeColors.primary),
              title: Text(
                "Support",
                style: TextStyle(
                  color: themeColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: onSupportTapped,
            ),
            ListTile(
              leading: Icon(Icons.shield_outlined, color: themeColors.primary),
              title: Text(
                "Privacy Policy",
                style: TextStyle(
                  color: themeColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: onPrivacyTapped,
            ),
          ],
        ),
      ),
    );
  }
}
