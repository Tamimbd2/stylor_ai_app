import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/terms_and_conditions_controller.dart';

class TermsAndConditionsView extends GetView<TermsAndConditionsController> {
  const TermsAndConditionsView({super.key});

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
          'Terms and condition',
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Stylor.ai — Terms & Conditions\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 18,
                            fontFamily: 'Helvetica Neue',
                            fontWeight: FontWeight.w700,
                            height: 1.40,
                          ),
                        ),
                        TextSpan(
                          text: '\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 14,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: 'Last Updated: December 2025\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.50,
                          ),
                        ),
                        TextSpan(
                          text: '\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 14,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: 'Welcome to Stylor.ai! These Terms & Conditions ("Terms") govern your use of our mobile application and services. By using Stylor.ai, you agree to these Terms.\n',
                          style: TextStyle(
                            color: Color(0xFF49494B),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: '\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 14,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: '1. Use of the App\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.50,
                          ),
                        ),
                        TextSpan(
                          text: '\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 14,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: 'You must be at least 13 years old to use Stylor.ai.\n\nYou are responsible for keeping your account secure.\n\nYou must provide accurate information when creating an account.\n',
                          style: TextStyle(
                            color: Color(0xFF49494B),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: '\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 14,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: '2. Our Services\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.50,
                          ),
                        ),
                        TextSpan(
                          text: '\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 14,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: 'Stylor.ai provides:\n\nAI-generated outfit suggestions\n\nProduct recommendations through affiliate partners\n\nWardrobe image upload and background removal\n\nIn future: Pro features (paid or subscription-based) that may include advanced AI tools, exclusive styles, unlimited wardrobe storage, and more.\n\nWe may update or modify features at any time.\n',
                          style: TextStyle(
                            color: Color(0xFF49494B),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: '\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 14,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: '3. Affiliate Products\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.50,
                          ),
                        ),
                        TextSpan(
                          text: '\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 14,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: 'When you click a product suggestion, you may be redirected to third-party retailer websites.\n\nStylor.ai is not responsible for purchases, delivery, refunds, or issues on retailer websites.\n\nWe may earn a commission from purchases made through affiliate links.\n\n4. User Content\n\nYou may upload images to your wardrobe. By doing so, you confirm:\n\nYou have the right to use the images.\n\nThe images do not violate any laws.\n\nWe do not claim ownership of your images. We only process them to remove backgrounds and create suggestions.\n',
                          style: TextStyle(
                            color: Color(0xFF49494B),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: '\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 14,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: '5. Pro Features (Future)\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.50,
                          ),
                        ),
                        TextSpan(
                          text: '\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 14,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: 'Stylor.ai may introduce paid premium features. When these launch:\n\nPrices will be displayed clearly in the app.\n\nSubscriptions will renew automatically unless canceled.\n\nYou can cancel anytime through your app store settings.\n',
                          style: TextStyle(
                            color: Color(0xFF49494B),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: '\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 14,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: '6. Restrictions\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.50,
                          ),
                        ),
                        TextSpan(
                          text: '\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 14,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: 'You agree not to:\n\nUse the app for illegal activities\n\nCopy, reverse engineer, or try to modify our technology\n\nUpload harmful or inappropriate content\n',
                          style: TextStyle(
                            color: Color(0xFF49494B),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: '\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 14,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: '7. Third-Party Services\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.50,
                          ),
                        ),
                        TextSpan(
                          text: '\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 14,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: 'Stylor.ai uses third-party services (analytics, affiliate networks, hosting). Their own terms and privacy policies may apply when you interact with them.\n',
                          style: TextStyle(
                            color: Color(0xFF49494B),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: '\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 14,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: '8. Limitation of Liability\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.50,
                          ),
                        ),
                        TextSpan(
                          text: '\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 14,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: 'Stylor.ai is not responsible for:\n\nProduct quality or issues from third-party retailers\n\nInaccurate outfit suggestions\n\nApp downtime or technical errors\n\nYou use the app at your own risk.\n',
                          style: TextStyle(
                            color: Color(0xFF49494B),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: '\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 14,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: '9. Account Termination\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.50,
                          ),
                        ),
                        TextSpan(
                          text: '\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 14,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: 'We may suspend or delete accounts that violate our Terms. Users can delete their account anytime in the app.\n',
                          style: TextStyle(
                            color: Color(0xFF49494B),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: '\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 14,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: '10. Changes to Terms\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.50,
                          ),
                        ),
                        TextSpan(
                          text: '\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 14,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: 'We may update these Terms occasionally. Continued use of the app means you accept the updated Terms.\n',
                          style: TextStyle(
                            color: Color(0xFF49494B),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: '\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 14,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: '11. Contact\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.50,
                          ),
                        ),
                        TextSpan(
                          text: '\n',
                          style: TextStyle(
                            color: Color(0xFF060017),
                            fontSize: 14,
                            height: 1.56,
                          ),
                        ),
                        TextSpan(
                          text: 'For questions or support, contact: stylorai.123@gmail.com',
                          style: TextStyle(
                            color: Color(0xFF49494B),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.56,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          // Buttons
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Accept Button
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
                      'Accept Term and Condition',
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
                const SizedBox(height: 12),
                // Decline Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(
                        color: Color(0xFFFF3232),
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Decline',
                      style: TextStyle(
                        color: Color(0xFFFF3232),
                        fontSize: 18,
                        fontFamily: 'Helvetica Neue',
                        fontWeight: FontWeight.w500,
                        height: 1.40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}