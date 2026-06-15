import 'package:flutter/material.dart';
import 'core/locator/locator_setup.dart';
import 'core/theme/app_theme.dart';
import 'core/ui/screens/product_selection_screen.dart';

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
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const ProductSelectionScreen(),
    );
  }
}
