// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/repositories/auth.repository.implement.dart' as _i7;
import '../../data/services/auth.service.implement.dart' as _i9;
import '../../data/services/base.service.dart' as _i10;
import '../../data/services/user.service.implement.dart' as _i17;
import '../../data/use_cases/login_usecase.implement.dart' as _i13;
import '../../domain/repositories/auth.repository.dart' as _i6;
import '../../domain/services/auth.service.dart' as _i8;
import '../../domain/services/user.service.dart' as _i16;
import '../../domain/use_cases/login_usecase.dart' as _i12;
import '../../presentations/bloc/auth/auth_bloc.dart' as _i5;
import '../../presentations/bloc/login/login_bloc.dart' as _i11;
import '../../presentations/bloc/themes/theme_cubit.dart' as _i14;
import '../../presentations/bloc/user/user_bloc.dart' as _i15;
import '../routers/navigation.dart' as _i3;
import '../routers/router.dart' as _i4;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.AppNavigation>(() => _i3.AppNavigation());
    gh.lazySingleton<_i4.AppRouters>(() => _i4.AppRouters());
    gh.lazySingleton<_i5.AuthBloc>(() => _i5.AuthBloc());
    gh.lazySingleton<_i6.AuthRepository>(() => _i7.AuthRepositoryImpl());
    gh.lazySingleton<_i8.AuthService>(() => _i9.AuthServiceImpl());
    gh.lazySingleton<_i10.CustomClient>(() => _i10.CustomClient());
    gh.lazySingleton<_i11.LoginBloc>(() => _i11.LoginBloc());
    gh.lazySingleton<_i12.LoginUseCase>(() => _i13.LoginUseCaseImpl());
    gh.lazySingleton<_i14.ThemeCubit>(() => _i14.ThemeCubit());
    gh.lazySingleton<_i15.UserBloc>(() => _i15.UserBloc());
    gh.lazySingleton<_i16.UserService>(() => _i17.UserServiceImpl());
    return this;
  }
}
