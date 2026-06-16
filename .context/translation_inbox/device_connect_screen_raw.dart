import 'package:flutter/material.dart';
import 'package:waveone_app/core/theme/app_theme.dart';

// Pure UI Data Model
class DeviceUIModel {
  final String id;
  final String modelName;
  final String deviceCode;
  final String ipAddress;
  final bool isConnected;

  const DeviceUIModel({
    required this.id,
    required this.modelName,
    required this.deviceCode,
    required this.ipAddress,
    required this.isConnected,
  });
}

enum ConnectionMode { wifi, bluetooth }

class DeviceConnectScreen extends StatelessWidget {
  final List<DeviceUIModel> availableDevices;
  final ConnectionMode activeMode;
  final bool isScanning;
  
  // Callbacks
  final ValueChanged<ConnectionMode> onModeChanged;
  final ValueChanged<DeviceUIModel> onDeviceSelected;
  final VoidCallback onOpenInfo;
  final VoidCallback onOpenHelp;

  const DeviceConnectScreen({
    super.key,
    required this.availableDevices,
    required this.activeMode,
    required this.isScanning,
    required this.onModeChanged,
    required this.onDeviceSelected,
    required this.onOpenInfo,
    required this.onOpenHelp,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final themeColors = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header ---
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Discover",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: themeColors.onSurface,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.info_outline, color: themeColors.onSurface),
                        onPressed: onOpenInfo,
                      ),
                      IconButton(
                        icon: Icon(Icons.help_outline, color: themeColors.onSurface),
                        onPressed: onOpenHelp,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // --- Connection Toggle (Wifi/Bluetooth) ---
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  _buildToggleTab(ConnectionMode.wifi, Icons.wifi, "Wi-Fi", themeColors, colors),
                  _buildToggleTab(ConnectionMode.bluetooth, Icons.bluetooth, "Bluetooth", themeColors, colors),
                ],
              ),
            ),

            Text(
              "Available Devices",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: themeColors.onSurface),
            ),
            const SizedBox(height: 10),

            // --- Device List ---
            Expanded(
              child: isScanning && availableDevices.isEmpty
                  ? Center(child: CircularProgressIndicator(color: themeColors.primary))
                  : availableDevices.isEmpty
                      ? Center(
                          child: Text(
                            "No devices found.",
                            style: TextStyle(color: colors.textMuted, fontSize: 16),
                          ),
                        )
                      : ListView.builder(
                          itemCount: availableDevices.length,
                          itemBuilder: (context, index) {
                            final device = availableDevices[index];
                            return _buildDeviceCard(device, themeColors, colors);
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleTab(ConnectionMode mode, IconData icon, String label, ColorScheme themeColors, AppColorsExtension colors) {
    final isActive = activeMode == mode;
    return Expanded(
      child: GestureDetector(
        onTap: () => onModeChanged(mode),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? themeColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: isActive ? themeColors.onPrimary : colors.inactiveTint),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive ? themeColors.onPrimary : colors.inactiveTint,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceCard(DeviceUIModel device, ColorScheme themeColors, AppColorsExtension colors) {
    // Select image based on model (simulating the React Native require logic)
    final imagePath = device.modelName.toLowerCase().contains('pv') 
        ? 'assets/images/splash-icon.png' 
        : 'assets/images/favicon.png';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: themeColors.surface, // Background card
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: themeColors.surfaceContainerHighest),
      ),
      child: InkWell(
        onTap: () => onDeviceSelected(device),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              Image.asset(imagePath, width: 40, height: 40, fit: BoxFit.contain),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      device.modelName,
                      style: TextStyle(color: themeColors.onSurface, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "${device.deviceCode} • ${device.ipAddress}",
                      style: TextStyle(color: colors.textMuted, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Icon(
                device.isConnected ? Icons.check_circle : Icons.chevron_right,
                color: device.isConnected ? Colors.green : colors.inactiveTint,
              ),
            ],
          ),
        ),
      ),
    );
  }
}