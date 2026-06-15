import 'package:flutter/material.dart';
import 'package:waveone/core/widgets/Knob.dart';

class WaveOneDashboard extends StatefulWidget {
  const WaveOneDashboard({super.key});

  @override
  State<WaveOneDashboard> createState() => _WaveOneDashboardState();
}

class _WaveOneDashboardState extends State<WaveOneDashboard> {
  double _currentKnobValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WaveOne V1 (Testing)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _currentKnobValue.toStringAsFixed(2),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Knob(
              size: 200.0,
              label: 'Volume',
              valueText: _currentKnobValue.toStringAsFixed(2),
              currentAngle: _currentKnobValue,
              onKnobTurned: (double newAngle, int newIndex) {
                setState(() {
                  _currentKnobValue = newAngle;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
