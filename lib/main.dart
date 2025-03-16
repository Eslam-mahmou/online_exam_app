import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:online_exam_app/core/routes_generator/pages_routes.dart';
import 'package:online_exam_app/core/services/easy_loading_service.dart';
import 'package:online_exam_app/core/utils/constant_manager.dart';
import 'package:online_exam_app/domain/entity/QuestionsOnExamEntity.dart';
import 'package:online_exam_app/domain/entity/cache_answer_model.dart';

import 'core/routes_generator/routes_generator.dart';
import 'core/services/bloc_observer.dart';
import 'core/services/shared_preference_services.dart';
import 'di/injectable_initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  await Hive.initFlutter();
  configureDependencies();

  Hive.registerAdapter(AnswerModelAdapter());
  Hive.registerAdapter(CachedAnswerDataAdapter());
  Hive.registerAdapter(QuestionsAdapter());
  Hive.registerAdapter(AnswersAdapter());

  if (Hive.isBoxOpen(AppConstants.hiveBoxQuestion)) {
    await Hive.box(AppConstants.hiveBoxQuestion).close();
  }
//new pull request
  await Hive.openBox<Questions>(AppConstants.hiveBoxQuestion);
  await Hive.openBox<CachedAnswerData>(AppConstants.hiveBoxQuestionAnswer);
  await SharedPreferenceServices.init();

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
