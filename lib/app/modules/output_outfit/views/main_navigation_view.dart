import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shapeselect/views/shapeselect_view.dart';
import 'output_outfit_view.dart';
import '../../cart/views/cart_view.dart';
import '../../wardrobe/views/wardrobe_view.dart';
import '../../favorite/views/favorite_view.dart';
import '../../profile/views/profile_view.dart';

class MainNavigationView extends StatefulWidget {
  const MainNavigationView({super.key});

  @override
  State<MainNavigationView> createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends State<MainNavigationView> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
     ShapeselectView(),
     // OutputOutfitView(),
     CartView(),
     WardrobeView(),
          FavoriteView(),
     ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: _screens[_selectedIndex],
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
            _buildNavItem(Icons.home, 'Home', 0),
            _buildNavItem(Icons.shopping_cart_outlined, 'Cart', 1),
            _buildNavItem(Icons.checkroom_outlined, 'Wardrobe', 2),
            _buildNavItem(Icons.favorite_border, 'Favorite', 3),
            _buildNavItem(Icons.person_outline, 'Profile', 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isActive = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? const Color(0xFF060017).withOpacity(0.1)
                  : Colors.transparent,
            ),
            child: Icon(
              isActive ? _getFilledIcon(icon) : icon,
              size: 22,
              color:
                  isActive ? const Color(0xFF060017) : const Color(0xFF777778),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color:
                  isActive ? const Color(0xFF060017) : const Color(0xFF777778),
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getFilledIcon(IconData icon) {
    if (icon == Icons.home) return Icons.home;
    if (icon == Icons.shopping_cart_outlined) return Icons.shopping_cart;
    if (icon == Icons.checkroom_outlined) return Icons.checkroom;
    if (icon == Icons.favorite_border) return Icons.favorite;
    if (icon == Icons.person_outline) return Icons.person;
    return icon;
  }
}
