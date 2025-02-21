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
import '../data/data_source/remote_data_source/remote_data_source.dart' as _i61;
import '../data/repository_impl/auth_repository_impl.dart' as _i970;
import '../domain/repository/auth_repository.dart' as _i306;
import '../domain/use_case/auth_use_case.dart' as _i358;
import '../presentation/auth/manager/login_cubit/login_view_model.dart'
    as _i160;

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
    gh.factory<_i61.AuthRemoteDataSource>(
        () => _i61.AuthRemoteDataSourceImpl(gh<_i108.ApiManager>()));
    gh.factory<_i306.AuthRepository>(
        () => _i970.AuthRepositoryImpl(gh<_i261.AuthRemoteDataSource>()));
    gh.factory<_i358.AuthUseCase>(
        () => _i358.AuthUseCase(gh<_i306.AuthRepository>()));

    gh.factory<_i160.LoginViewModel>(
        () => _i160.LoginViewModel(gh<_i358.AuthUseCase>()));

    return this;
  }
}
