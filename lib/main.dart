import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/routes_generator/pages_routes.dart';
import 'package:online_exam_app/core/services/easy_loading_service.dart';

import 'core/routes_generator/routes_generator.dart';

void main() {
  runApp(const OnlineExamApp());
  ConfigLoading().showLoading();
}

class OnlineExamApp extends StatelessWidget {
  const OnlineExamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RoutesGenerator.onGenerateRoute,
        initialRoute: PagesRoutes.splashScreen,
        builder: EasyLoading.init(),
      ),
    );
  }
}
