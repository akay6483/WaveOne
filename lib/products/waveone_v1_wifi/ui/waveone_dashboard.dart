import 'package:flutter/material.dart';
import 'package:waveone/core/theme/app_theme.dart';
import 'package:waveone/core/widgets/attenuation_modal.dart';
import 'package:waveone/core/widgets/device_info_modal.dart';
import 'package:waveone/core/widgets/help_modal.dart';
import 'package:waveone/core/widgets/preset_modal.dart';
import 'package:waveone/core/widgets/remote_modal.dart';
import 'package:waveone/products/waveone_v1_wifi/ui/control_dashboard_view.dart';
import 'package:waveone/products/waveone_v1_wifi/ui/device_connect_screen.dart';
import 'package:waveone/products/waveone_v1_wifi/ui/main_navigation_shell.dart';

class WaveOneDashboard extends StatefulWidget {
  const WaveOneDashboard({super.key});

  @override
  State<WaveOneDashboard> createState() => _WaveOneDashboardState();
}

class _WaveOneDashboardState extends State<WaveOneDashboard> {
  int _selectedIndex = 0;

  // Connection Mock State
  ConnectionMode _connectionMode = ConnectionMode.wifi;
  final List<DeviceUIModel> _availableDevices = [
    const DeviceUIModel(
      id: '1',
      modelName: 'WaveOne PV',
      deviceCode: 'W1-PV-1234',
      ipAddress: '192.168.1.100',
      isConnected: false,
    ),
  ];

  // Control Dashboard Mock State
  String _activeMode = 'Music';
  bool _isModeExpanded = false;
  double _mainVolAngle = 40.0;
  double _subVolAngle = -5.0;

  // Attenuation Mock State
  double _frontLeftAngle = 0.0;
  double _frontRightAngle = 0.0;
  double _centerAngle = 0.0;
  double _rearLeftAngle = 0.0;
  double _rearRightAngle = 0.0;

  // TODO: Refactor knob state/modal triggers to use WaveOneBloc.

  void _onOpenAttenuation() {
    showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;
        final colors = theme.extension<AppColorsExtension>()!;

        return StatefulBuilder(
          builder: (context, setModalState) {
            return AttenuationModal(
              onClose: () => Navigator.pop(context),
              backgroundColor: theme.cardColor,
              textColor: theme.colorScheme.onSurface,
              iconColor: theme.iconTheme.color ?? colors.textMuted,
              isDarkTheme: isDark,
              frontLeftAngle: _frontLeftAngle,
              frontLeftText: "${_frontLeftAngle.toInt()} dB",
              onFrontLeftTurned: (newAngle, _) {
                setModalState(() => _frontLeftAngle = newAngle);
                setState(() => _frontLeftAngle = newAngle);
              },
              frontRightAngle: _frontRightAngle,
              frontRightText: "${_frontRightAngle.toInt()} dB",
              onFrontRightTurned: (newAngle, _) {
                setModalState(() => _frontRightAngle = newAngle);
                setState(() => _frontRightAngle = newAngle);
              },
              centerAngle: _centerAngle,
              centerText: "${_centerAngle.toInt()} dB",
              onCenterTurned: (newAngle, _) {
                setModalState(() => _centerAngle = newAngle);
                setState(() => _centerAngle = newAngle);
              },
              rearLeftAngle: _rearLeftAngle,
              rearLeftText: "${_rearLeftAngle.toInt()} dB",
              onRearLeftTurned: (newAngle, _) {
                setModalState(() => _rearLeftAngle = newAngle);
                setState(() => _rearLeftAngle = newAngle);
              },
              rearRightAngle: _rearRightAngle,
              rearRightText: "${_rearRightAngle.toInt()} dB",
              onRearRightTurned: (newAngle, _) {
                setModalState(() => _rearRightAngle = newAngle);
                setState(() => _rearRightAngle = newAngle);
              },
            );
          },
        );
      },
    );
  }

  void _onOpenPresets() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const PresetModal(),
    );
  }

  void _onOpenRemote() {
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

  Widget _buildChild() {
    switch (_selectedIndex) {
      case 0:
        return DeviceConnectScreen(
          availableDevices: _availableDevices,
          activeMode: _connectionMode,
          isScanning: false,
          onModeChanged: (mode) {
            setState(() {
              _connectionMode = mode;
            });
          },
          onDeviceSelected: (device) {},
          // TODO: Refactor DeviceInfo state and network metadata to listen to WaveOneBloc.
          onOpenInfo: () {
            showDialog(
              context: context,
              builder: (context) => const DeviceInfoModal(),
            );
          },
          onOpenHelp: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => const HelpModal(),
            );
          },
        );
      case 1:
        return ControlDashboardView(
          activeMode: _activeMode,
          isModeExpanded: _isModeExpanded,
          mainVolAngle: _mainVolAngle,
          mainVolText: _mainVolAngle.toInt().toString(),
          subVolAngle: _subVolAngle,
          subVolText: _subVolAngle.toInt().toString(),
          onMainVolTurned: (newAngle, newIndex) {
            setState(() {
              _mainVolAngle = newAngle;
            });
          },
          onSubVolTurned: (newAngle, newIndex) {
            setState(() {
              _subVolAngle = newAngle;
            });
          },
          onModeSelected: (mode) {
            setState(() {
              _activeMode = mode;
              _isModeExpanded = false;
            });
          },
          onToggleModeExpand: () {
            setState(() {
              _isModeExpanded = !_isModeExpanded;
            });
          },
          onOpenAttenuation: _onOpenAttenuation,
          onOpenPresets: _onOpenPresets,
          onOpenRemote: _onOpenRemote,
        );
      case 2:
        return Container(child: const Center(child: Text('DSP View')));
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainNavigationShell(
      selectedIndex: _selectedIndex,
      onTabSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: _buildChild(),
    );
  }
}
