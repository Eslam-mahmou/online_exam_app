// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../core/api/api_manager.dart' as _i108;
import '../data/data_source/local_data_source/get_questions_local_data_source.dart'
    as _i755;
import '../data/data_source/remote_data_source/auth_remote_data_source.dart'
    as _i261;
import '../data/data_source/remote_data_source/check_answer_remote_data_source.dart'
    as _i340;
import '../data/data_source/remote_data_source/exam_data_source.dart' as _i897;
import '../data/data_source/remote_data_source/profile_remote_data_source.dart'
    as _i240;
import '../data/data_source/remote_data_source/subject_remote_data_source.dart'
    as _i567;
import '../data/repository_impl/auth_repository_impl.dart' as _i970;
import '../data/repository_impl/check_answer_repository_impl.dart' as _i36;
import '../data/repository_impl/exam_repository_impl.dart' as _i321;
import '../data/repository_impl/profile_repository_impl.dart' as _i771;
import '../data/repository_impl/result_repository_impl.dart' as _i1012;
import '../data/repository_impl/subject_repository_impl.dart' as _i587;
import '../domain/repository/auth_repository.dart' as _i306;
import '../domain/repository/check_answer_repository.dart' as _i863;
import '../domain/repository/exam_repository.dart' as _i242;
import '../domain/repository/profile_repository.dart' as _i899;
import '../domain/repository/result_repository.dart' as _i471;
import '../domain/repository/subject_repository.dart' as _i801;
import '../domain/use_case/auth_use_case.dart' as _i358;
import '../domain/use_case/check_answer_use_case.dart' as _i880;
import '../domain/use_case/exam_use_case.dart' as _i334;
import '../domain/use_case/profile_use_case.dart' as _i92;
import '../domain/use_case/result_use_case.dart' as _i686;
import '../domain/use_case/subject_use_case.dart' as _i946;
import '../presentation/auth/manager/forget_password_cubit/forget_password_view_model.dart'
    as _i778;
import '../presentation/auth/manager/login_cubit/login_view_model.dart'
    as _i160;
import '../presentation/auth/manager/reset_password_cubit/reset_password_view_model.dart'
    as _i303;
import '../presentation/auth/manager/signUP_cubit/signup_view_model.dart'
    as _i628;
import '../presentation/auth/manager/verify_email_cubit/verify_email_vew_model.dart'
    as _i306;
import '../presentation/exam/manager/exam_cubit.dart' as _i164;
import '../presentation/exam/manager/question_cubit/question_cubit.dart'
    as _i168;
import '../presentation/exam/manager/score_cubit/score_view_model_cubit.dart'
    as _i286;
import '../presentation/layout/manager/change_password_cubit/change_password_view_model.dart'
    as _i884;
import '../presentation/layout/manager/explore_cubit/explore_view_model.dart'
    as _i601;
import '../presentation/layout/manager/profile_tab_cubit/profile_tab_view_model.dart'
    as _i409;
import '../presentation/layout/manager/result_cubit/result_cubit.dart' as _i424;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i108.ApiManager>(() => _i108.ApiManager());
    gh.factory<_i471.ResultRepository>(() => _i1012.ResultRepositoryImpl());
    gh.factory<_i755.GetQuestionsLocalDataSource>(
        () => _i755.GetQuestionsLocalDataSourceImpl());
    gh.factory<_i897.BaseExamDataSource>(
        () => _i897.BaseExamDataSourceImpl(gh<_i108.ApiManager>()));
    gh.factory<_i261.AuthRemoteDataSource>(
        () => _i261.AuthRemoteDataSourceImpl(gh<_i108.ApiManager>()));
    gh.factory<_i567.SubjectRemoteDataSource>(
        () => _i567.SubjectRemoteDataSourceImpl(gh<_i108.ApiManager>()));
    gh.factory<_i340.CheckAnswerRemoteDataSource>(
        () => _i340.CheckAnswerRemoteDataSourceImpl(gh<_i108.ApiManager>()));
    gh.factory<_i863.CheckAnswerRepository>(() =>
        _i36.CheckAnswerRepositoryImpl(
            gh<_i340.CheckAnswerRemoteDataSource>()));
    gh.factory<_i686.ResultUseCase>(
        () => _i686.ResultUseCase(gh<_i471.ResultRepository>()));
    gh.factory<_i240.ProfileRemoteDataSource>(
        () => _i240.ProfileRemoteDataSourceImpl(gh<_i108.ApiManager>()));
    gh.factory<_i899.ProfileRepository>(
        () => _i771.ProfileRepositoryImpl(gh<_i240.ProfileRemoteDataSource>()));
    gh.factory<_i801.SubjectRepository>(
        () => _i587.SubjectRepositoryImpl(gh<_i567.SubjectRemoteDataSource>()));
    gh.factory<_i946.SubjectUseCase>(
        () => _i946.SubjectUseCase(gh<_i801.SubjectRepository>()));
    gh.factory<_i306.AuthRepository>(
        () => _i970.AuthRepositoryImpl(gh<_i261.AuthRemoteDataSource>()));
    gh.factory<_i92.ProfileUseCase>(
        () => _i92.ProfileUseCase(gh<_i899.ProfileRepository>()));
    gh.factory<_i242.ExamRepository>(() => _i321.ExamRepositoryImpl(
          gh<_i897.BaseExamDataSource>(),
          gh<_i755.GetQuestionsLocalDataSource>(),
        ));
    gh.factory<_i601.ExploreViewModel>(
        () => _i601.ExploreViewModel(gh<_i946.SubjectUseCase>()));
    gh.factory<_i424.ResultViewModel>(
        () => _i424.ResultViewModel(gh<_i686.ResultUseCase>()));
    gh.factory<_i358.AuthUseCase>(
        () => _i358.AuthUseCase(gh<_i306.AuthRepository>()));
    gh.factory<_i880.CheckAnswerUseCase>(
        () => _i880.CheckAnswerUseCase(gh<_i863.CheckAnswerRepository>()));
    gh.factory<_i160.LoginViewModel>(
        () => _i160.LoginViewModel(gh<_i358.AuthUseCase>()));
    gh.factory<_i306.VerifyEmailVewModel>(
        () => _i306.VerifyEmailVewModel(gh<_i358.AuthUseCase>()));
    gh.factory<_i778.ForgetPasswordViewModel>(
        () => _i778.ForgetPasswordViewModel(gh<_i358.AuthUseCase>()));
    gh.factory<_i303.ResetPasswordViewModel>(
        () => _i303.ResetPasswordViewModel(gh<_i358.AuthUseCase>()));
    gh.factory<_i628.SignUpViewModel>(
        () => _i628.SignUpViewModel(gh<_i358.AuthUseCase>()));
    gh.factory<_i884.ChangePasswordViewModel>(
        () => _i884.ChangePasswordViewModel(gh<_i92.ProfileUseCase>()));
    gh.factory<_i409.ProfileTabViewModel>(
        () => _i409.ProfileTabViewModel(gh<_i92.ProfileUseCase>()));
    gh.factory<_i334.ExamUseCase>(
        () => _i334.ExamUseCase(gh<_i242.ExamRepository>()));
    gh.factory<_i164.ExamViewModel>(
        () => _i164.ExamViewModel(gh<_i334.ExamUseCase>()));
    gh.factory<_i168.QuestionViewModel>(
        () => _i168.QuestionViewModel(gh<_i334.ExamUseCase>()));
    gh.factory<_i286.ScoreScreenViewModel>(
        () => _i286.ScoreScreenViewModel(gh<_i880.CheckAnswerUseCase>()));
    return this;
  }
}
