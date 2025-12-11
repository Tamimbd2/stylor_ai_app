import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/wardrobe_controller.dart';

class WardrobeView extends GetView<WardrobeController> {
  const WardrobeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Title
            const Text(
              'Wardrobe',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF1C1C1E),
                fontSize: 24,
                fontFamily: 'Helvetica Neue',
                fontWeight: FontWeight.w700,
                height: 1.40,
              ),
            ),
            const SizedBox(height: 16),
            // Subtitle
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Your choices shape your AI style feed.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF101C2C),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.56,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Filter Tabs
            SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildFilterChip('All', true),
                  const SizedBox(width: 8),
                  _buildFilterChip('Top', false),
                  const SizedBox(width: 8),
                  _buildFilterChip('bottoms', false),
                  const SizedBox(width: 8),
                  _buildFilterChip('Sunglass', false),
                  const SizedBox(width: 8),
                  _buildFilterChip('Bag', false),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Grid of items
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 119 / 126,
                  ),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return _buildWardrobeItem(index);
                  },
                ),
              ),
            ),
            // Add new Outfit button
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Add new Outfit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Helvetica Neue',
                          fontWeight: FontWeight.w700,
                          height: 1.40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],

        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF060017) : const Color(0xFFE8E8E8),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF1C1C1E),
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            height: 1.56,
          ),
        ),
      ),
    );
  }

  Widget _buildWardrobeItem(int index) {
    final items = [
      {'image': 'assets/image/clothes.png', 'fit': BoxFit.cover},
      {'image': 'assets/image/dress2.png', 'fit': BoxFit.cover},
      {'image': 'assets/image/shoe.png', 'fit': BoxFit.contain},
      {'image': 'assets/image/dreess1.png', 'fit': BoxFit.cover},
      {'image': 'assets/image/sunglass.png', 'fit': BoxFit.contain},
    ];

    if (index >= items.length) return const SizedBox.shrink();

    return Container(
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Image.asset(
              items[index]['image'] as String,
              fit: items[index]['fit'] as BoxFit,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.image_outlined,
                  size: 40,
                  color: Color(0xFFE8E8E8),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}