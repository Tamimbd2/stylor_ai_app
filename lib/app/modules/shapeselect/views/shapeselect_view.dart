import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../output_outfit/views/output_outfit_view.dart';
import '../controllers/shapeselect_controller.dart';

class ShapeselectView extends GetView<ShapeselectController> {
  const ShapeselectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    // Title
                    const Text(
                      'Today\'s outfits',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF1C1C1E),
                        fontSize: 24,
                        fontFamily: 'Helvetica Neue',
                        fontWeight: FontWeight.w700,
                        height: 1.40,
                      ),
                    ),
                    const SizedBox(height: 8),
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
                    const SizedBox(height: 14),
                    // Weather and Location Info
                    Container(
                      width: double.infinity,
                      height: 44,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
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
                          Image.asset(
                            'assets/icons/temperature.png',
                            width: 18,
                            height: 18,
                            color: const Color(0xFF49494B),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            '30.5 °C (87°F)',
                            style: TextStyle(
                              color: Color(0xFF49494B),
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 1.4,
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 18,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            color: const Color(0xFFD2D2D2),
                          ),
                          Image.asset(
                            'assets/icons/location.png',
                            width: 18,
                            height: 18,
                            color: const Color(0xFF49494B),
                          ),
                          const SizedBox(width: 6),
                          const Expanded(
                            child: Text(
                              'Brussels, Belgium',
                              style: TextStyle(
                                color: Color(0xFF49494B),
                                fontSize: 13,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                              ),
                            ),
                          ),
                          Image.asset(
                            'assets/icons/edit.png',
                            width: 14,
                            height: 14,
                            color: const Color(0xFF49494B),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Outfit Card Section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Stack(
                  children: [
                    // Main Outfit Card
                    Center(
                      child: Container(
                        width: 335,
                        height: 375,
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
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Center(
                            child: Image.asset(
                              'assets/image/dress.png',
                              width: 210,
                              height: 290,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Share Button (bottom right of card with arrow)
                    Positioned(
                      right: 12,
                      bottom: 12,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>OutputOutfitView()));
                        },
                        child: Container(
                          width: 48,
                          height: 48,
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
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/icons/arrow.png',
                            width: 20,
                            height: 20,
                            color: const Color(0xFF1C1C1E),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Action Buttons (Dislike and Like)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
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
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 20,
                        color: Color(0xFF1C1C1E),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 48,
                      height: 48,
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
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.favorite,
                        size: 20,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              // Style Selector Dropdown
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: GestureDetector(
                  onTap: () => _showStyleSelector(context),
                  child: Container(
                    width: double.infinity,
                    height: 44,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
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
                        Image.asset(
                          'assets/icons/casual.png',
                          width: 18,
                          height: 18,
                        ),
                        const SizedBox(width: 6),
                        const Expanded(
                          child: Text(
                            'Casual',
                            style: TextStyle(
                              color: Color(0xFF49494B),
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 1.4,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          size: 14,
                          color: Color(0xFF49494B),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        height: 88,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.77),
          border: const Border(
            top: BorderSide(width: 1, color: Color(0xFFE8E8E8)),
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
          size: 22,
          color: isActive ? const Color(0xFF060017) : const Color(0xFF777778),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFF060017) : const Color(0xFF777778),
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  void _showStyleSelector(BuildContext context) {
    final styles = [
      {'label': 'Casual', 'icon': 'assets/icons/casual.png'},
      {'label': 'Formal', 'icon': 'assets/icons/formal.png'},
      {'label': 'Streetwear', 'icon': 'assets/icons/Streetwear.png'},
      {'label': 'Minimalist', 'icon': 'assets/icons/Minimalist.png'},
      {'label': 'Party', 'icon': 'assets/icons/Party.png'},
      {'label': 'Artistic', 'icon': 'assets/icons/Artistic.png'},
      {'label': 'Vintage', 'icon': 'assets/icons/Vintage.png'},
      {'label': 'Sporty', 'icon': 'assets/icons/Sporty.png'},
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Style',
                  style: TextStyle(
                    color: Color(0xFF1C1C1E),
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: styles.length,
                  itemBuilder: (context, index) {
                    final style = styles[index];
                    return GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: [
                            Image.asset(
                              style['icon'] as String,
                              width: 32,
                              height: 32,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              style['label'] as String,
                              style: const TextStyle(
                                color: Color(0xFF49494B),
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
