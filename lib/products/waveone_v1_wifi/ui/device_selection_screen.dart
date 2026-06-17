import 'package:flutter/material.dart';
import 'package:waveone/core/theme/app_theme.dart';
import 'package:waveone/core/widgets/global_drawer.dart';
import 'package:waveone/products/waveone_v1_wifi/ui/waveone_dashboard.dart';

class DeviceSelectionScreen extends StatelessWidget {
  const DeviceSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final themeColors = Theme.of(context).colorScheme;
    final ledColors = Theme.of(context).extension<LedColors>()!;

    return Scaffold(
      backgroundColor: themeColors.surface,
      appBar: AppBar(
        title: const Text('My Devices'),
        centerTitle: false,
        automaticallyImplyLeading: false, // Ensure no back button/leading icon
      ),
      endDrawer: const GlobalDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Search for new devices...')),
          );
        },
        backgroundColor: themeColors.primary,
        child: Icon(Icons.add, color: themeColors.onPrimary),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: 2,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          if (index == 0) {
            // Connected device card
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: themeColors.surfaceContainerHighest,
                  width: 1,
                ),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading: Icon(Icons.wifi, size: 36, color: themeColors.primary),
                title: Text(
                  'WaveOne V1',
                  style: TextStyle(
                    color: themeColors.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  'Connected',
                  style: TextStyle(color: colors.textMuted, fontSize: 14),
                ),
                trailing: Icon(Icons.circle, size: 12, color: ledColors.green),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WaveOneDashboard(),
                    ),
                  );
                },
              ),
            );
          } else {
            // Disconnected device card
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: themeColors.surfaceContainerHighest,
                  width: 1,
                ),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading: Icon(
                  Icons.speaker,
                  size: 36,
                  color: colors.inactiveTint,
                ),
                title: Text(
                  'PV Acoustics 2.1',
                  style: TextStyle(
                    color: themeColors.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  'Disconnected',
                  style: TextStyle(color: colors.textMuted, fontSize: 14),
                ),
                trailing: Icon(
                  Icons.circle,
                  size: 12,
                  color: colors.inactiveTint,
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Device is currently offline.'),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
