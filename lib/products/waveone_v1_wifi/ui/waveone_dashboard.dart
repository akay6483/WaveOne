import 'package:flutter/material.dart';
import 'package:waveone/core/theme/app_theme.dart';
import 'package:waveone/core/widgets/Knob.dart';
import 'package:waveone/core/widgets/mode_selector.dart';

class WaveOneDashboard extends StatefulWidget {
  const WaveOneDashboard({super.key});

  @override
  State<WaveOneDashboard> createState() => _WaveOneDashboardState();
}

class _WaveOneDashboardState extends State<WaveOneDashboard> {
  // State variables for active mode and knob angle
  // TODO: Refactor to BlocBuilder
  String _activeMode = 'AUX1';
  bool _isModeExpanded = true;
  double _mainVolAngle = 225.0; // Start at min angle (225 degrees)

  int _getVolumePercentage(double angle) {
    final relativeAngle = (angle - 225 + 360) % 360;
    final percent = (relativeAngle / 270.0).clamp(0.0, 1.0);
    return (percent * 100).round();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final themeColors = Theme.of(context).colorScheme;
    final mediaQuery = MediaQuery.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Constrain the knob size to roughly 50% of the screen width (min/max bounds for safety)
    final double knobSize = (mediaQuery.size.width * 0.5).clamp(150.0, 300.0);

    return Scaffold(
      backgroundColor: themeColors.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('WaveOne V1'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.power_settings_new),
            color: Colors.redAccent,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Powering off device...')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // Top Section (Main Volume Knob)
              Center(
                child: SizedBox(
                  width: knobSize + 40,
                  child: Knob(
                    size: knobSize,
                    label: 'Volume',
                    valueText: '${_getVolumePercentage(_mainVolAngle)}%',
                    currentAngle: _mainVolAngle,
                    isDarkTheme: isDark,
                    iconColor: themeColors.primary,
                    textMutedColor: colors.textMuted,
                    onKnobTurned: (newAngle, newIndex) {
                      setState(() {
                        // TODO: Refactor to BlocBuilder
                        _mainVolAngle = newAngle;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Middle Section (Status)
              Text(
                'Current Input: $_activeMode',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: colors.textMuted,
                ),
              ),

              const SizedBox(height: 40),

              // Bottom Section (Mode Selectors)
              // Wrap the ModeSelector in a constrained box to fit layout nicely
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: ModeSelector(
                  currentMode: _activeMode,
                  isExpanded: _isModeExpanded,
                  onModeSelected: (mode) {
                    setState(() {
                      // TODO: Refactor to BlocBuilder
                      _activeMode = mode;
                    });
                  },
                  onToggleExpand: () {
                    setState(() {
                      _isModeExpanded = !_isModeExpanded;
                    });
                  },
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
