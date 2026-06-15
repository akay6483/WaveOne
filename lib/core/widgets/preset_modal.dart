import 'package:flutter/material.dart';
import 'package:waveone/core/theme/app_theme.dart';
import 'package:waveone/core/widgets/confirmation_modal.dart';

// --- Decoupled Data Models ---
enum PresetTab { load, save, delete }

class PresetData {
  final int id;
  final String name;
  final dynamic presetValues; // The parent BLoC will strictly type this

  const PresetData({required this.id, required this.name, this.presetValues});
}

class PresetModal extends StatefulWidget {
  const PresetModal({super.key});

  @override
  State<PresetModal> createState() => _PresetModalState();
}

class _PresetModalState extends State<PresetModal> {
  // --- UI State & Mock Data ---
  // TODO: Refactor preset list state and active preset to be injected via BlocBuilder.
  PresetTab _activeTab = PresetTab.load;
  final List<PresetData> _presets = [
    const PresetData(id: 1, name: "Studio Reference"),
    const PresetData(id: 2, name: "Bass Boost"),
    const PresetData(id: 3, name: "Vocal Clarity"),
    const PresetData(id: 4, name: "Night Mode"),
  ];
  final TextEditingController _presetNameController = TextEditingController();

  @override
  void dispose() {
    _presetNameController.dispose();
    super.dispose();
  }

  void _onTabChanged(PresetTab tab) {
    setState(() {
      _activeTab = tab;
    });
  }

  void _handleSavePreset() {
    if (_presetNameController.text.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) => ConfirmationModal(
        title: "Overwrite Preset?",
        message: "Are you sure you want to overwrite this saved EQ curve?",
        confirmButtonLabel: "Overwrite",
        onCancel: () => Navigator.of(context).pop(),
        onConfirm: () {
          // TODO: Refactor preset save/delete confirmation logic to trigger WaveOneBloc events.
          Navigator.of(context).pop();
          _presetNameController.clear();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Preset saved (Mock)")));
        },
      ),
    );
  }

  void _handleDeletePreset(PresetData preset) {
    showDialog(
      context: context,
      builder: (context) => ConfirmationModal(
        title: "Delete Preset?",
        message: "Are you sure you want to delete '${preset.name}'?",
        confirmButtonLabel: "Delete",
        confirmButtonColor: Theme.of(context).colorScheme.error,
        onCancel: () => Navigator.of(context).pop(),
        onConfirm: () {
          // TODO: Refactor preset save/delete confirmation logic to trigger WaveOneBloc events.
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Preset deleted (Mock)")),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final themeColors = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      decoration: BoxDecoration(
        color: colors.modalBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                      child: Icon(
                        Icons.settings_input_component,
                        size: 24,
                        color: themeColors.onSurface,
                      ),
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
                        icon: Icon(
                          Icons.close,
                          size: 26,
                          color: themeColors.onSurface,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
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
                  _buildTab(
                    PresetTab.load,
                    Icons.download,
                    "Load",
                    themeColors,
                    colors,
                  ),
                  const SizedBox(width: 10),
                  _buildTab(
                    PresetTab.save,
                    Icons.save,
                    "Save",
                    themeColors,
                    colors,
                  ),
                  const SizedBox(width: 10),
                  _buildTab(
                    PresetTab.delete,
                    Icons.delete_outline,
                    "Delete",
                    themeColors,
                    colors,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // --- Save Input Area ---
            if (_activeTab == PresetTab.save)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _presetNameController,
                        style: TextStyle(
                          color: themeColors.onSurface,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          hintText: "Enter preset name...",
                          hintStyle: TextStyle(color: colors.textMuted),
                          filled: true,
                          fillColor: themeColors.surface,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: themeColors.surfaceContainerHighest,
                            ),
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
                      onPressed: _handleSavePreset,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeColors.primary,
                        padding: const EdgeInsets.all(14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: Icon(
                        Icons.check,
                        color: themeColors.onPrimary,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),

            // --- Preset List ---
            SizedBox(
              height: screenHeight * 0.4, // Constrain height for bottom sheet
              child: _presets.isEmpty
                  ? Center(
                      child: Text(
                        "No presets found.",
                        style: TextStyle(color: colors.textMuted, fontSize: 16),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.only(top: 10, bottom: 40),
                      itemCount: _presets.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: themeColors.surfaceContainerHighest,
                      ),
                      itemBuilder: (context, index) {
                        final preset = _presets[index];
                        return InkWell(
                          onTap: () {
                            if (_activeTab == PresetTab.load) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Loaded ${preset.name}"),
                                ),
                              );
                              Navigator.of(context).pop();
                            }
                            if (_activeTab == PresetTab.delete) {
                              _handleDeletePreset(preset);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 26,
                            ),
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
                                if (_activeTab == PresetTab.load)
                                  Icon(
                                    Icons.download,
                                    color: themeColors.primary,
                                    size: 20,
                                  ),
                                if (_activeTab == PresetTab.delete)
                                  Icon(
                                    Icons.delete,
                                    color: themeColors.error,
                                    size: 20,
                                  ),
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
    final isActive = _activeTab == tab;
    return Expanded(
      child: GestureDetector(
        onTap: () => _onTabChanged(tab),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive
                ? themeColors.primary.withOpacity(0.1)
                : themeColors.surfaceContainerHighest.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isActive ? themeColors.primary : Colors.transparent,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isActive ? themeColors.primary : colors.textMuted,
                size: 20,
              ),
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
