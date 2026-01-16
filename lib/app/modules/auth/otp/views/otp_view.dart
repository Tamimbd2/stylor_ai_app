import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../widgets/primary_button.dart';
import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24.h),

              /// LOGO
              Center(child: Image.asset('assets/logo/logo.png', height: 50.h)),

              SizedBox(height: 40.h),

              /// TITLE
              Text(
                'Enter Verification Code'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF1C1C1E),
                  fontSize: 24.sp,
                  fontFamily: 'Helvetica Neue',
                  fontWeight: FontWeight.w700,
                  height: 1.40,
                ),
              ),

              SizedBox(height: 8.h),

              /// SUBTITLE
              Obx(() => RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: const Color(0xFF101C2C),
                    fontSize: 14.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 1.56,
                  ),
                  children: [
                    TextSpan(text: 'We Sent Code To'.tr),
                    const TextSpan(text: ' '),
                    TextSpan(
                      text: controller.email.value.isNotEmpty ? controller.email.value : 'Your Email'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1C1C1E),
                      ),
                    ),
                  ],
                ),
              )),

              SizedBox(height: 40.h),

              /// OTP INPUT FIELDS
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: OtpTextField(
                      numberOfFields: 6,
                      borderColor: Color(0xFF1C1C1E),
                      focusedBorderColor: Color(0xFF1C1C1E),
                      showFieldAsBox: true,
                      fieldWidth: 45.w,
                      fieldHeight: 52.h,
                      borderRadius: BorderRadius.circular(8.r),
                      textStyle: TextStyle(
                        color: Color(0xFF1C1C1E),
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                      cursorColor: Colors.black,
                      onCodeChanged: (String code) {
                        controller.setOtp(code);
                      },
                      onSubmit: (String verificationCode) {
                        controller.setOtp(verificationCode);
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: 300.h),

              /// RESEND CODE
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Didnt Receive Code'.tr,
                    style: TextStyle(
                      color: const Color(0xFF101C2C),
                      fontSize: 14.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Obx(() => GestureDetector(
                    onTap: controller.isResending.value ? null : () {
                      controller.resendCode();
                    },
                    child: Text(
                      controller.isResending.value ? 'Sending'.tr : 'Resend Code'.tr,
                      style: TextStyle(
                        color: controller.isResending.value ? Colors.grey : const Color(0xFF1C1C1E),
                        fontSize: 14.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )),
                ],
              ),

              SizedBox(height: 20.h),
              /// VERIFY BUTTON
              Obx(() => AppButton(
                text: controller.isVerifying.value ? 'Verifying'.tr : 'Verify Now'.tr,
                textColor: Colors.white,
                backgroundColor: const Color(0xFF060017),
                onPressed: controller.isVerifying.value
                    ? () {}
                    : () {
                        controller.verifyOtp();
                      },
              )),
            ],
          ),
        ),
      ),
    );
  }
}

/// OTP Input Field Widget
// class _OtpInputField extends StatelessWidget {
//   final TextEditingController controller;
//   final FocusNode focusNode;
//   final Function(String) onChanged;
//   const _OtpInputField({
//     required this.controller,
//     required this.focusNode,
//     required this.onChanged,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 76.w,
//       height: 48.h,
//       decoration: ShapeDecoration(
//         color: Colors.white,
//         shape: RoundedRectangleBorder(
//           side: const BorderSide(width: 1, color: Color(0xFF1C1C1E)),
//           borderRadius: BorderRadius.circular(8.r),
//         ),
//       ),
//       child: TextField(
//         controller: controller,
//         focusNode: focusNode,
//         textAlign: TextAlign.center,
//         keyboardType: TextInputType.number,
//         maxLength: 1,
//         style: TextStyle(
//           color: const Color(0xFF1C1C1E),
//           fontSize: 20.sp,
//           fontFamily: 'Poppins',
//           fontWeight: FontWeight.w600,
//         ),
//         inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//         decoration: const InputDecoration(
//           counterText: '',
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.zero,
//         ),
//         onChanged: onChanged,
//       ),
//     );
//   }
// }
