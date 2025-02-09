import 'package:flutter/material.dart';
import 'package:online_exam_app/core/Utils/assets_manager.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/core/Utils/font_manager.dart';
import 'package:online_exam_app/core/Utils/style_manager.dart';
import 'package:online_exam_app/presentation/layout/pages/profilePage/profile_tab.dart';

import 'widget/custom_bottom_navigation_bar_item.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:const ProfileTab(),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: 2,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: getTextStyle(FontSize.s12,
              FontWeightManager.semiBold, ColorsManager.primaryColor,
              fontFamily: FontFamily.roboto),
          unselectedLabelStyle: getTextStyle(FontSize.s12,
              FontWeightManager.medium, ColorsManager.greyColor,
              fontFamily: FontFamily.roboto),
          items: [
            CustomBottomNavigationBarItem(
                iconPath: IconAssets.homeIcon, title: "Explore"),
            CustomBottomNavigationBarItem(
                iconPath: IconAssets.resultIcon, title: "Result"),
            CustomBottomNavigationBarItem(
                iconPath: IconAssets.profileIcon, title: "Profile"),
          ]),
    );
  }
}
