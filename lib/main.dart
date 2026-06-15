import 'package:flutter/material.dart';
import 'core/locator/locator_setup.dart';
import 'core/theme/responsive_layout.dart';
import 'package:waveone/products/waveone_v1_wifi/ui/waveone_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const WaveOneApp());
}

class WaveOneApp extends StatelessWidget {
  const WaveOneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WaveOne',
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.blue),
      home: ResponsiveLayout(
        mobileBody:
            const WaveOneDashboard(), // Or whatever exact class name the CLI generated
        desktopBody: const WaveOneDashboard(),
      ),
    );
  }
}
