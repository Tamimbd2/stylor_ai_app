import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/primary_button.dart';
import '../../filterScreen/views/filter_screen_view.dart';
import '../controllers/personalize_controller.dart';

class PersonalizeView extends GetView<PersonalizeController> {
  PersonalizeView({super.key});
  final PersonalizeController controller = Get.put(PersonalizeController());

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
                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          _showDatePicker(context);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 48,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
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
                              Text(
                                controller.getFormattedDate(),
                                style: const TextStyle(
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
                    Obx(
                      () => Row(
                        children: [
                          Expanded(
                            child: _GenderButton(
                              label: 'Male',
                              iconPath: 'assets/icons/male.png',
                              isSelected:
                                  controller.selectedGender.value == 'Male',
                              onTap: () {
                                controller.selectedGender.value = 'Male';
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _GenderButton(
                              label: 'Female',
                              iconPath: 'assets/icons/female.png',
                              isSelected:
                                  controller.selectedGender.value == 'Female',
                              onTap: () {
                                controller.selectedGender.value = 'Female';
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _GenderButton(
                              label: 'Other',
                              iconPath: 'assets/icons/others.png',
                              isSelected:
                                  controller.selectedGender.value == 'Other',
                              onTap: () {
                                controller.selectedGender.value = 'Other';
                              },
                            ),
                          ),
                        ],
                      ),
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
                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          _showCountryDropdown(context);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 48,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
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
                              Text(
                                controller.getCountryFlag(
                                  controller.selectedCountry.value ?? '',
                                ),
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  controller.selectedCountry.value ??
                                      'Select Country',
                                  style: const TextStyle(
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FilterScreenView(),
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

  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: controller.selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF060017),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF1C1C1E),
            ),
          ),
          child: child!,
        );
      },
    ).then((pickedDate) {
      if (pickedDate != null) {
        controller.selectedDate.value = pickedDate;
      }
    });
  }

  void _showCountryDropdown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 400,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Select Country',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.countries.length,
                  itemBuilder: (context, index) {
                    final country = controller.countries[index];
                    final isSelected =
                        controller.selectedCountry.value == country;
                    return ListTile(
                      leading: Text(
                        controller.getCountryFlag(country),
                        style: const TextStyle(fontSize: 20),
                      ),
                      title: Text(
                        country,
                        style: TextStyle(
                          color: isSelected
                              ? const Color(0xFF060017)
                              : const Color(0xFF49494B),
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      onTap: () {
                        controller.selectedCountry.value = country;
                        Navigator.pop(context);
                      },
                      trailing: isSelected
                          ? const Icon(
                              Icons.check,
                              color: Color(0xFF060017),
                              size: 20,
                            )
                          : null,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GenderButton extends StatelessWidget {
  final String label;
  final String iconPath;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderButton({
    required this.label,
    required this.iconPath,
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
            color: isSelected
                ? const Color(0xFF060017)
                : const Color(0xFFE8E8E8),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: 20,
              height: 20,
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
