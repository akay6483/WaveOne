import 'package:flutter/material.dart';
import 'package:waveone_app/core/theme/app_theme.dart';

class SupportPage extends StatelessWidget {
  final VoidCallback onContactSupport;
  final VoidCallback onReportIssue;

  const SupportPage({
    super.key,
    required this.onContactSupport,
    required this.onReportIssue,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final themeColors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: themeColors.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                "Get Help",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: themeColors.onSurface),
              ),
            ),
            
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildRow(Icons.mail_outline, "Contact Support", themeColors, colors, onContactSupport),
                  Divider(height: 1, color: themeColors.surfaceContainerHighest),
                  _buildRow(Icons.bug_report_outlined, "Report an Issue", themeColors, colors, onReportIssue),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            Center(
              child: Text(
                "We typically respond within 24-48 hours.",
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: colors.textMuted),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(IconData icon, String label, ColorScheme themeColors, AppColorsExtension colors, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          children: [
            Icon(icon, size: 22, color: themeColors.onSurface),
            const SizedBox(width: 16),
            Expanded(
              child: Text(label, style: TextStyle(fontSize: 16, color: themeColors.onSurface)),
            ),
            Icon(Icons.chevron_right, size: 20, color: colors.inactiveTint),
          ],
        ),
      ),
    );
  }
}