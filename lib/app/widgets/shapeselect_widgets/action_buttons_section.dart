import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'common_buttons.dart';

class ActionButtonsSection extends StatelessWidget {
  final VoidCallback? onCancel;
  final VoidCallback? onLike;

  const ActionButtonsSection({this.onCancel, this.onLike});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ActionButton(icon: Icons.close, onTap: onCancel ?? () {}),
          SizedBox(width: 12.w),
          ActionButton(
            icon: Icons.favorite,
            iconColor: Colors.red,
            onTap: onLike ?? () {},
          ),
        ],
      ),
    );
  }
}
