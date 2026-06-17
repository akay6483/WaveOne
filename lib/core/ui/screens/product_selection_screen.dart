import 'package:flutter/material.dart';
import 'package:waveone/products/waveone_v1_wifi/ui/waveone_dashboard.dart';

class ProductSelectionScreen extends StatelessWidget {
  const ProductSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Device')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Card(
                elevation: 4.0,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  leading: const Icon(Icons.wifi, size: 40),
                  title: const Text(
                    'WaveOne V1 (Wi-Fi)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text('Connect to local Wi-Fi devices'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WaveOneDashboard(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
