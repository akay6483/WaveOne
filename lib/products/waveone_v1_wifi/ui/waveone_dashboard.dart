import 'package:flutter/material.dart';
import 'package:waveone/core/theme/app_theme.dart';
import 'package:waveone/core/theme/responsive_layout.dart';
import 'package:waveone/core/widgets/attenuation_modal.dart';
import 'package:waveone/core/widgets/Knob.dart';
import 'package:waveone/core/widgets/preset_modal.dart';
import 'package:waveone/core/widgets/remote_modal.dart';
import 'package:waveone/core/widgets/global_settings_drawer.dart';
import 'package:waveone/products/waveone_v1_wifi/ui/widgets/mode_selector.dart';

class WaveOneDashboard extends StatefulWidget {
  const WaveOneDashboard({super.key});

  @override
  State<WaveOneDashboard> createState() => _WaveOneDashboardState();
}

class _WaveOneDashboardState extends State<WaveOneDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  double _mainVolumeAngle = 0.0;
  double _frontLeftAngle = 0.0;
  double _frontRightAngle = 0.0;
  double _centerAngle = 0.0;
  double _rearLeftAngle = 0.0;
  double _rearRightAngle = 0.0;

  // ... (rest of the methods)
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showRemoteModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => RemoteModal(
        onPower: () {},
        onMute: () {},
        onSetup: () {},
        onVolUp: () {},
        onVolDown: () {},
        onPlayPause: () {},
        onPrev: () {},
        onNext: () {},
        onEq: () {},
        onRpt: () {},
        onUsd: () {},
        onDigit0: () {},
        onDigit1: () {},
        onDigit2: () {},
        onDigit3: () {},
        onDigit4: () {},
        onDigit5: () {},
        onDigit6: () {},
        onDigit7: () {},
        onDigit8: () {},
        onDigit9: () {},
      ),
    );
  }

  void _showModeSelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const ModeSelector(),
    );
  }

  void _showPresetModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const PresetModal(),
    );
  }

  List<Widget> _buildAppBarActions() {
    return [
      if (_selectedIndex == 0) ...[
        IconButton(
          key: const ValueKey('remote_trigger'),
          icon: const Icon(Icons.settings_remote),
          tooltip: 'Remote Control',
          onPressed: _showRemoteModal,
        ),
        IconButton(
          key: const ValueKey('mode_trigger'),
          icon: const Icon(Icons.settings_input_component),
          tooltip: 'Mode Selector',
          onPressed: _showModeSelector,
        ),
        IconButton(
          key: const ValueKey('preset_trigger'),
          icon: const Icon(Icons.queue_music),
          tooltip: 'Presets',
          onPressed: _showPresetModal,
        ),
      ],
      if (_selectedIndex == 1)
        IconButton(
          key: const ValueKey('preset_trigger_eq'),
          icon: const Icon(Icons.queue_music),
          tooltip: 'Presets',
          onPressed: _showPresetModal,
        ),
    ];
  }

  Widget _buildDeviceControlView(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = theme.extension<AppColorsExtension>()!;

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Knob(
            size: 200.0,
            label: 'Volume',
            valueText: _mainVolumeAngle.toStringAsFixed(2),
            currentAngle: _mainVolumeAngle,
            isDarkTheme: isDark,
            iconColor: theme.colorScheme.onSurface,
            textMutedColor: colors.textMuted,
            onKnobTurned: (double newAngle, int newIndex) {
              setState(() {
                _mainVolumeAngle = newAngle;
              });
            },
          ),
          const SizedBox(height: 40),
          AttenuationModal(
            onClose: () {},
            backgroundColor: theme.cardColor,
            textColor: theme.colorScheme.onSurface,
            iconColor: theme.iconTheme.color ?? colors.textMuted,
            isDarkTheme: isDark,
            frontLeftAngle: _frontLeftAngle,
            frontLeftText: "${_frontLeftAngle.toInt()} dB",
            onFrontLeftTurned: (newAngle, _) {
              setState(() {
                _frontLeftAngle = newAngle;
              });
            },
            frontRightAngle: _frontRightAngle,
            frontRightText: "${_frontRightAngle.toInt()} dB",
            onFrontRightTurned: (newAngle, _) {
              setState(() {
                _frontRightAngle = newAngle;
              });
            },
            centerAngle: _centerAngle,
            centerText: "${_centerAngle.toInt()} dB",
            onCenterTurned: (newAngle, _) {
              setState(() {
                _centerAngle = newAngle;
              });
            },
            rearLeftAngle: _rearLeftAngle,
            rearLeftText: "${_rearLeftAngle.toInt()} dB",
            onRearLeftTurned: (newAngle, _) {
              setState(() {
                _rearLeftAngle = newAngle;
              });
            },
            rearRightAngle: _rearRightAngle,
            rearRightText: "${_rearRightAngle.toInt()} dB",
            onRearRightTurned: (newAngle, _) {
              setState(() {
                _rearRightAngle = newAngle;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedView(BuildContext context) {
    switch (_selectedIndex) {
      case 0:
        return _buildDeviceControlView(context);
      case 1:
        return const Center(child: Text("Equalizer View"));
      case 2:
        return const Center(child: Text("Settings View"));
      default:
        return const Center(child: Text("Unknown View"));
    }
  }

  Widget _buildMobileLayout() {
    return _buildSelectedView(context);
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        NavigationRail(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          labelType: NavigationRailLabelType.all,
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.tune),
              label: Text('Device Control'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.graphic_eq),
              label: Text('Equalizer'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.settings),
              label: Text('Settings'),
            ),
          ],
          trailing: Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: IconButton(
                  icon: const Icon(Icons.menu),
                  tooltip: 'Global Settings',
                  onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
                ),
              ),
            ),
          ),
        ),
        const VerticalDivider(thickness: 1, width: 1),
        Expanded(child: _buildSelectedView(context)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text('WaveOne V1'),
            actions: _buildAppBarActions(),
          ),
          endDrawer: const GlobalSettingsDrawer(),
          body: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
          bottomNavigationBar: isMobile
              ? BottomNavigationBar(
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.tune),
                      label: 'Device Control',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.graphic_eq),
                      label: 'Equalizer',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: 'Settings',
                    ),
                  ],
                )
              : null,
        );
      },
    );
  }
}
