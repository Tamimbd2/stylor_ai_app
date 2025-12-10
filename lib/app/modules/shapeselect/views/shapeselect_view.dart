import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/shapeselect_controller.dart';

class ShapeselectView extends GetView<ShapeselectController> {
  const ShapeselectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                children: [
                  // Title
                  const Text(
                    'Todays outfits',
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
                  const SizedBox(height: 16),
                  // Weather and Location Info
                  Container(
                    width: double.infinity,
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
                          Icons.thermostat,
                          size: 20,
                          color: Color(0xFF49494B),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          '30.5 °C (87°F)',
                          style: TextStyle(
                            color: Color(0xFF49494B),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 1.56,
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 20,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          color: const Color(0xFFD2D2D2),
                        ),
                        const Icon(
                          Icons.location_on,
                          size: 20,
                          color: Color(0xFF49494B),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Brussels, Belgium',
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
                          Icons.edit_outlined,
                          size: 16,
                          color: Color(0xFF49494B),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Outfit Card Section
            Expanded(
              child: Stack(
                children: [
                  // Main Outfit Card
                  Center(
                    child: Container(
                      width: 389,
                      height: 420,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 1,
                          color: const Color(0xFFF4F4F4),
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0F101828),
                            blurRadius: 64,
                            offset: Offset(0, 32),
                            spreadRadius: -12,
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Center(
                          child: Image.asset(
                            'assets/image/dress.png',
                            width: 235,
                            height: 315,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Share Button (top right of card)
                  Positioned(
                    right: 41,
                    top: 140,
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1,
                          color: const Color(0xFFF4F4F4),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0F101828),
                            blurRadius: 64,
                            offset: Offset(0, 32),
                            spreadRadius: -12,
                          )
                        ],
                      ),
                      child: const Icon(
                        Icons.share_outlined,
                        size: 24,
                        color: Color(0xFF1C1C1E),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Action Buttons (Dislike and Like)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1,
                        color: const Color(0xFFF4F4F4),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0F101828),
                          blurRadius: 64,
                          offset: Offset(0, 32),
                          spreadRadius: -12,
                        )
                      ],
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 24,
                      color: Color(0xFF1C1C1E),
                    ),
                  ),
                  const SizedBox(width: 68),
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1,
                        color: const Color(0xFFF4F4F4),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0F101828),
                          blurRadius: 64,
                          offset: Offset(0, 32),
                          spreadRadius: -12,
                        )
                      ],
                    ),
                    child: const Icon(
                      Icons.favorite,
                      size: 24,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Style Selector Dropdown
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
                      Icons.style_outlined,
                      size: 20,
                      color: Color(0xFF49494B),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Smart Casual',
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
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.77),
          border: const Border(
            top: BorderSide(
              width: 1,
              color: Color(0xFFE8E8E8),
            ),
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 'Home', true),
            _buildNavItem(Icons.shopping_cart_outlined, 'Cart', false),
            _buildNavItem(Icons.checkroom_outlined, 'wardrobe', false),
            _buildNavItem(Icons.favorite_border, 'Favorite', false),
            _buildNavItem(Icons.person_outline, 'Profile', false),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 24,
          color: isActive ? const Color(0xFF060017) : const Color(0xFF777778),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFF060017) : const Color(0xFF777778),
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            height: 1.56,
          ),
        ),
      ],
    );
  }
}