import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                // Profile Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x0F101828),
                        blurRadius: 64,
                        offset: const Offset(0, 32),
                        spreadRadius: -12,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Profile Image
                      Container(
                        width: 66,
                        height: 66,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 0),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x0F101828),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                              spreadRadius: -2,
                            ),
                            BoxShadow(
                              color: const Color(0x19101828),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                              spreadRadius: -2,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/image/profile.png',
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: const Color(0xFFE8E8E8),
                                child: const Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Color(0xFF8D8D8F),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Name and Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Mohammad Ali',
                              style: TextStyle(
                                color: Color(0xFF101C2C),
                                fontSize: 16,
                                fontFamily: 'Helvetica Neue',
                                fontWeight: FontWeight.w700,
                                height: 1.50,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Your account Details',
                              style: TextStyle(
                                color: Color(0xFF303437),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 1.56,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Arrow Icon
                      const Icon(
                        Icons.chevron_right,
                        color: Color(0xFF8D8D8F),
                        size: 24,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Settings Title
                const Text(
                  'Settings',
                  style: TextStyle(
                    color: Color(0xFF1C1C1E),
                    fontSize: 20,
                    fontFamily: 'Helvetica Neue',
                    fontWeight: FontWeight.w700,
                    height: 1.40,
                  ),
                ),
                const SizedBox(height: 16),
                // Settings Card
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x0F101828),
                        blurRadius: 64,
                        offset: const Offset(0, 32),
                        spreadRadius: -12,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildSettingItem(
                        icon: Icons.notifications_outlined,
                        title: 'Notification',
                        hasSwitch: true,
                        switchValue: true,
                      ),
                      _buildDivider(),
                      _buildSettingItem(
                        icon: Icons.lock_outline,
                        title: 'Privacy',
                        hasArrow: true,
                      ),
                      _buildDivider(),
                      _buildSettingItem(
                        icon: Icons.language,
                        title: 'Language',
                        trailingText: 'English',
                        hasArrow: true,
                      ),
                      _buildDivider(),
                      _buildSettingItem(
                        icon: Icons.description_outlined,
                        title: 'Terms and condition',
                        hasArrow: true,
                      ),
                      _buildDivider(),
                      _buildSettingItem(
                        icon: Icons.share_outlined,
                        title: 'Share The app',
                        hasArrow: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 300),
                // Log Out Button
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFD2D2D2),
                      width: 1,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Log Out',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF060017),
                        fontSize: 18,
                        fontFamily: 'Helvetica Neue',
                        fontWeight: FontWeight.w500,
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
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    String? trailingText,
    bool hasArrow = false,
    bool hasSwitch = false,
    bool switchValue = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF49494B)),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF49494B),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.56,
            ),
          ),
          const Spacer(),
          if (trailingText != null)
            Text(
              trailingText,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color(0xFF8D8D8F),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.56,
              ),
            ),
          if (hasSwitch)
            Switch(
              value: switchValue,
              onChanged: (value) {},
              activeColor: Colors.white,
              activeTrackColor: const Color(0xFF060017),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: const Color(0xFFE8E8E8),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          if (hasArrow)
            const Icon(Icons.chevron_right, size: 20, color: Color(0xFF8D8D8F)),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0)),
    );
  }
}
