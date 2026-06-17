import 'package:flutter/material.dart';
import 'package:waveone/core/theme/app_theme.dart';

enum RemoteButtonType { defaultBtn, red, blue, purple }

class RemoteModal extends StatefulWidget {
  final VoidCallback onPower;
  final VoidCallback onMute;
  final VoidCallback onSetup;
  final VoidCallback onVolUp;
  final VoidCallback onVolDown;
  final VoidCallback onPlayPause;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final VoidCallback onEq;
  final VoidCallback onRpt;
  final VoidCallback onUsd;
  final VoidCallback onDigit0;
  final VoidCallback onDigit1;
  final VoidCallback onDigit2;
  final VoidCallback onDigit3;
  final VoidCallback onDigit4;
  final VoidCallback onDigit5;
  final VoidCallback onDigit6;
  final VoidCallback onDigit7;
  final VoidCallback onDigit8;
  final VoidCallback onDigit9;

  const RemoteModal({
    super.key,
    required this.onPower,
    required this.onMute,
    required this.onSetup,
    required this.onVolUp,
    required this.onVolDown,
    required this.onPlayPause,
    required this.onPrev,
    required this.onNext,
    required this.onEq,
    required this.onRpt,
    required this.onUsd,
    required this.onDigit0,
    required this.onDigit1,
    required this.onDigit2,
    required this.onDigit3,
    required this.onDigit4,
    required this.onDigit5,
    required this.onDigit6,
    required this.onDigit7,
    required this.onDigit8,
    required this.onDigit9,
  });

  @override
  State<RemoteModal> createState() => _RemoteModalState();
}

class _RemoteModalState extends State<RemoteModal> {
  // TODO: Refactor remote hardware commands and state to map to WaveOneBloc events.
  bool _isPowerOn = false;
  // TODO: Refactor remote hardware commands and state to map to WaveOneBloc events.
  bool _isMuted = false;
  // TODO: Refactor remote hardware commands and state to map to WaveOneBloc events.
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColorsExtension>()!;
    final themeColors = theme.colorScheme;
    final hardwareTheme = theme.extension<HardwarePanelTheme>()!;

    return Container(
      decoration: BoxDecoration(
        color: colors.remoteModalBg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        border: Border(
          top: BorderSide(color: hardwareTheme.borderColor, width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // --- Header ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.settings_remote,
                      color: themeColors.onSurface,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Remote",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: themeColors.onSurface,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.close, color: themeColors.onSurface, size: 24),
                      onPressed: () => Navigator.of(context).pop(),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // --- Grid Container ---
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 20,
            runSpacing: 10,
            children: [
              // --- ROW 1 ---
              _RemoteButton(
                label: "Power",
                icon: Icons.power_settings_new,
                type: RemoteButtonType.red,
                textColor: colors.remotePowerText,
                onPress: () {
                  setState(() => _isPowerOn = !_isPowerOn);
                  widget.onPower();
                },
              ),
              _RemoteButton(
                label: "Mute",
                icon: _isMuted ? Icons.volume_off : Icons.volume_up,
                type: RemoteButtonType.defaultBtn,
                textColor: colors.remoteButtonText,
                onPress: () {
                  setState(() => _isMuted = !_isMuted);
                  widget.onMute();
                },
              ),
              _RemoteButton(
                label: "Setup",
                icon: Icons.settings,
                type: RemoteButtonType.purple,
                textColor: colors.remoteButtonText,
                onPress: widget.onSetup,
              ),

              // --- ROW 2 ---
              _RemoteButton(
                label: "Vol +",
                icon: Icons.volume_up,
                type: RemoteButtonType.defaultBtn,
                textColor: colors.remoteButtonText,
                onPress: widget.onVolUp,
              ),
              _RemoteButton(
                label: _isPlaying ? "Pause" : "Play",
                icon: _isPlaying ? Icons.pause : Icons.play_arrow,
                type: RemoteButtonType.blue,
                textColor: colors.remotePlayText,
                onPress: () {
                  setState(() => _isPlaying = !_isPlaying);
                  widget.onPlayPause();
                },
              ),
              _RemoteButton(
                label: "Vol -",
                icon: Icons.volume_down,
                type: RemoteButtonType.defaultBtn,
                textColor: colors.remoteButtonText,
                onPress: widget.onVolDown,
              ),

              // --- ROW 3 ---
              _RemoteButton(
                label: "Prev",
                icon: Icons.skip_previous,
                type: RemoteButtonType.defaultBtn,
                textColor: colors.remoteButtonText,
                onPress: widget.onPrev,
              ),
              _RemoteButton(
                label: "EQ",
                icon: Icons.equalizer,
                type: RemoteButtonType.purple,
                textColor: colors.remoteEqText,
                onPress: widget.onEq,
              ),
              _RemoteButton(
                label: "Next",
                icon: Icons.skip_next,
                type: RemoteButtonType.defaultBtn,
                textColor: colors.remoteButtonText,
                onPress: widget.onNext,
              ),

              // --- ROW 4 ---
              _RemoteButton(
                label: "RPT",
                type: RemoteButtonType.defaultBtn,
                textColor: colors.remoteButtonText,
                onPress: widget.onRpt,
              ),
              _RemoteButton(
                label: "U/SD",
                type: RemoteButtonType.defaultBtn,
                textColor: colors.remoteButtonText,
                onPress: widget.onUsd,
              ),
              _RemoteButton(
                label: "0",
                type: RemoteButtonType.defaultBtn,
                textColor: colors.remoteButtonText,
                onPress: widget.onDigit0,
              ),

              // --- ROW 5 ---
              _RemoteButton(
                label: "1",
                type: RemoteButtonType.defaultBtn,
                textColor: colors.remoteButtonText,
                onPress: widget.onDigit1,
              ),
              _RemoteButton(
                label: "2",
                type: RemoteButtonType.defaultBtn,
                textColor: colors.remoteButtonText,
                onPress: widget.onDigit2,
              ),
              _RemoteButton(
                label: "3",
                type: RemoteButtonType.defaultBtn,
                textColor: colors.remoteButtonText,
                onPress: widget.onDigit3,
              ),

              // --- ROW 6 ---
              _RemoteButton(
                label: "4",
                type: RemoteButtonType.defaultBtn,
                textColor: colors.remoteButtonText,
                onPress: widget.onDigit4,
              ),
              _RemoteButton(
                label: "5",
                type: RemoteButtonType.defaultBtn,
                textColor: colors.remoteButtonText,
                onPress: widget.onDigit5,
              ),
              _RemoteButton(
                label: "6",
                type: RemoteButtonType.defaultBtn,
                textColor: colors.remoteButtonText,
                onPress: widget.onDigit6,
              ),

              // --- ROW 7 ---
              _RemoteButton(
                label: "7",
                type: RemoteButtonType.defaultBtn,
                textColor: colors.remoteButtonText,
                onPress: widget.onDigit7,
              ),
              _RemoteButton(
                label: "8",
                type: RemoteButtonType.defaultBtn,
                textColor: colors.remoteButtonText,
                onPress: widget.onDigit8,
              ),
              _RemoteButton(
                label: "9",
                type: RemoteButtonType.defaultBtn,
                textColor: colors.remoteButtonText,
                onPress: widget.onDigit9,
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _RemoteButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final RemoteButtonType type;
  final Color textColor;
  final VoidCallback onPress;

  const _RemoteButton({
    required this.label,
    this.icon,
    required this.type,
    required this.textColor,
    required this.onPress,
  });

  String _getAssetPath() {
    switch (type) {
      case RemoteButtonType.red:
        return 'assets/images/button-red.png';
      case RemoteButtonType.blue:
        return 'assets/images/button-blue.png';
      case RemoteButtonType.purple:
        return 'assets/images/button-purple.png';
      case RemoteButtonType.defaultBtn:
        return 'assets/images/button-default.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    _getAssetPath(),
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                  if (icon != null)
                    Icon(icon, color: Colors.white, size: 32)
                  else
                    Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
            if (icon != null) ...[
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ] else ...[
              const SizedBox(height: 8),
              const Text("", style: TextStyle(fontSize: 14)),
            ],
          ],
        ),
      ),
    );
  }
}
