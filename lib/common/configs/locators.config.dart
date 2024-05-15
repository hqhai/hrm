// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/repositories/attendances.repository.implement.dart' as _i7;
import '../../data/repositories/auth.repository.implement.dart' as _i14;
import '../../data/repositories/check_in_setting.repository.implement.dart'
    as _i19;
import '../../data/repositories/department.repository.implement.dart' as _i27;
import '../../data/repositories/note.repository.implement.dart' as _i37;
import '../../data/repositories/personnel.repository.implement.dart' as _i45;
import '../../data/repositories/position.repository.implement.dart' as _i52;
import '../../data/repositories/request.repository.implement.dart' as _i60;
import '../../data/repositories/user.repository.implement.dart' as _i71;
import '../../data/services/attendances.service.implement.dart' as _i9;
import '../../data/services/auth.service.implement.dart' as _i16;
import '../../data/services/base.service.dart' as _i24;
import '../../data/services/check_in_setting.service.implement.dart' as _i21;
import '../../data/services/department.service.implement.dart' as _i29;
import '../../data/services/note.service.implement.dart' as _i39;
import '../../data/services/personnel.service.implement.dart' as _i47;
import '../../data/services/position.service.implement.dart' as _i54;
import '../../data/services/request.service.implement.dart' as _i62;
import '../../data/services/user.service.implement.dart' as _i73;
import '../../data/use_cases/attendances_usecase.implement.dart' as _i11;
import '../../data/use_cases/check_in_setting_usecase.implement.dart' as _i23;
import '../../data/use_cases/department_usecase.implement.dart' as _i31;
import '../../data/use_cases/login_usecase.implement.dart' as _i35;
import '../../data/use_cases/note_usecase.implement.dart' as _i41;
import '../../data/use_cases/personnel_usecase.implement.dart' as _i49;
import '../../data/use_cases/position_usecase.implement.dart' as _i56;
import '../../data/use_cases/request_usecase.implement.dart' as _i64;
import '../../data/use_cases/user_usecase.implement.dart' as _i75;
import '../../domain/repositories/attendances.repository.dart' as _i6;
import '../../domain/repositories/auth.repository.dart' as _i13;
import '../../domain/repositories/check_in_setting.repository.dart' as _i18;
import '../../domain/repositories/department.repository.dart' as _i26;
import '../../domain/repositories/note.repositories.dart' as _i36;
import '../../domain/repositories/personnel.repository.dart' as _i44;
import '../../domain/repositories/position.repository.dart' as _i51;
import '../../domain/repositories/request.repository.dart' as _i59;
import '../../domain/repositories/user.repositories.dart' as _i70;
import '../../domain/services/attendances.service.dart' as _i8;
import '../../domain/services/auth.service.dart' as _i15;
import '../../domain/services/check_in_setting.service.dart' as _i20;
import '../../domain/services/department.service.dart' as _i28;
import '../../domain/services/note.service.dart' as _i38;
import '../../domain/services/personnel.service.dart' as _i46;
import '../../domain/services/position.service.dart' as _i53;
import '../../domain/services/request.service.dart' as _i61;
import '../../domain/services/user.service.dart' as _i72;
import '../../domain/use_cases/attendances_usecase.dart' as _i10;
import '../../domain/use_cases/check_in_setting_usecase.dart' as _i22;
import '../../domain/use_cases/departments_usecase.dart' as _i30;
import '../../domain/use_cases/login_usecase.dart' as _i34;
import '../../domain/use_cases/note.usecase.dart' as _i40;
import '../../domain/use_cases/personnel_usecase.dart' as _i48;
import '../../domain/use_cases/position_usecase.dart' as _i55;
import '../../domain/use_cases/request_usecase.dart' as _i63;
import '../../domain/use_cases/user_usecase.dart' as _i74;
import '../../presentations/bloc/attendance/attendance_bloc.dart' as _i5;
import '../../presentations/bloc/auth/auth_bloc.dart' as _i12;
import '../../presentations/bloc/checkin_setting/check_in_setting_bloc.dart'
    as _i17;
import '../../presentations/bloc/department/department_bloc.dart' as _i25;
import '../../presentations/bloc/login/login_bloc.dart' as _i33;
import '../../presentations/bloc/notes/notes_bloc.dart' as _i42;
import '../../presentations/bloc/personnel/personnel_bloc.dart' as _i43;
import '../../presentations/bloc/position/position_bloc.dart' as _i50;
import '../../presentations/bloc/register/register_bloc.dart' as _i57;
import '../../presentations/bloc/request/request/request_bloc.dart' as _i58;
import '../../presentations/bloc/request/room_meeting/room_meeting_bloc.dart'
    as _i65;
import '../../presentations/bloc/themes/language_cubit.dart' as _i32;
import '../../presentations/bloc/themes/theme_cubit.dart' as _i66;
import '../../presentations/bloc/user/user/user_bloc.dart' as _i67;
import '../../presentations/bloc/user/user_by_manager/user_by_admin_bloc.dart'
    as _i68;
import '../../presentations/bloc/user/user_by_roles/user_by_roles_bloc.dart'
    as _i69;
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
    gh.lazySingleton<_i5.AttendanceBloc>(() => _i5.AttendanceBloc());
    gh.lazySingleton<_i6.AttendanceRepository>(
        () => _i7.AttendanceRepositoryImplement());
    gh.lazySingleton<_i8.AttendanceService>(
        () => _i9.AttendanceServiceImplement());
    gh.lazySingleton<_i10.AttendanceUseCase>(
        () => _i11.AttendanceUseCaseImplement());
    gh.lazySingleton<_i12.AuthBloc>(() => _i12.AuthBloc());
    gh.lazySingleton<_i13.AuthRepository>(() => _i14.AuthRepositoryImpl());
    gh.lazySingleton<_i15.AuthService>(() => _i16.AuthServiceImpl());
    gh.lazySingleton<_i17.CheckInSettingBloc>(() => _i17.CheckInSettingBloc());
    gh.lazySingleton<_i18.CheckInSettingRepository>(
        () => _i19.CheckInSettingRepositoryImpl());
    gh.lazySingleton<_i20.CheckInSettingService>(
        () => _i21.CheckInSettingServiceImpl());
    gh.lazySingleton<_i22.CheckInSettingUseCase>(
        () => _i23.CheckInSettingUseCaseImpl());
    gh.lazySingleton<_i24.CustomClient>(() => _i24.CustomClient());
    gh.lazySingleton<_i25.DepartmentBloc>(() => _i25.DepartmentBloc());
    gh.lazySingleton<_i26.DepartmentRepository>(
        () => _i27.DepartmentRepositoryImpl());
    gh.lazySingleton<_i28.DepartmentService>(
        () => _i29.DepartmentServiceImpl());
    gh.lazySingleton<_i30.DepartmentUseCase>(
        () => _i31.DepartmentUseCaseImpl());
    gh.lazySingleton<_i32.LanguageCubit>(() => _i32.LanguageCubit());
    gh.lazySingleton<_i33.LoginBloc>(() => _i33.LoginBloc());
    gh.lazySingleton<_i34.LoginUseCase>(() => _i35.LoginUseCaseImpl());
    gh.lazySingleton<_i36.NoteRepository>(() => _i37.NoteRepositoryImpl());
    gh.lazySingleton<_i38.NoteService>(() => _i39.NoteServiceImpl());
    gh.lazySingleton<_i40.NoteUseCase>(() => _i41.NoteUseCaseImpl());
    gh.lazySingleton<_i42.NotesBloc>(() => _i42.NotesBloc());
    gh.lazySingleton<_i43.PersonnelBloc>(() => _i43.PersonnelBloc());
    gh.lazySingleton<_i44.PersonnelRepository>(
        () => _i45.PersonnelRepositoryImpl());
    gh.lazySingleton<_i46.PersonnelService>(() => _i47.PersonnelServiceImpl());
    gh.lazySingleton<_i48.PersonnelUseCase>(() => _i49.PersonnelUseCaseImpl());
    gh.lazySingleton<_i50.PositionBloc>(() => _i50.PositionBloc());
    gh.lazySingleton<_i51.PositionRepository>(
        () => _i52.PositionRepositoryImpl());
    gh.lazySingleton<_i53.PositionService>(() => _i54.PositionServiceImpl());
    gh.lazySingleton<_i55.PositionUseCase>(() => _i56.PositionUseCaseImpl());
    gh.lazySingleton<_i57.RegisterBloc>(() => _i57.RegisterBloc());
    gh.lazySingleton<_i58.RequestBloc>(() => _i58.RequestBloc());
    gh.lazySingleton<_i59.RequestRepository>(
        () => _i60.RequestRepositoryImplement());
    gh.lazySingleton<_i61.RequestService>(() => _i62.RequestServiceImpl());
    gh.lazySingleton<_i63.RequestUseCase>(() => _i64.RequestUseCaseImplement());
    gh.lazySingleton<_i65.RoomMeetingBloc>(() => _i65.RoomMeetingBloc());
    gh.lazySingleton<_i66.ThemeCubit>(() => _i66.ThemeCubit());
    gh.lazySingleton<_i67.UserBloc>(() => _i67.UserBloc());
    gh.lazySingleton<_i68.UserByAdminBloc>(() => _i68.UserByAdminBloc());
    gh.lazySingleton<_i69.UserByRolesBloc>(() => _i69.UserByRolesBloc());
    gh.lazySingleton<_i70.UserRepository>(() => _i71.UserRepositoryImpl());
    gh.lazySingleton<_i72.UserService>(() => _i73.UserServiceImpl());
    gh.lazySingleton<_i74.UserUseCase>(() => _i75.UserUseCaseImpl());
    return this;
  }
}
