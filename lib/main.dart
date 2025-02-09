import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/routes_generator/pages_routes.dart';

import 'core/routes_generator/routes_generator.dart';

void main() {
  runApp(const OnlineExamApp());
}

class OnlineExamApp extends StatelessWidget {
  const OnlineExamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, _) =>const MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RoutesGenerator.onGenerateRoute,
        initialRoute: PagesRoutes.loginScreen,
      ),
    );
  }
}
