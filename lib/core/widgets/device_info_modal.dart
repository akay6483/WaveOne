import 'package:flutter/material.dart';
import 'package:waveone/core/theme/app_theme.dart';

class DeviceInfoModal extends StatefulWidget {
  final String deviceName;
  final String deviceCode;
  final String deviceMode;
  final String status;
  final String wifiMode;
  final String ipAddress;
  final String password;

  final VoidCallback? onClose;

  const DeviceInfoModal({
    super.key,
    this.deviceName = 'WaveOne PV',
    this.deviceCode = 'W1-PV-1234',
    this.deviceMode = 'Standalone',
    this.status = 'Connected',
    this.wifiMode = 'Access Point',
    this.ipAddress = '192.168.1.100',
    this.password = 'admin123',
    this.onClose,
  });

  @override
  State<DeviceInfoModal> createState() => _DeviceInfoModalState();
}

class _DeviceInfoModalState extends State<DeviceInfoModal> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final themeColors = Theme.of(context).colorScheme;

    // Select image based on model
    final imagePath = widget.deviceName.toLowerCase().contains('pv')
        ? 'assets/images/splash-icon.png'
        : 'assets/images/favicon.png';

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colors.modalBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // --- Header ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 32), // Balance spacing
                  Text(
                    "Device Info",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: themeColors.onSurface,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: themeColors.onSurface),
                    onPressed:
                        widget.onClose ?? () => Navigator.of(context).pop(),
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // --- Avatar ---
              Image.asset(
                imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.contain,
              ),

              // --- Details Section ---
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Details",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: themeColors.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              _buildRow("Name", widget.deviceName, themeColors, colors),
              _buildRow("Device Mode", widget.deviceMode, themeColors, colors),
              _buildRow("Current Status", widget.status, themeColors, colors),

              // --- Network Section ---
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Network",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: themeColors.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              _buildRow("Wi-Fi Mode", widget.wifiMode, themeColors, colors),
              _buildRow("Router IP", widget.ipAddress, themeColors, colors),

              // Password Row
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Password",
                      style: TextStyle(fontSize: 16, color: colors.textMuted),
                    ),
                    Row(
                      children: [
                        Text(
                          _showPassword ? widget.password : "••••••••",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: themeColors.onSurface,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          child: Icon(
                            _showPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: themeColors.primary,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(
    String label,
    String value,
    ColorScheme themeColors,
    AppColorsExtension colors,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: themeColors.surfaceContainerHighest,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: colors.textMuted)),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: themeColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
