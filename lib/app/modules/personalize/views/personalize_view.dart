import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/color.dart';
import '../../../../widgets/primary_button.dart';
import '../../../controllers/user_controller.dart';
import '../controllers/personalize_controller.dart';

class PersonalizeView extends GetView<PersonalizeController> {
  PersonalizeView({super.key});
  @override
  final PersonalizeController controller = Get.put(PersonalizeController());

  // Get user's first name
  String _getFirstName() {
    final userController = Get.find<UserController>();
    final fullName = userController.user.value?.name ?? '';
    
    if (fullName.isEmpty) {
      return 'User';
    }
    
    // Extract first name (before first space)
    final firstName = fullName.split(' ').first;
    return firstName.isNotEmpty ? firstName : 'User';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 24.h),
                // Logo
                Image.asset('assets/logo/logo.png', height: 60.h),
                SizedBox(height: 40.h),
                // Greeting - Dynamic with user's first name
                Obx(() => Text(
                  'Hi ${_getFirstName()}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.neutral900,
                    fontSize: 24.sp,
                    fontFamily: 'Helvetica Neue',
                    fontWeight: FontWeight.w700,
                    height: 1.40,
                  ),
                )),
                SizedBox(height: 4.h),
                // Subtitle
                Text(
                  'Personalize AI Outfit Experience'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.neutral900,
                    fontSize: 14.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 1.56,
                  ),
                ),
                SizedBox(height: 40.h),
                // Birth Of Date
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Birth Of Date'.tr,
                      style: TextStyle(
                        color: AppColors.neutral900,
                        fontSize: 14.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 1.56,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          _showDatePicker(context);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 48.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: AppColors.neutral100,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.calendar_today_outlined,
                                size: 20,
                                color: AppColors.neutral700,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  controller.getFormattedDate(),
                                  style: TextStyle(
                                    color: AppColors.neutral700,
                                    fontSize: 14.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    height: 1.56,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                // Gender
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gender'.tr,
                      style: TextStyle(
                        color: AppColors.neutral900,
                        fontSize: 14.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 1.56,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Obx(
                      () => Row(
                        children: [
                          Expanded(
                            child: _GenderButton(
                              label: 'Male'.tr,
                              iconPath: 'assets/svg/male.svg',
                              isSelected:
                                  controller.selectedGender.value == 'Male',
                              onTap: () {
                                controller.selectedGender.value = 'Male';
                              },
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: _GenderButton(
                              label: 'Female'.tr,
                              iconPath: 'assets/svg/female.svg',
                              isSelected:
                                  controller.selectedGender.value == 'Female',
                              onTap: () {
                                controller.selectedGender.value = 'Female';
                              },
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: _GenderButton(
                              label: 'Other'.tr,
                              iconPath: 'assets/svg/othersgender.svg',
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
                SizedBox(height: 16.h),
                // Country
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Country'.tr,
                      style: TextStyle(
                        color: AppColors.neutral900,
                        fontSize: 14.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 1.56,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          _showCountryDropdown(context);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 48.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: AppColors.neutral100,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            children: [
                              Text(
                                controller.getCountryFlag(
                                  controller.selectedCountry.value ?? '',
                                ),
                                style: const TextStyle(fontSize: 20),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  controller.selectedCountry.value ??
                                      'Select Country'.tr,
                                  style: TextStyle(
                                    color: AppColors.neutral700,
                                    fontSize: 14.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    height: 1.56,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down,
                                size: 16,
                                color: AppColors.neutral700,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 200.h),
                // Next Button
                Obx(() => AppButton(
                  text: controller.isLoading.value ? 'Loading'.tr : 'Next'.tr,
                  textColor: Colors.white,
                  backgroundColor: AppColors.primaryDark,
                  onPressed: controller.isLoading.value 
                    ? () {} 
                    : () => controller.updateProfile(),
                )),
                SizedBox(height: 20.h),
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
          height: 400.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Text(
                  'Select Country'.tr,
                  style: TextStyle(
                    fontSize: 16.sp,
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
                              ? AppColors.primaryDark
                              : AppColors.neutral700,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        controller.selectedCountry.value = country;
                        Navigator.pop(context);
                      },
                      trailing: isSelected
                          ? const Icon(
                              Icons.check,
                              color: AppColors.primaryDark,
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
        height: 48.h,
        padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryDark : Colors.white,
          border: Border.all(
            width: 1,
            color: isSelected ? AppColors.primaryDark : AppColors.neutral100,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 20.w,
              height: 20.h,
              color: isSelected ? Colors.white : AppColors.neutral700,
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.neutral700,
                  fontSize: 14.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.56,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
