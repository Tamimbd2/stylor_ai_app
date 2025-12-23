import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/color.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../output_outfit/views/output_outfit_view.dart';
import '../controllers/shapeselect_controller.dart';
import '../../../../app/widgets/shapeselect_widgets/header_section.dart';
import '../../../../app/widgets/shapeselect_widgets/outfit_card_section.dart';
import '../../../../app/widgets/shapeselect_widgets/action_buttons_section.dart';
import '../../../../app/widgets/shapeselect_widgets/style_selector_section.dart';

class ShapeselectView extends StatefulWidget {
  ShapeselectView({super.key});
  final ShapeselectController controller = Get.put(ShapeselectController());
  final CartController cartController = Get.put(CartController());

  @override
  State<ShapeselectView> createState() => _ShapeselectViewState();
}

class _ShapeselectViewState extends State<ShapeselectView> {
  final ShapeselectController controller = Get.put(ShapeselectController());
  String _selectedStyle = 'Casual Outing';
  final GlobalKey<OutfitCardSectionState> _cardSectionKey =
      GlobalKey<OutfitCardSectionState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(
          () => controller.showOutfitDetails.value
              ? OutputOutfitView()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const HeaderSection(),
                      // SizedBox(height: 8.h),
                      OutfitCardSection(
                        key: _cardSectionKey,
                        onDetailsPressed: () =>
                            controller.toggleOutfitDetails(),
                      ),
                      SizedBox(height: 0.h),
                      ActionButtonsSection(
                        onCancel: () =>
                            _cardSectionKey.currentState?.swipeLeft(),
                        onLike: () =>
                            _cardSectionKey.currentState?.swipeRight(),
                      ),
                      SizedBox(height: 0.h),
                      StyleSelectorSection(
                        selectedStyle: _selectedStyle,
                        onStyleChanged: (style) {
                          setState(() => _selectedStyle = style);
                        },
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
