import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/language_controller.dart';

class LanguageView extends GetView<LanguageController> {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F9F9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF1C1C1E),
          ),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Language',
          style: TextStyle(
            color: Color(0xFF1C1C1E),
            fontSize: 24,
            fontFamily: 'Helvetica Neue',
            fontWeight: FontWeight.w700,
            height: 1.40,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 32),
              // English Option (Selected)
              _buildLanguageOption(
                language: 'English',
                isSelected: true,
              ),
              const SizedBox(height: 16),
              // Dutch Option
              _buildLanguageOption(
                language: 'Dutch',
                isSelected: false,
              ),
              const SizedBox(height: 16),
              // French Option
              _buildLanguageOption(
                language: 'French',
                isSelected: false,
              ),
              const SizedBox(height: 24),
              // Info Text
              const Text(
                'Changing the language will restart the app',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF49494B),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 1.67,
                ),
              ),
              const Spacer(),
              // Save Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF060017),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Save as',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Helvetica Neue',
                      fontWeight: FontWeight.w700,
                      height: 1.40,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption({
    required String language,
    required bool isSelected,
  }) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFF060017).withOpacity(0.1)
            : Colors.white,
        border: Border.all(
          width: 1,
          color: isSelected
              ? const Color(0xFF060017)
              : const Color(0xFFE8E8E8),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              language,
              style: const TextStyle(
                color: Color(0xFF49494B),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.56,
              ),
            ),
            if (isSelected)
              Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  color: Color(0xFF060017),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 12,
                ),
              )
            else
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFE8E8E8),
                    width: 1.5,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}