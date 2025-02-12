import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/assets_manager.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/core/routes_generator/pages_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
     const Duration(milliseconds: 1700),
      () => Navigator.pushNamed(context, PagesRoutes.loginScreen),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.whiteColor,
      body: FadeInDown(
        duration: const Duration(milliseconds:1500),
        from: 500.h,
        child: Center(
          child: Image.asset(
            IconAssets.splashIcon,
            color: ColorsManager.primaryColor,
            scale: 2,
          ),
        ),
      ),
    );
  }
}
