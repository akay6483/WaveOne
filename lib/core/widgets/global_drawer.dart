import 'package:flutter/material.dart';
import 'package:waveone/core/theme/app_theme.dart';
import 'package:waveone/core/ui/screens/product_selection_screen.dart';
import 'package:waveone/products/waveone_v1_wifi/ui/device_selection_screen.dart';
import 'package:waveone/products/waveone_v1_wifi/ui/waveone_dashboard.dart';
import 'package:waveone/core/widgets/settings_menu.dart';
import 'package:waveone/core/widgets/info_page.dart';
import 'package:waveone/core/widgets/support_page.dart';
import 'package:waveone/core/widgets/privacy_policy_page.dart';

class GlobalDrawer extends StatelessWidget {
  const GlobalDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final themeColors = Theme.of(context).colorScheme;

    return Drawer(
      backgroundColor: Theme.of(context).canvasColor,
      child: Column(
        children: [
          // Drawer Header
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 16.0,
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/icon.png',
                      width: 64,
                      height: 64,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 64,
                          height: 64,
                          color: themeColors.primary.withValues(alpha: 0.2),
                          child: Icon(
                            Icons.speaker,
                            color: themeColors.primary,
                            size: 32,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'WaveOne',
                    style: TextStyle(
                      color: themeColors.onSurface,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(color: colors.textMuted, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 1, color: themeColors.surfaceContainerHighest),

          // Scrollable Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.home,
                  title: 'Home (Control)',
                  onTap: () {
                    // Close drawer
                    Navigator.pop(context);
                    // Navigate to Dashboard
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WaveOneDashboard(),
                      ),
                    );
                    // TODO: Wire up navigation routing
                  },
                  colors: colors,
                  themeColors: themeColors,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.swap_horiz,
                  title: 'Change Product',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductSelectionScreen(),
                      ),
                    );
                    // TODO: Wire up navigation routing
                  },
                  colors: colors,
                  themeColors: themeColors,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.wifi,
                  title: 'My Devices (Connection)',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DeviceSelectionScreen(),
                      ),
                    );
                    // TODO: Wire up navigation routing
                  },
                  colors: colors,
                  themeColors: themeColors,
                ),
                Divider(height: 1, color: themeColors.surfaceContainerHighest),
                _buildDrawerItem(
                  context,
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const _SettingsHost(),
                      ),
                    );
                    // TODO: Wire up navigation routing
                  },
                  colors: colors,
                  themeColors: themeColors,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.info_outline,
                  title: 'About',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const _InfoHost(),
                      ),
                    );
                    // TODO: Wire up navigation routing
                  },
                  colors: colors,
                  themeColors: themeColors,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.help_outline,
                  title: 'Support',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const _SupportHost(),
                      ),
                    );
                    // TODO: Wire up navigation routing
                  },
                  colors: colors,
                  themeColors: themeColors,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.shield_outlined,
                  title: 'Privacy Policy',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const _PrivacyPolicyHost(),
                      ),
                    );
                    // TODO: Wire up navigation routing
                  },
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
      leading: Icon(icon, color: themeColors.primary),
      title: Text(
        title,
        style: TextStyle(
          color: themeColors.onSurface,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: colors.inactiveTint, size: 20),
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
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
      appBar: AppBar(
        title: const Text('Support'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SupportPage(
        onContactSupport: () {
          // TODO: Refactor support actions to trigger native URL launcher events via Bloc.
        },
        onReportIssue: () {
          // TODO: Refactor support actions to trigger native URL launcher events via Bloc.
        },
      ),
    );
  }
}

class _PrivacyPolicyHost extends StatelessWidget {
  const _PrivacyPolicyHost();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const PrivacyPolicyPage(),
    );
  }
}

class _InfoHost extends StatelessWidget {
  const _InfoHost();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About / Info'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const InfoPage(),
    );
  }
}
