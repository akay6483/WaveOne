import 'package:flutter/material.dart';
import 'package:waveone_app/core/theme/app_theme.dart';

class MainNavigationShell extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final Widget child; // The active screen body

  const MainNavigationShell({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final themeColors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: themeColors.surface,
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onTabSelected,
        backgroundColor: themeColors.surfaceContainerHighest, // Maps to tabBarBackground
        selectedItemColor: themeColors.primary,
        unselectedItemColor: colors.inactiveTint,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.wifi_outline),
            activeIcon: Icon(Icons.wifi),
            label: 'Devices',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.surround_sound_outlined),
            activeIcon: Icon(Icons.surround_sound),
            label: 'Control',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.graphic_eq_outlined),
            activeIcon: Icon(Icons.graphic_eq),
            label: 'DSP',
          ),
        ],
      ),
    );
  }
}