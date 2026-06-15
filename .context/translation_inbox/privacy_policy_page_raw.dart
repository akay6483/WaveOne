import 'package:flutter/material.dart';
import 'package:waveone_app/core/theme/app_theme.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final themeColors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: themeColors.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16).copyWith(bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Privacy Policy",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: themeColors.onSurface),
            ),
            const SizedBox(height: 8),
            Text(
              "Last updated: November 8, 2025",
              style: TextStyle(fontSize: 14, color: colors.inactiveTint, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 20),
            
            _buildParagraph("This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use AcousticsOne application.", themeColors),
            
            _buildHeading("1. Information We Collect", themeColors),
            _buildParagraph("We may collect information about you in a variety of ways. The information we may collect via the App includes:", themeColors),
            
            _buildSubHeading("Information Collected via Permissions", themeColors),
            _buildParagraph("With your permission, we may access information from your device to provide core app functionality.", themeColors),
            
            _buildListItem("Microphone", "We access the microphone...", themeColors, colors),
            
            _buildHeading("8. Contact Us", themeColors),
            _buildParagraph("If you have questions or comments about this Privacy Policy, please contact us at: pvacoustics@gmail.com", themeColors),
          ],
        ),
      ),
    );
  }

  Widget _buildHeading(String text, ColorScheme colors) => Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 8),
    child: Text(text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: colors.onSurface)),
  );

  Widget _buildSubHeading(String text, ColorScheme colors) => Padding(
    padding: const EdgeInsets.only(top: 12, bottom: 6),
    child: Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: colors.onSurface)),
  );

  Widget _buildParagraph(String text, ColorScheme colors) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(text, style: TextStyle(fontSize: 16, height: 1.5, color: colors.onSurface)),
  );

  Widget _buildListItem(String boldText, String normalText, ColorScheme themeColors, AppColorsExtension colors) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, left: 10),
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 16, height: 1.5, color: themeColors.onSurface),
          children: [
            TextSpan(text: "• "),
            TextSpan(text: "$boldText: ", style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: normalText),
          ],
        ),
      ),
    );
  }
}