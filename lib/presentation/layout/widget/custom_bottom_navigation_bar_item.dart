
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';

class CustomBottomNavigationBarItem extends BottomNavigationBarItem {
  String iconPath;
  String title;

  CustomBottomNavigationBarItem({required this.iconPath, required this.title})
      : super(
      icon: ImageIcon(
        AssetImage(iconPath),
        color: ColorsManager.greyColor,
        size: 35,
      ),
      activeIcon: Container(
        width: 64.w,
        height: 32.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color:ColorsManager.blueLightColor,
        ),
        child: ImageIcon(
          AssetImage(iconPath),
          color: ColorsManager.primaryColor,
          size: 35,
        ),
      ),
      label: title);
}
