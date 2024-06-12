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
    as _i21;
import '../../data/repositories/department.repository.implement.dart' as _i29;
import '../../data/repositories/location.repository.implement.dart' as _i37;
import '../../data/repositories/note.repository.implement.dart' as _i46;
import '../../data/repositories/personnel.repository.implement.dart' as _i54;
import '../../data/repositories/position.repository.implement.dart' as _i61;
import '../../data/repositories/request.repository.implement.dart' as _i69;
import '../../data/repositories/requisition.repository.implement.dart' as _i77;
import '../../data/repositories/user.repository.implement.dart' as _i88;
import '../../data/services/attendances.service.implement.dart' as _i10;
import '../../data/services/auth.service.implement.dart' as _i17;
import '../../data/services/base.service.dart' as _i26;
import '../../data/services/check_in_setting.service.implement.dart' as _i23;
import '../../data/services/department.service.implement.dart' as _i31;
import '../../data/services/location.service.implement.dart' as _i39;
import '../../data/services/note.service.implement.dart' as _i48;
import '../../data/services/personnel.service.implement.dart' as _i56;
import '../../data/services/position.service.implement.dart' as _i63;
import '../../data/services/request.service.implement.dart' as _i71;
import '../../data/services/user.service.implement.dart' as _i90;
import '../../data/use_cases/attendances_usecase.implement.dart' as _i12;
import '../../data/use_cases/check_in_setting_usecase.implement.dart' as _i25;
import '../../data/use_cases/department_usecase.implement.dart' as _i33;
import '../../data/use_cases/location.usecase.implement.dart' as _i41;
import '../../data/use_cases/login_usecase.implement.dart' as _i44;
import '../../data/use_cases/note_usecase.implement.dart' as _i50;
import '../../data/use_cases/personnel_usecase.implement.dart' as _i58;
import '../../data/use_cases/position_usecase.implement.dart' as _i65;
import '../../data/use_cases/request_usecase.implement.dart' as _i73;
import '../../data/use_cases/requisition.usecase.implement.dart' as _i79;
import '../../data/use_cases/user_usecase.implement.dart' as _i92;
import '../../domain/repositories/attendances.repository.dart' as _i7;
import '../../domain/repositories/auth.repository.dart' as _i14;
import '../../domain/repositories/check_in_setting.repository.dart' as _i20;
import '../../domain/repositories/department.repository.dart' as _i28;
import '../../domain/repositories/location.repositories.dart' as _i36;
import '../../domain/repositories/note.repositories.dart' as _i45;
import '../../domain/repositories/personnel.repository.dart' as _i53;
import '../../domain/repositories/position.repository.dart' as _i60;
import '../../domain/repositories/request.repository.dart' as _i68;
import '../../domain/repositories/requisition.repository.dart' as _i76;
import '../../domain/repositories/user.repositories.dart' as _i87;
import '../../domain/services/attendances.service.dart' as _i9;
import '../../domain/services/auth.service.dart' as _i16;
import '../../domain/services/check_in_setting.service.dart' as _i22;
import '../../domain/services/department.service.dart' as _i30;
import '../../domain/services/location.service.dart' as _i38;
import '../../domain/services/note.service.dart' as _i47;
import '../../domain/services/personnel.service.dart' as _i55;
import '../../domain/services/position.service.dart' as _i62;
import '../../domain/services/request.service.dart' as _i70;
import '../../domain/services/user.service.dart' as _i89;
import '../../domain/use_cases/attendances_usecase.dart' as _i11;
import '../../domain/use_cases/check_in_setting_usecase.dart' as _i24;
import '../../domain/use_cases/departments_usecase.dart' as _i32;
import '../../domain/use_cases/location.usecase.dart' as _i40;
import '../../domain/use_cases/login_usecase.dart' as _i43;
import '../../domain/use_cases/note.usecase.dart' as _i49;
import '../../domain/use_cases/personnel_usecase.dart' as _i57;
import '../../domain/use_cases/position_usecase.dart' as _i64;
import '../../domain/use_cases/request_usecase.dart' as _i72;
import '../../domain/use_cases/requisition.usecase.dart' as _i78;
import '../../domain/use_cases/user_usecase.dart' as _i91;
import '../../presentations/bloc/attendance/attendance_bloc.dart' as _i6;
import '../../presentations/bloc/auth/auth_bloc.dart' as _i13;
import '../../presentations/bloc/biometric/biometric_cubit.dart' as _i18;
import '../../presentations/bloc/checkin_setting/check_in_setting_bloc.dart'
    as _i19;
import '../../presentations/bloc/department/department_bloc.dart' as _i27;
import '../../presentations/bloc/language/language_cubit.dart' as _i35;
import '../../presentations/bloc/location/address/address_bloc.dart' as _i3;
import '../../presentations/bloc/login/login_bloc.dart' as _i42;
import '../../presentations/bloc/notes/notes_bloc.dart' as _i51;
import '../../presentations/bloc/personnel/personnel_bloc.dart' as _i52;
import '../../presentations/bloc/position/position_bloc.dart' as _i59;
import '../../presentations/bloc/register/register_bloc.dart' as _i66;
import '../../presentations/bloc/request/request/request_bloc.dart' as _i67;
import '../../presentations/bloc/request/room_meeting/room_meeting_bloc.dart'
    as _i80;
import '../../presentations/bloc/requisition/flow/flow_bloc.dart' as _i34;
import '../../presentations/bloc/requisition/requisition/requisition_bloc.dart'
    as _i75;
import '../../presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart'
    as _i74;
import '../../presentations/bloc/requisition/stationery/stationery_bloc.dart'
    as _i81;
import '../../presentations/bloc/themes/theme_cubit.dart' as _i82;
import '../../presentations/bloc/user/user/user_bloc.dart' as _i83;
import '../../presentations/bloc/user/user_by_manager/user_by_admin_bloc.dart'
    as _i84;
import '../../presentations/bloc/user/user_by_name/user_by_name_bloc.dart'
    as _i85;
import '../../presentations/bloc/user/user_by_roles/user_by_roles_bloc.dart'
    as _i86;
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
    gh.lazySingleton<_i18.BiometricCubit>(() => _i18.BiometricCubit());
    gh.lazySingleton<_i19.CheckInSettingBloc>(() => _i19.CheckInSettingBloc());
    gh.lazySingleton<_i20.CheckInSettingRepository>(
        () => _i21.CheckInSettingRepositoryImpl());
    gh.lazySingleton<_i22.CheckInSettingService>(
        () => _i23.CheckInSettingServiceImpl());
    gh.lazySingleton<_i24.CheckInSettingUseCase>(
        () => _i25.CheckInSettingUseCaseImpl());
    gh.lazySingleton<_i26.CustomClient>(() => _i26.CustomClient());
    gh.lazySingleton<_i27.DepartmentBloc>(() => _i27.DepartmentBloc());
    gh.lazySingleton<_i28.DepartmentRepository>(
        () => _i29.DepartmentRepositoryImpl());
    gh.lazySingleton<_i30.DepartmentService>(
        () => _i31.DepartmentServiceImpl());
    gh.lazySingleton<_i32.DepartmentUseCase>(
        () => _i33.DepartmentUseCaseImpl());
    gh.lazySingleton<_i34.FlowBloc>(() => _i34.FlowBloc());
    gh.lazySingleton<_i35.LanguageCubit>(() => _i35.LanguageCubit());
    gh.lazySingleton<_i36.LocationRepository>(
        () => _i37.LocationRepositoryImpl());
    gh.lazySingleton<_i38.LocationService>(() => _i39.LocationServiceImpl());
    gh.lazySingleton<_i40.LocationUseCase>(() => _i41.LocationUseCaseImpl());
    gh.lazySingleton<_i42.LoginBloc>(() => _i42.LoginBloc());
    gh.lazySingleton<_i43.LoginUseCase>(() => _i44.LoginUseCaseImpl());
    gh.lazySingleton<_i45.NoteRepository>(() => _i46.NoteRepositoryImpl());
    gh.lazySingleton<_i47.NoteService>(() => _i48.NoteServiceImpl());
    gh.lazySingleton<_i49.NoteUseCase>(() => _i50.NoteUseCaseImpl());
    gh.lazySingleton<_i51.NotesBloc>(() => _i51.NotesBloc());
    gh.lazySingleton<_i52.PersonnelBloc>(() => _i52.PersonnelBloc());
    gh.lazySingleton<_i53.PersonnelRepository>(
        () => _i54.PersonnelRepositoryImpl());
    gh.lazySingleton<_i55.PersonnelService>(() => _i56.PersonnelServiceImpl());
    gh.lazySingleton<_i57.PersonnelUseCase>(() => _i58.PersonnelUseCaseImpl());
    gh.lazySingleton<_i59.PositionBloc>(() => _i59.PositionBloc());
    gh.lazySingleton<_i60.PositionRepository>(
        () => _i61.PositionRepositoryImpl());
    gh.lazySingleton<_i62.PositionService>(() => _i63.PositionServiceImpl());
    gh.lazySingleton<_i64.PositionUseCase>(() => _i65.PositionUseCaseImpl());
    gh.lazySingleton<_i66.RegisterBloc>(() => _i66.RegisterBloc());
    gh.lazySingleton<_i67.RequestBloc>(() => _i67.RequestBloc());
    gh.lazySingleton<_i68.RequestRepository>(
        () => _i69.RequestRepositoryImplement());
    gh.lazySingleton<_i70.RequestService>(() => _i71.RequestServiceImpl());
    gh.lazySingleton<_i72.RequestUseCase>(() => _i73.RequestUseCaseImplement());
    gh.lazySingleton<_i74.RequisitionApproveBloc>(
        () => _i74.RequisitionApproveBloc());
    gh.lazySingleton<_i75.RequisitionBloc>(() => _i75.RequisitionBloc());
    gh.lazySingleton<_i76.RequisitionRepository>(
        () => _i77.RequisitionRepositoryImplement());
    gh.lazySingleton<_i78.RequisitionUseCase>(
        () => _i79.RequisitionUseCaseImpl());
    gh.lazySingleton<_i80.RoomMeetingBloc>(() => _i80.RoomMeetingBloc());
    gh.lazySingleton<_i81.StationeryBloc>(() => _i81.StationeryBloc());
    gh.lazySingleton<_i82.ThemeCubit>(() => _i82.ThemeCubit());
    gh.lazySingleton<_i83.UserBloc>(() => _i83.UserBloc());
    gh.lazySingleton<_i84.UserByAdminBloc>(() => _i84.UserByAdminBloc());
    gh.lazySingleton<_i85.UserByNameBloc>(() => _i85.UserByNameBloc());
    gh.lazySingleton<_i86.UserByRolesBloc>(() => _i86.UserByRolesBloc());
    gh.lazySingleton<_i87.UserRepository>(() => _i88.UserRepositoryImpl());
    gh.lazySingleton<_i89.UserService>(() => _i90.UserServiceImpl());
    gh.lazySingleton<_i91.UserUseCase>(() => _i92.UserUseCaseImpl());
    return this;
  }
}
