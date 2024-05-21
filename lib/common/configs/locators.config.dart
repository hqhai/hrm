// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/repositories/attendances.repository.implement.dart' as _i8;
import '../../data/repositories/auth.repository.implement.dart' as _i15;
import '../../data/repositories/check_in_setting.repository.implement.dart'
    as _i20;
import '../../data/repositories/department.repository.implement.dart' as _i28;
import '../../data/repositories/location.repository.implement.dart' as _i35;
import '../../data/repositories/note.repository.implement.dart' as _i44;
import '../../data/repositories/personnel.repository.implement.dart' as _i52;
import '../../data/repositories/position.repository.implement.dart' as _i59;
import '../../data/repositories/request.repository.implement.dart' as _i67;
import '../../data/repositories/user.repository.implement.dart' as _i78;
import '../../data/services/attendances.service.implement.dart' as _i10;
import '../../data/services/auth.service.implement.dart' as _i17;
import '../../data/services/base.service.dart' as _i25;
import '../../data/services/check_in_setting.service.implement.dart' as _i22;
import '../../data/services/department.service.implement.dart' as _i30;
import '../../data/services/location.service.implement.dart' as _i37;
import '../../data/services/note.service.implement.dart' as _i46;
import '../../data/services/personnel.service.implement.dart' as _i54;
import '../../data/services/position.service.implement.dart' as _i61;
import '../../data/services/request.service.implement.dart' as _i69;
import '../../data/services/user.service.implement.dart' as _i80;
import '../../data/use_cases/attendances_usecase.implement.dart' as _i12;
import '../../data/use_cases/check_in_setting_usecase.implement.dart' as _i24;
import '../../data/use_cases/department_usecase.implement.dart' as _i32;
import '../../data/use_cases/location.usecase.implement.dart' as _i39;
import '../../data/use_cases/login_usecase.implement.dart' as _i42;
import '../../data/use_cases/note_usecase.implement.dart' as _i48;
import '../../data/use_cases/personnel_usecase.implement.dart' as _i56;
import '../../data/use_cases/position_usecase.implement.dart' as _i63;
import '../../data/use_cases/request_usecase.implement.dart' as _i71;
import '../../data/use_cases/user_usecase.implement.dart' as _i82;
import '../../domain/repositories/attendances.repository.dart' as _i7;
import '../../domain/repositories/auth.repository.dart' as _i14;
import '../../domain/repositories/check_in_setting.repository.dart' as _i19;
import '../../domain/repositories/department.repository.dart' as _i27;
import '../../domain/repositories/location.repositories.dart' as _i34;
import '../../domain/repositories/note.repositories.dart' as _i43;
import '../../domain/repositories/personnel.repository.dart' as _i51;
import '../../domain/repositories/position.repository.dart' as _i58;
import '../../domain/repositories/request.repository.dart' as _i66;
import '../../domain/repositories/user.repositories.dart' as _i77;
import '../../domain/services/attendances.service.dart' as _i9;
import '../../domain/services/auth.service.dart' as _i16;
import '../../domain/services/check_in_setting.service.dart' as _i21;
import '../../domain/services/department.service.dart' as _i29;
import '../../domain/services/location.service.dart' as _i36;
import '../../domain/services/note.service.dart' as _i45;
import '../../domain/services/personnel.service.dart' as _i53;
import '../../domain/services/position.service.dart' as _i60;
import '../../domain/services/request.service.dart' as _i68;
import '../../domain/services/user.service.dart' as _i79;
import '../../domain/use_cases/attendances_usecase.dart' as _i11;
import '../../domain/use_cases/check_in_setting_usecase.dart' as _i23;
import '../../domain/use_cases/departments_usecase.dart' as _i31;
import '../../domain/use_cases/location.usecase.dart' as _i38;
import '../../domain/use_cases/login_usecase.dart' as _i41;
import '../../domain/use_cases/note.usecase.dart' as _i47;
import '../../domain/use_cases/personnel_usecase.dart' as _i55;
import '../../domain/use_cases/position_usecase.dart' as _i62;
import '../../domain/use_cases/request_usecase.dart' as _i70;
import '../../domain/use_cases/user_usecase.dart' as _i81;
import '../../presentations/bloc/attendance/attendance_bloc.dart' as _i6;
import '../../presentations/bloc/auth/auth_bloc.dart' as _i13;
import '../../presentations/bloc/checkin_setting/check_in_setting_bloc.dart'
    as _i18;
import '../../presentations/bloc/department/department_bloc.dart' as _i26;
import '../../presentations/bloc/language/language_cubit.dart' as _i33;
import '../../presentations/bloc/location/address/address_bloc.dart' as _i3;
import '../../presentations/bloc/login/login_bloc.dart' as _i40;
import '../../presentations/bloc/notes/notes_bloc.dart' as _i49;
import '../../presentations/bloc/personnel/personnel_bloc.dart' as _i50;
import '../../presentations/bloc/position/position_bloc.dart' as _i57;
import '../../presentations/bloc/register/register_bloc.dart' as _i64;
import '../../presentations/bloc/request/request/request_bloc.dart' as _i65;
import '../../presentations/bloc/request/room_meeting/room_meeting_bloc.dart'
    as _i72;
import '../../presentations/bloc/themes/theme_cubit.dart' as _i73;
import '../../presentations/bloc/user/user/user_bloc.dart' as _i74;
import '../../presentations/bloc/user/user_by_manager/user_by_admin_bloc.dart'
    as _i75;
import '../../presentations/bloc/user/user_by_roles/user_by_roles_bloc.dart'
    as _i76;
import '../routers/navigation.dart' as _i4;
import '../routers/router.dart' as _i5;

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
    gh.lazySingleton<_i3.AddressBloc>(() => _i3.AddressBloc());
    gh.lazySingleton<_i4.AppNavigation>(() => _i4.AppNavigation());
    gh.lazySingleton<_i5.AppRouters>(() => _i5.AppRouters());
    gh.lazySingleton<_i6.AttendanceBloc>(() => _i6.AttendanceBloc());
    gh.lazySingleton<_i7.AttendanceRepository>(
        () => _i8.AttendanceRepositoryImplement());
    gh.lazySingleton<_i9.AttendanceService>(
        () => _i10.AttendanceServiceImplement());
    gh.lazySingleton<_i11.AttendanceUseCase>(
        () => _i12.AttendanceUseCaseImplement());
    gh.lazySingleton<_i13.AuthBloc>(() => _i13.AuthBloc());
    gh.lazySingleton<_i14.AuthRepository>(() => _i15.AuthRepositoryImpl());
    gh.lazySingleton<_i16.AuthService>(() => _i17.AuthServiceImpl());
    gh.lazySingleton<_i18.CheckInSettingBloc>(() => _i18.CheckInSettingBloc());
    gh.lazySingleton<_i19.CheckInSettingRepository>(
        () => _i20.CheckInSettingRepositoryImpl());
    gh.lazySingleton<_i21.CheckInSettingService>(
        () => _i22.CheckInSettingServiceImpl());
    gh.lazySingleton<_i23.CheckInSettingUseCase>(
        () => _i24.CheckInSettingUseCaseImpl());
    gh.lazySingleton<_i25.CustomClient>(() => _i25.CustomClient());
    gh.lazySingleton<_i26.DepartmentBloc>(() => _i26.DepartmentBloc());
    gh.lazySingleton<_i27.DepartmentRepository>(
        () => _i28.DepartmentRepositoryImpl());
    gh.lazySingleton<_i29.DepartmentService>(
        () => _i30.DepartmentServiceImpl());
    gh.lazySingleton<_i31.DepartmentUseCase>(
        () => _i32.DepartmentUseCaseImpl());
    gh.lazySingleton<_i33.LanguageCubit>(() => _i33.LanguageCubit());
    gh.lazySingleton<_i34.LocationRepository>(
        () => _i35.LocationRepositoryImpl());
    gh.lazySingleton<_i36.LocationService>(() => _i37.LocationServiceImpl());
    gh.lazySingleton<_i38.LocationUseCase>(() => _i39.LocationUseCaseImpl());
    gh.lazySingleton<_i40.LoginBloc>(() => _i40.LoginBloc());
    gh.lazySingleton<_i41.LoginUseCase>(() => _i42.LoginUseCaseImpl());
    gh.lazySingleton<_i43.NoteRepository>(() => _i44.NoteRepositoryImpl());
    gh.lazySingleton<_i45.NoteService>(() => _i46.NoteServiceImpl());
    gh.lazySingleton<_i47.NoteUseCase>(() => _i48.NoteUseCaseImpl());
    gh.lazySingleton<_i49.NotesBloc>(() => _i49.NotesBloc());
    gh.lazySingleton<_i50.PersonnelBloc>(() => _i50.PersonnelBloc());
    gh.lazySingleton<_i51.PersonnelRepository>(
        () => _i52.PersonnelRepositoryImpl());
    gh.lazySingleton<_i53.PersonnelService>(() => _i54.PersonnelServiceImpl());
    gh.lazySingleton<_i55.PersonnelUseCase>(() => _i56.PersonnelUseCaseImpl());
    gh.lazySingleton<_i57.PositionBloc>(() => _i57.PositionBloc());
    gh.lazySingleton<_i58.PositionRepository>(
        () => _i59.PositionRepositoryImpl());
    gh.lazySingleton<_i60.PositionService>(() => _i61.PositionServiceImpl());
    gh.lazySingleton<_i62.PositionUseCase>(() => _i63.PositionUseCaseImpl());
    gh.lazySingleton<_i64.RegisterBloc>(() => _i64.RegisterBloc());
    gh.lazySingleton<_i65.RequestBloc>(() => _i65.RequestBloc());
    gh.lazySingleton<_i66.RequestRepository>(
        () => _i67.RequestRepositoryImplement());
    gh.lazySingleton<_i68.RequestService>(() => _i69.RequestServiceImpl());
    gh.lazySingleton<_i70.RequestUseCase>(() => _i71.RequestUseCaseImplement());
    gh.lazySingleton<_i72.RoomMeetingBloc>(() => _i72.RoomMeetingBloc());
    gh.lazySingleton<_i73.ThemeCubit>(() => _i73.ThemeCubit());
    gh.lazySingleton<_i74.UserBloc>(() => _i74.UserBloc());
    gh.lazySingleton<_i75.UserByAdminBloc>(() => _i75.UserByAdminBloc());
    gh.lazySingleton<_i76.UserByRolesBloc>(() => _i76.UserByRolesBloc());
    gh.lazySingleton<_i77.UserRepository>(() => _i78.UserRepositoryImpl());
    gh.lazySingleton<_i79.UserService>(() => _i80.UserServiceImpl());
    gh.lazySingleton<_i81.UserUseCase>(() => _i82.UserUseCaseImpl());
    return this;
  }
}
