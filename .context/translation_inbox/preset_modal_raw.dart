import 'package:flutter/material.dart';
import 'package:waveone_app/core/theme/app_theme.dart'; // Adjust based on your path

// --- Decoupled Data Models ---
enum PresetTab { load, save, delete }

class PresetData {
  final int id;
  final String name;
  final dynamic presetValues; // The parent BLoC will strictly type this

  const PresetData({
    required this.id,
    required this.name,
    this.presetValues,
  });
}

class PresetModal extends StatelessWidget {
  // --- UI State & Data ---
  final bool visible;
  final PresetTab activeTab;
  final List<PresetData> presets;
  final TextEditingController presetNameController;

  // --- Callbacks ---
  final VoidCallback onClose;
  final ValueChanged<PresetTab> onTabChanged;
  final VoidCallback onSavePreset;
  final ValueChanged<PresetData> onLoadPreset;
  final ValueChanged<PresetData> onDeletePreset;

  const PresetModal({
    super.key,
    required this.visible,
    required this.activeTab,
    required this.presets,
    required this.presetNameController,
    required this.onClose,
    required this.onTabChanged,
    required this.onSavePreset,
    required this.onLoadPreset,
    required this.onDeletePreset,
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();

    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final themeColors = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      color: colors.modalOverlay,
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        bottom: false,
        child: Container(
          height: screenHeight * 0.8, // 80% of screen height
          decoration: BoxDecoration(
            color: colors.modalBackground,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // --- Header ---
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.settings_input_component, size: 24, color: themeColors.onSurface),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Presets",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: themeColors.onSurface,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(Icons.close, size: 26, color: themeColors.onSurface),
                          onPressed: onClose,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // --- Tabs ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    _buildTab(PresetTab.load, Icons.download, "Load", themeColors, colors),
                    const SizedBox(width: 10),
                    _buildTab(PresetTab.save, Icons.save, "Save", themeColors, colors),
                    const SizedBox(width: 10),
                    _buildTab(PresetTab.delete, Icons.delete_outline, "Delete", themeColors, colors),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // --- Save Input Area ---
              if (activeTab == PresetTab.save)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: presetNameController,
                          style: TextStyle(color: themeColors.onSurface, fontSize: 16),
                          decoration: InputDecoration(
                            hintText: "Enter preset name...",
                            hintStyle: TextStyle(color: colors.textMuted),
                            filled: true,
                            fillColor: themeColors.surface,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: themeColors.surfaceContainerHighest),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: themeColors.primary),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: onSavePreset,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeColors.primary,
                          padding: const EdgeInsets.all(14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          elevation: 0,
                        ),
                        child: Icon(Icons.check, color: themeColors.onPrimary, size: 24),
                      ),
                    ],
                  ),
                ),

              // --- Preset List ---
              Expanded(
                child: presets.isEmpty
                    ? Center(
                        child: Text(
                          "No presets found.",
                          style: TextStyle(color: colors.textMuted, fontSize: 16),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.only(top: 10, bottom: 40),
                        itemCount: presets.length,
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                          color: themeColors.surfaceContainerHighest,
                        ),
                        itemBuilder: (context, index) {
                          final preset = presets[index];
                          return InkWell(
                            onTap: () {
                              if (activeTab == PresetTab.load) onLoadPreset(preset);
                              if (activeTab == PresetTab.delete) onDeletePreset(preset);
                              // Tapping does nothing in save mode in original RN app
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 26),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    preset.name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: themeColors.onSurface,
                                    ),
                                  ),
                                  if (activeTab == PresetTab.load)
                                    Icon(Icons.download, color: themeColors.primary, size: 20),
                                  if (activeTab == PresetTab.delete)
                                    Icon(Icons.delete, color: themeColors.error, size: 20),
                                ],
                              ),
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

  // Helper widget to build the tabs
  Widget _buildTab(
    PresetTab tab,
    IconData icon,
    String label,
    ColorScheme themeColors,
    AppColorsExtension colors,
  ) {
    final isActive = activeTab == tab;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabChanged(tab),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? themeColors.primary.withOpacity(0.1) : themeColors.surfaceContainerHighest.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isActive ? themeColors.primary : Colors.transparent,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Icon(icon, color: isActive ? themeColors.primary : colors.textMuted, size: 20),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isActive ? themeColors.primary : colors.textMuted,
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}