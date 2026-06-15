import 'package:flutter/material.dart';
import 'package:waveone/core/theme/app_theme.dart';
import 'package:waveone/core/widgets/info_page.dart';
import 'package:waveone/core/widgets/privacy_policy_page.dart';
import 'package:waveone/core/widgets/settings_menu.dart';
import 'package:waveone/core/widgets/support_page.dart';

class GlobalSettingsDrawer extends StatelessWidget {
  const GlobalSettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final themeColors = Theme.of(context).colorScheme;

    return Drawer(
      backgroundColor: Theme.of(context).canvasColor,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: themeColors.surface),
            child: Center(
              child: Text(
                'WaveOne Settings',
                style: TextStyle(
                  color: themeColors.onSurface,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const _SettingsHost(),
                    ),
                  ),
                  colors: colors,
                  themeColors: themeColors,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.help_outline,
                  title: 'Support',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const _SupportHost(),
                    ),
                  ),
                  colors: colors,
                  themeColors: themeColors,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Policy',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const _PrivacyPolicyHost(),
                    ),
                  ),
                  colors: colors,
                  themeColors: themeColors,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.info_outline,
                  title: 'About / Info',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const _InfoHost()),
                  ),
                  colors: colors,
                  themeColors: themeColors,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required AppColorsExtension colors,
    required ColorScheme themeColors,
  }) {
    return ListTile(
      leading: Icon(icon, color: themeColors.onSurface),
      title: Text(title, style: TextStyle(color: themeColors.onSurface)),
      trailing: Icon(Icons.chevron_right, color: colors.inactiveTint),
      onTap: onTap,
    );
  }
}

class _SettingsHost extends StatefulWidget {
  const _SettingsHost();

  @override
  State<_SettingsHost> createState() => _SettingsHostState();
}

class _SettingsHostState extends State<_SettingsHost> {
  ThemeMode _currentThemeMode = ThemeMode.system;
  bool _isHapticsEnabled = true;
  bool _isAudioEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SettingsMenu(
        currentThemeMode: _currentThemeMode,
        onThemeModeChanged: (mode) => setState(() => _currentThemeMode = mode),
        isHapticsEnabled: _isHapticsEnabled,
        onHapticsChanged: (val) => setState(() => _isHapticsEnabled = val),
        isAudioEnabled: _isAudioEnabled,
        onAudioChanged: (val) => setState(() => _isAudioEnabled = val),
      ),
      // TODO: Refactor settings state injection to use WaveOneBloc or SettingsBloc.
    );
  }
}

class _SupportHost extends StatelessWidget {
  const _SupportHost();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Support')),
      body: SupportPage(onContactSupport: () {}, onReportIssue: () {}),
      // TODO: Refactor support actions to trigger native URL launcher events via Bloc.
    );
  }
}

class _PrivacyPolicyHost extends StatelessWidget {
  const _PrivacyPolicyHost();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: const PrivacyPolicyPage(),
    );
  }
}

class _InfoHost extends StatelessWidget {
  const _InfoHost();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About / Info')),
      body: const InfoPage(),
    );
  }
}
