import 'package:flutter/material.dart';
import 'package:waveone/core/theme/app_theme.dart';
import 'package:waveone/core/theme/responsive_layout.dart';

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

    return ResponsiveLayout(
      mobileBody: Scaffold(
        backgroundColor: themeColors.surface,
        body: child,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: onTabSelected,
          backgroundColor:
              themeColors.surfaceContainerHighest, // Maps to tabBarBackground
          selectedItemColor: themeColors.primary,
          unselectedItemColor: colors.inactiveTint,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.wifi),
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
      ),
      desktopBody: Scaffold(
        backgroundColor: themeColors.surface,
        body: Row(
          children: [
            NavigationRail(
              backgroundColor: themeColors.surfaceContainerHighest,
              selectedIndex: selectedIndex,
              onDestinationSelected: onTabSelected,
              selectedIconTheme: IconThemeData(color: themeColors.primary),
              unselectedIconTheme: IconThemeData(color: colors.inactiveTint),
              selectedLabelTextStyle: TextStyle(color: themeColors.primary),
              unselectedLabelTextStyle: TextStyle(color: colors.inactiveTint),
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.wifi),
                  selectedIcon: Icon(Icons.wifi),
                  label: Text('Devices'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.surround_sound_outlined),
                  selectedIcon: Icon(Icons.surround_sound),
                  label: Text('Control'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.graphic_eq_outlined),
                  selectedIcon: Icon(Icons.graphic_eq),
                  label: Text('DSP'),
                ),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
