import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/primary_button.dart';
import '../../shapeselect/views/shapeselect_view.dart';
import '../controllers/filter_screen_controller.dart';

class FilterScreenView extends GetView<FilterScreenController> {
  const FilterScreenView({super.key});

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
                Image.asset(
                  'assets/logo/logo.png',
                  height: 60,
                ),
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
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _FilterChip(label: 'Spring', isSelected: true),
                    _FilterChip(label: 'Summer', isSelected: false),
                    _FilterChip(label: 'Winter', isSelected: false),
                    _FilterChip(label: 'Autumn', isSelected: false),
                  ],
                ),
                const SizedBox(height: 24),
                // Style Section
                _buildSectionTitle('Style'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _FilterChip(label: 'Casual', isSelected: false),
                    _FilterChip(label: 'Smart Casual', isSelected: true),
                    _FilterChip(label: 'Formal', isSelected: false),
                    _FilterChip(label: 'Streetwear', isSelected: false),
                    _FilterChip(label: 'Minimalist', isSelected: false),
                    _FilterChip(label: 'Party', isSelected: false),
                    _FilterChip(label: 'Artistic', isSelected: false),
                    _FilterChip(label: 'Vintage', isSelected: false),
                    _FilterChip(label: 'Sporty', isSelected: false),
                  ],
                ),
                const SizedBox(height: 24),
                // Preferences Color Section
                _buildSectionTitle('Preferences Color'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _FilterChip(label: 'Neutrals', isSelected: true),
                    _FilterChip(label: 'Warm Tones', isSelected: false),
                    _FilterChip(label: 'Cool Tones', isSelected: false),
                    _FilterChip(label: 'Earthy Tones', isSelected: false),
                    _FilterChip(label: 'Pastels', isSelected: false),
                    _FilterChip(label: 'Vibrant', isSelected: false),
                    _FilterChip(label: 'Monochrome', isSelected: false),
                    _FilterChip(label: 'Jewel Tones', isSelected: false),
                    _FilterChip(label: 'Metallics', isSelected: false),
                  ],
                ),
                const SizedBox(height: 24),
                // Body Type Section
                _buildSectionTitle('Body Type'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _FilterChip(label: 'Curvy', isSelected: false),
                    _FilterChip(label: 'Athletic', isSelected: true),
                    _FilterChip(label: 'Slim', isSelected: false),
                    _FilterChip(label: 'Pear', isSelected: false),
                    _FilterChip(label: 'Rectangle', isSelected: false),
                    _FilterChip(label: 'Round', isSelected: false),
                  ],
                ),
                const SizedBox(height: 24),
                // Skin Tone Section
                _buildSectionTitle('Skin Tone'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _FilterChip(label: 'Fair', isSelected: false),
                    _FilterChip(label: 'Light-Medium', isSelected: true),
                    _FilterChip(label: 'Medium', isSelected: false),
                    _FilterChip(label: 'Dark', isSelected: false),
                    _FilterChip(label: 'Medium-Dark', isSelected: false),
                  ],
                ),
                const SizedBox(height: 40),
                // See Outfit Matches Button
                AppButton(
                  text: "See Outfit Matches",
                  textColor: Colors.white,
                  backgroundColor: const Color(0xFF060017),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ShapeselectView()));
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

  const _FilterChip({
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle selection
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF060017) : const Color(0xFFE8E8E8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF1C1C1E),
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            height: 1.56,
          ),
        ),
      ),
    );
  }
}

