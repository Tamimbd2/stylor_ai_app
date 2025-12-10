import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/primary_button.dart';
import '../../shapeselect/views/shapeselect_view.dart';
import '../controllers/filter_screen_controller.dart';

class FilterScreenView extends GetView<FilterScreenController> {
  FilterScreenView({super.key});
  final FilterScreenController controller = Get.put(FilterScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                // Logo
                Image.asset('assets/logo/logo.png', height: 60),
                const SizedBox(height: 40),
                // Title
                const Text(
                  'Define your fashion DNA.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF1C1C1E),
                    fontSize: 24,
                    fontFamily: 'Helvetica Neue',
                    fontWeight: FontWeight.w700,
                    height: 1.40,
                  ),
                ),
                const SizedBox(height: 10),
                // Subtitle
                const Text(
                  'Your choices shape your AI style feed.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF101C2C),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 1.56,
                  ),
                ),
                const SizedBox(height: 40),
                // Season Section
                _buildSectionTitle('Season'),
                const SizedBox(height: 8),
                Obx(
                  () => Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _FilterChip(
                        label: 'Spring',
                        isSelected: controller.selectedSeason.value == 'Spring',
                        onTap: () => controller.selectSeason('Spring'),
                      ),
                      _FilterChip(
                        label: 'Summer',
                        isSelected: controller.selectedSeason.value == 'Summer',
                        onTap: () => controller.selectSeason('Summer'),
                      ),
                      _FilterChip(
                        label: 'Winter',
                        isSelected: controller.selectedSeason.value == 'Winter',
                        onTap: () => controller.selectSeason('Winter'),
                      ),
                      _FilterChip(
                        label: 'Autumn',
                        isSelected: controller.selectedSeason.value == 'Autumn',
                        onTap: () => controller.selectSeason('Autumn'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Style Section
                _buildSectionTitle('Style'),
                const SizedBox(height: 8),
                Obx(
                  () => Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _FilterChip(
                        label: 'Casual',
                        isSelected: controller.selectedStyle.value == 'Casual',
                        onTap: () => controller.selectStyle('Casual'),
                      ),
                      _FilterChip(
                        label: 'Smart Casual',
                        isSelected:
                            controller.selectedStyle.value == 'Smart Casual',
                        onTap: () => controller.selectStyle('Smart Casual'),
                      ),
                      _FilterChip(
                        label: 'Formal',
                        isSelected: controller.selectedStyle.value == 'Formal',
                        onTap: () => controller.selectStyle('Formal'),
                      ),
                      _FilterChip(
                        label: 'Streetwear',
                        isSelected:
                            controller.selectedStyle.value == 'Streetwear',
                        onTap: () => controller.selectStyle('Streetwear'),
                      ),
                      _FilterChip(
                        label: 'Minimalist',
                        isSelected:
                            controller.selectedStyle.value == 'Minimalist',
                        onTap: () => controller.selectStyle('Minimalist'),
                      ),
                      _FilterChip(
                        label: 'Party',
                        isSelected: controller.selectedStyle.value == 'Party',
                        onTap: () => controller.selectStyle('Party'),
                      ),
                      _FilterChip(
                        label: 'Artistic',
                        isSelected:
                            controller.selectedStyle.value == 'Artistic',
                        onTap: () => controller.selectStyle('Artistic'),
                      ),
                      _FilterChip(
                        label: 'Vintage',
                        isSelected: controller.selectedStyle.value == 'Vintage',
                        onTap: () => controller.selectStyle('Vintage'),
                      ),
                      _FilterChip(
                        label: 'Sporty',
                        isSelected: controller.selectedStyle.value == 'Sporty',
                        onTap: () => controller.selectStyle('Sporty'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Preferences Color Section
                _buildSectionTitle('Preferences Color'),
                const SizedBox(height: 8),
                Obx(
                  () => Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _FilterChip(
                        label: 'Neutrals',
                        isSelected:
                            controller.selectedColor.value == 'Neutrals',
                        onTap: () => controller.selectColor('Neutrals'),
                      ),
                      _FilterChip(
                        label: 'Warm Tones',
                        isSelected:
                            controller.selectedColor.value == 'Warm Tones',
                        onTap: () => controller.selectColor('Warm Tones'),
                      ),
                      _FilterChip(
                        label: 'Cool Tones',
                        isSelected:
                            controller.selectedColor.value == 'Cool Tones',
                        onTap: () => controller.selectColor('Cool Tones'),
                      ),
                      _FilterChip(
                        label: 'Earthy Tones',
                        isSelected:
                            controller.selectedColor.value == 'Earthy Tones',
                        onTap: () => controller.selectColor('Earthy Tones'),
                      ),
                      _FilterChip(
                        label: 'Pastels',
                        isSelected: controller.selectedColor.value == 'Pastels',
                        onTap: () => controller.selectColor('Pastels'),
                      ),
                      _FilterChip(
                        label: 'Vibrant',
                        isSelected: controller.selectedColor.value == 'Vibrant',
                        onTap: () => controller.selectColor('Vibrant'),
                      ),
                      _FilterChip(
                        label: 'Monochrome',
                        isSelected:
                            controller.selectedColor.value == 'Monochrome',
                        onTap: () => controller.selectColor('Monochrome'),
                      ),
                      _FilterChip(
                        label: 'Jewel Tones',
                        isSelected:
                            controller.selectedColor.value == 'Jewel Tones',
                        onTap: () => controller.selectColor('Jewel Tones'),
                      ),
                      _FilterChip(
                        label: 'Metallics',
                        isSelected:
                            controller.selectedColor.value == 'Metallics',
                        onTap: () => controller.selectColor('Metallics'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Body Type Section
                _buildSectionTitle('Body Type'),
                const SizedBox(height: 8),
                Obx(
                  () => Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _FilterChip(
                        label: 'Curvy',
                        isSelected:
                            controller.selectedBodyType.value == 'Curvy',
                        onTap: () => controller.selectBodyType('Curvy'),
                      ),
                      _FilterChip(
                        label: 'Athletic',
                        isSelected:
                            controller.selectedBodyType.value == 'Athletic',
                        onTap: () => controller.selectBodyType('Athletic'),
                      ),
                      _FilterChip(
                        label: 'Slim',
                        isSelected: controller.selectedBodyType.value == 'Slim',
                        onTap: () => controller.selectBodyType('Slim'),
                      ),
                      _FilterChip(
                        label: 'Pear',
                        isSelected: controller.selectedBodyType.value == 'Pear',
                        onTap: () => controller.selectBodyType('Pear'),
                      ),
                      _FilterChip(
                        label: 'Rectangle',
                        isSelected:
                            controller.selectedBodyType.value == 'Rectangle',
                        onTap: () => controller.selectBodyType('Rectangle'),
                      ),
                      _FilterChip(
                        label: 'Round',
                        isSelected:
                            controller.selectedBodyType.value == 'Round',
                        onTap: () => controller.selectBodyType('Round'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Skin Tone Section
                _buildSectionTitle('Skin Tone'),
                const SizedBox(height: 8),
                Obx(
                  () => Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _FilterChip(
                        label: 'Fair',
                        isSelected: controller.selectedSkinTone.value == 'Fair',
                        onTap: () => controller.selectSkinTone('Fair'),
                      ),
                      _FilterChip(
                        label: 'Light-Medium',
                        isSelected:
                            controller.selectedSkinTone.value == 'Light-Medium',
                        onTap: () => controller.selectSkinTone('Light-Medium'),
                      ),
                      _FilterChip(
                        label: 'Medium',
                        isSelected:
                            controller.selectedSkinTone.value == 'Medium',
                        onTap: () => controller.selectSkinTone('Medium'),
                      ),
                      _FilterChip(
                        label: 'Dark',
                        isSelected: controller.selectedSkinTone.value == 'Dark',
                        onTap: () => controller.selectSkinTone('Dark'),
                      ),
                      _FilterChip(
                        label: 'Medium-Dark',
                        isSelected:
                            controller.selectedSkinTone.value == 'Medium-Dark',
                        onTap: () => controller.selectSkinTone('Medium-Dark'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                // See Outfit Matches Button
                AppButton(
                  text: "See Outfit Matches",
                  textColor: Colors.white,
                  backgroundColor: const Color(0xFF060017),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShapeselectView(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF1C1C1E),
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          height: 1.56,
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 112,
        height: 34,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF060017) : const Color(0xFFE8E8E8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF1C1C1E),
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
