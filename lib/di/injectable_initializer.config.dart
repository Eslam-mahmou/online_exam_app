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
import '../data/data_source/remote_data_source/auth_remote_data_source.dart'
    as _i261;
import '../data/data_source/remote_data_source/profile_remote_data_source.dart'
    as _i240;
import '../data/repository_impl/auth_repository_impl.dart' as _i970;
import '../data/repository_impl/profile_repository_impl.dart' as _i771;
import '../domain/repository/auth_repository.dart' as _i306;
import '../domain/repository/profile_repository.dart' as _i899;
import '../domain/use_case/auth_use_case.dart' as _i358;
import '../domain/use_case/profile_use_case.dart' as _i92;
import '../presentation/auth/manager/change_password_cubit/change_password_view_model.dart'
    as _i152;
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
import '../presentation/layout/manager/profile_tab_cubit/profile_tab_view_model.dart'
    as _i409;

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
    gh.factory<_i261.AuthRemoteDataSource>(
        () => _i261.AuthRemoteDataSourceImpl(gh<_i108.ApiManager>()));
    gh.factory<_i240.ProfileRemoteDataSource>(
        () => _i240.ProfileRemoteDataSourceImpl(gh<_i108.ApiManager>()));
    gh.factory<_i899.ProfileRepository>(
        () => _i771.ProfileRepositoryImpl(gh<_i240.ProfileRemoteDataSource>()));
    gh.factory<_i306.AuthRepository>(
        () => _i970.AuthRepositoryImpl(gh<_i261.AuthRemoteDataSource>()));
    gh.factory<_i92.ProfileUseCase>(
        () => _i92.ProfileUseCase(gh<_i899.ProfileRepository>()));
    gh.factory<_i358.AuthUseCase>(
        () => _i358.AuthUseCase(gh<_i306.AuthRepository>()));
    gh.factory<_i160.LoginViewModel>(
        () => _i160.LoginViewModel(gh<_i358.AuthUseCase>()));
    gh.factory<_i306.VerifyEmailVewModel>(
        () => _i306.VerifyEmailVewModel(gh<_i358.AuthUseCase>()));
    gh.factory<_i152.ChangePasswordViewModel>(
        () => _i152.ChangePasswordViewModel(gh<_i358.AuthUseCase>()));
    gh.factory<_i778.ForgetPasswordViewModel>(
        () => _i778.ForgetPasswordViewModel(gh<_i358.AuthUseCase>()));
    gh.factory<_i303.ResetPasswordViewModel>(
        () => _i303.ResetPasswordViewModel(gh<_i358.AuthUseCase>()));
    gh.factory<_i628.SignUpViewModel>(
        () => _i628.SignUpViewModel(gh<_i358.AuthUseCase>()));
    gh.factory<_i409.ProfileTabViewModel>(
        () => _i409.ProfileTabViewModel(gh<_i92.ProfileUseCase>()));
    return this;
  }
}
