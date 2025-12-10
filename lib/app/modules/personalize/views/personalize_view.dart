import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/primary_button.dart';
import '../../filterScreen/views/filter_screen_view.dart';
import '../controllers/personalize_controller.dart';

class PersonalizeView extends GetView<PersonalizeController> {
  const PersonalizeView({super.key});

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
                // Greeting
                const Text(
                  'Hi David',
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
                  'Lets personalize your AI outfit experience!',
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
                // Birth Of Date
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Birth Of Date',
                      style: TextStyle(
                        color: Color(0xFF1C1C1E),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 1.56,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      height: 48,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 1,
                          color: const Color(0xFFE8E8E8),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            size: 20,
                            color: Color(0xFF49494B),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '22 / 04 / 2000',
                            style: TextStyle(
                              color: Color(0xFF49494B),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 1.56,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Gender
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gender',
                      style: TextStyle(
                        color: Color(0xFF1C1C1E),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 1.56,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: _GenderButton(
                            label: 'Male',
                            icon: Icons.male,
                            isSelected: true,
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _GenderButton(
                            label: 'Female',
                            icon: Icons.female,
                            isSelected: false,
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _GenderButton(
                            label: 'Other',
                            icon: Icons.transgender,
                            isSelected: false,
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Country
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Country',
                      style: TextStyle(
                        color: Color(0xFF1C1C1E),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 1.56,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      height: 48,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 1,
                          color: const Color(0xFFE8E8E8),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Text(
                            '🇧🇪',
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              'Belgium',
                              style: TextStyle(
                                color: Color(0xFF49494B),
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 1.56,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            size: 16,
                            color: Color(0xFF49494B),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 200),
                // Next Button
                AppButton(
                  text: "Next",
                  textColor: Colors.white,
                  backgroundColor: const Color(0xFF060017),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> FilterScreenView()));
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
}

class _GenderButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF060017) : Colors.white,
          border: Border.all(
            width: 1,
            color: isSelected ? const Color(0xFF060017) : const Color(0xFFE8E8E8),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? Colors.white : const Color(0xFF49494B),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF49494B),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 1.56,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

