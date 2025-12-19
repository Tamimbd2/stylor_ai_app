import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfit/core/color.dart';
import '../../shapeselect/views/shapeselect_view.dart';
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
  static const double _navBarHeight = 80;
  static const int _animationDuration = 200;
  static const Color _activeColor = AppColors.black;
  static const Color _inactiveColor = Colors.grey;
  static const Color _navBorderColor = Colors.black12;

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ShapeselectView(),
    CartView(),
    WardrobeView(),
    FavoriteView(),
    ProfileView(),
  ];

  final List<Map<String, String>> _navItems = [
    {
      'active': 'assets/svg/home.svg',
      'inactive': 'flutter_icon:home_outlined',
      'label': 'Home',
    },
    {
      'active': 'assets/svg/cart.svg',
      'inactive': 'assets/svg/cart_outline.png',
      'label': 'Cart',
    },
    {
      'active': 'assets/svg/wardrop.svg',
      'inactive': 'assets/svg/wardrop_outline.svg',
      'label': 'Wardrobe',
    },
    {
      'active': 'assets/svg/favorite.svg',
      'inactive': 'assets/svg/favorite_outline.svg',
      'label': 'Favorite',
    },
    {
      'active': 'assets/svg/profile.svg',
      'inactive': 'assets/svg/profile_outline.svg',
      'label': 'Profile',
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: SafeArea(
        child: Container(
          height: _navBarHeight,
          decoration: BoxDecoration(
            border: const Border(
              top: BorderSide(width: 1, color: _navBorderColor),
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              _navItems.length,
                  (index) => _buildNavItem(
                activeAssetPath: _navItems[index]['active']!,
                inactiveAssetPath: _navItems[index]['inactive']!,
                label: _navItems[index]['label']!,
                index: index,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String activeAssetPath,
    required String inactiveAssetPath,
    required String label,
    required int index,
  }) {
    final isActive = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 38.w,
            height: 38.h,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: _animationDuration),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: _buildIcon(
                  isActive ? activeAssetPath : inactiveAssetPath,
                  isActive: isActive,
                  key: ValueKey(isActive ? activeAssetPath : inactiveAssetPath),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? _activeColor : _inactiveColor,
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

  Widget _buildIcon(String assetPath, {Key? key, bool isActive = false}) {
    final iconSize = isActive ? 24.0 : 22.0;
    final svgSize = isActive ? 38.0 : 28.0;

    if (assetPath.startsWith('flutter_icon:')) {
      final iconName = assetPath.replaceFirst('flutter_icon:', '');
      final icon = _getIconData(iconName);

      return Icon(
        icon,
        key: key,
        size: iconSize,
        color: isActive ? Colors.black : Colors.grey,
      );
    } else if (assetPath.endsWith('.png')) {
      return SizedBox(
        key: key,
        width: iconSize,
        height: iconSize,
        child: Image.asset(assetPath, fit: BoxFit.contain),
      );
    } else {
      return SvgPicture.asset(
        assetPath,
        key: key,
        width: svgSize,
        height: svgSize,
        fit: BoxFit.contain,
      );
    }
  }

  IconData _getIconData(String iconName) {
    return switch (iconName) {
      'home_outlined' => Icons.home_outlined,
      'home' => Icons.home,
      'shopping_cart' => Icons.shopping_cart,
      'shopping_cart_outlined' => Icons.shopping_cart_outlined,
      'checkroom' => Icons.checkroom,
      'checkroom_outlined' => Icons.checkroom_outlined,
      'favorite' => Icons.favorite,
      'favorite_outlined' => Icons.favorite_outlined,
      'person' => Icons.person,
      'person_outlined' => Icons.person_outlined,
      _ => Icons.home,
    };
  }
}