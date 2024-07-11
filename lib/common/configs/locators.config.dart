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
    as _i22;
import '../../data/repositories/department.repository.implement.dart' as _i30;
import '../../data/repositories/location.repository.implement.dart' as _i39;
import '../../data/repositories/note.repository.implement.dart' as _i48;
import '../../data/repositories/personnel.repository.implement.dart' as _i56;
import '../../data/repositories/position.repository.implement.dart' as _i63;
import '../../data/repositories/request.repository.implement.dart' as _i70;
import '../../data/repositories/requisition.repository.implement.dart' as _i79;
import '../../data/repositories/user.repository.implement.dart' as _i92;
import '../../data/repositories/work_and_salary.repository.implement.dart'
    as _i99;
import '../../data/services/attendances.service.implement.dart' as _i10;
import '../../data/services/auth.service.implement.dart' as _i17;
import '../../data/services/base.service.dart' as _i27;
import '../../data/services/check_in_setting.service.implement.dart' as _i24;
import '../../data/services/department.service.implement.dart' as _i32;
import '../../data/services/location.service.implement.dart' as _i41;
import '../../data/services/note.service.implement.dart' as _i50;
import '../../data/services/personnel.service.implement.dart' as _i58;
import '../../data/services/position.service.implement.dart' as _i65;
import '../../data/services/request.service.implement.dart' as _i72;
import '../../data/services/requisition.service.implement.dart' as _i81;
import '../../data/services/user.service.implement.dart' as _i94;
import '../../data/services/work_and_salary.service.implement.dart' as _i101;
import '../../data/use_cases/attendances_usecase.implement.dart' as _i12;
import '../../data/use_cases/check_in_setting_usecase.implement.dart' as _i26;
import '../../data/use_cases/department_usecase.implement.dart' as _i34;
import '../../data/use_cases/location.usecase.implement.dart' as _i43;
import '../../data/use_cases/login_usecase.implement.dart' as _i46;
import '../../data/use_cases/note_usecase.implement.dart' as _i52;
import '../../data/use_cases/personnel_usecase.implement.dart' as _i60;
import '../../data/use_cases/position_usecase.implement.dart' as _i67;
import '../../data/use_cases/request_usecase.implement.dart' as _i74;
import '../../data/use_cases/requisition.usecase.implement.dart' as _i83;
import '../../data/use_cases/user_usecase.implement.dart' as _i96;
import '../../data/use_cases/work_and_salary.usecase.implement.dart' as _i103;
import '../../domain/repositories/attendances.repository.dart' as _i7;
import '../../domain/repositories/auth.repository.dart' as _i14;
import '../../domain/repositories/check_in_setting.repository.dart' as _i21;
import '../../domain/repositories/department.repository.dart' as _i29;
import '../../domain/repositories/location.repositories.dart' as _i38;
import '../../domain/repositories/note.repositories.dart' as _i47;
import '../../domain/repositories/personnel.repository.dart' as _i55;
import '../../domain/repositories/position.repository.dart' as _i62;
import '../../domain/repositories/request.repository.dart' as _i69;
import '../../domain/repositories/requisition.repository.dart' as _i78;
import '../../domain/repositories/user.repositories.dart' as _i91;
import '../../domain/repositories/work_and_salary.repositories.dart' as _i98;
import '../../domain/services/attendances.service.dart' as _i9;
import '../../domain/services/auth.service.dart' as _i16;
import '../../domain/services/check_in_setting.service.dart' as _i23;
import '../../domain/services/department.service.dart' as _i31;
import '../../domain/services/location.service.dart' as _i40;
import '../../domain/services/note.service.dart' as _i49;
import '../../domain/services/personnel.service.dart' as _i57;
import '../../domain/services/position.service.dart' as _i64;
import '../../domain/services/request.service.dart' as _i71;
import '../../domain/services/requisition.service.dart' as _i80;
import '../../domain/services/user.service.dart' as _i93;
import '../../domain/services/work_and_salary.service.dart' as _i100;
import '../../domain/use_cases/attendances_usecase.dart' as _i11;
import '../../domain/use_cases/check_in_setting_usecase.dart' as _i25;
import '../../domain/use_cases/departments_usecase.dart' as _i33;
import '../../domain/use_cases/location.usecase.dart' as _i42;
import '../../domain/use_cases/login_usecase.dart' as _i45;
import '../../domain/use_cases/note.usecase.dart' as _i51;
import '../../domain/use_cases/personnel_usecase.dart' as _i59;
import '../../domain/use_cases/position_usecase.dart' as _i66;
import '../../domain/use_cases/request_usecase.dart' as _i73;
import '../../domain/use_cases/requisition.usecase.dart' as _i82;
import '../../domain/use_cases/user_usecase.dart' as _i95;
import '../../domain/use_cases/work_and_salary.usecase.dart' as _i102;
import '../../presentations/bloc/attendance/attendance_bloc.dart' as _i6;
import '../../presentations/bloc/auth/auth_bloc.dart' as _i13;
import '../../presentations/bloc/biometric/biometric_cubit.dart' as _i18;
import '../../presentations/bloc/check_in_check_out_gps/check_in_check_out_gps_bloc.dart'
    as _i19;
import '../../presentations/bloc/checkin_setting/check_in_setting_bloc.dart'
    as _i20;
import '../../presentations/bloc/department/department_bloc.dart' as _i28;
import '../../presentations/bloc/language/language_cubit.dart' as _i36;
import '../../presentations/bloc/leave/leave_history/leave_history_bloc.dart'
    as _i37;
import '../../presentations/bloc/leave/work_and_salary/work_and_salary_bloc.dart'
    as _i97;
import '../../presentations/bloc/location/address/address_bloc.dart' as _i3;
import '../../presentations/bloc/location/school/school_bloc.dart' as _i84;
import '../../presentations/bloc/login/login_bloc.dart' as _i44;
import '../../presentations/bloc/notes/notes_bloc.dart' as _i53;
import '../../presentations/bloc/personnel/personnel_bloc.dart' as _i54;
import '../../presentations/bloc/position/position_bloc.dart' as _i61;
import '../../presentations/bloc/register/register_bloc.dart' as _i68;
import '../../presentations/bloc/requisition/flow/flow_bloc.dart' as _i35;
import '../../presentations/bloc/requisition/requisition/requisition_bloc.dart'
    as _i76;
import '../../presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart'
    as _i75;
import '../../presentations/bloc/requisition/requisiton_following/requisition_following_bloc.dart'
    as _i77;
import '../../presentations/bloc/requisition/stationery/stationery_bloc.dart'
    as _i85;
import '../../presentations/bloc/themes/theme_cubit.dart' as _i86;
import '../../presentations/bloc/user/user/user_bloc.dart' as _i87;
import '../../presentations/bloc/user/user_by_id/user_by_id_bloc.dart' as _i88;
import '../../presentations/bloc/user/user_by_name/user_by_name_bloc.dart'
    as _i89;
import '../../presentations/bloc/user/user_by_roles/user_by_roles_bloc.dart'
    as _i90;
import '../../presentations/bloc/work_sheet/work_sheet_bloc.dart' as _i104;
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
    gh.lazySingleton<_i19.CheckInCheckOutGpsBloc>(
        () => _i19.CheckInCheckOutGpsBloc());
    gh.lazySingleton<_i20.CheckInSettingBloc>(() => _i20.CheckInSettingBloc());
    gh.lazySingleton<_i21.CheckInSettingRepository>(
        () => _i22.CheckInSettingRepositoryImpl());
    gh.lazySingleton<_i23.CheckInSettingService>(
        () => _i24.CheckInSettingServiceImpl());
    gh.lazySingleton<_i25.CheckInSettingUseCase>(
        () => _i26.CheckInSettingUseCaseImpl());
    gh.lazySingleton<_i27.CustomClient>(() => _i27.CustomClient());
    gh.lazySingleton<_i28.DepartmentBloc>(() => _i28.DepartmentBloc());
    gh.lazySingleton<_i29.DepartmentRepository>(
        () => _i30.DepartmentRepositoryImpl());
    gh.lazySingleton<_i31.DepartmentService>(
        () => _i32.DepartmentServiceImpl());
    gh.lazySingleton<_i33.DepartmentUseCase>(
        () => _i34.DepartmentUseCaseImpl());
    gh.lazySingleton<_i35.FlowBloc>(() => _i35.FlowBloc());
    gh.lazySingleton<_i36.LanguageCubit>(() => _i36.LanguageCubit());
    gh.lazySingleton<_i37.LeaveHistoryBloc>(() => _i37.LeaveHistoryBloc());
    gh.lazySingleton<_i38.LocationRepository>(
        () => _i39.LocationRepositoryImpl());
    gh.lazySingleton<_i40.LocationService>(() => _i41.LocationServiceImpl());
    gh.lazySingleton<_i42.LocationUseCase>(() => _i43.LocationUseCaseImpl());
    gh.lazySingleton<_i44.LoginBloc>(() => _i44.LoginBloc());
    gh.lazySingleton<_i45.LoginUseCase>(() => _i46.LoginUseCaseImpl());
    gh.lazySingleton<_i47.NoteRepository>(() => _i48.NoteRepositoryImpl());
    gh.lazySingleton<_i49.NoteService>(() => _i50.NoteServiceImpl());
    gh.lazySingleton<_i51.NoteUseCase>(() => _i52.NoteUseCaseImpl());
    gh.lazySingleton<_i53.NotesBloc>(() => _i53.NotesBloc());
    gh.lazySingleton<_i54.PersonnelBloc>(() => _i54.PersonnelBloc());
    gh.lazySingleton<_i55.PersonnelRepository>(
        () => _i56.PersonnelRepositoryImpl());
    gh.lazySingleton<_i57.PersonnelService>(() => _i58.PersonnelServiceImpl());
    gh.lazySingleton<_i59.PersonnelUseCase>(() => _i60.PersonnelUseCaseImpl());
    gh.lazySingleton<_i61.PositionBloc>(() => _i61.PositionBloc());
    gh.lazySingleton<_i62.PositionRepository>(
        () => _i63.PositionRepositoryImpl());
    gh.lazySingleton<_i64.PositionService>(() => _i65.PositionServiceImpl());
    gh.lazySingleton<_i66.PositionUseCase>(() => _i67.PositionUseCaseImpl());
    gh.lazySingleton<_i68.RegisterBloc>(() => _i68.RegisterBloc());
    gh.lazySingleton<_i69.RequestRepository>(
        () => _i70.RequestRepositoryImplement());
    gh.lazySingleton<_i71.RequestService>(() => _i72.RequestServiceImpl());
    gh.lazySingleton<_i73.RequestUseCase>(() => _i74.RequestUseCaseImplement());
    gh.lazySingleton<_i75.RequisitionApproveBloc>(
        () => _i75.RequisitionApproveBloc());
    gh.lazySingleton<_i76.RequisitionBloc>(() => _i76.RequisitionBloc());
    gh.lazySingleton<_i77.RequisitionFollowingBloc>(
        () => _i77.RequisitionFollowingBloc());
    gh.lazySingleton<_i78.RequisitionRepository>(
        () => _i79.RequisitionRepositoryImplement());
    gh.lazySingleton<_i80.RequisitionService>(
        () => _i81.RequisitionServiceImpl());
    gh.lazySingleton<_i82.RequisitionUseCase>(
        () => _i83.RequisitionUseCaseImpl());
    gh.lazySingleton<_i84.SchoolBloc>(() => _i84.SchoolBloc());
    gh.lazySingleton<_i85.StationeryBloc>(() => _i85.StationeryBloc());
    gh.lazySingleton<_i86.ThemeCubit>(() => _i86.ThemeCubit());
    gh.lazySingleton<_i87.UserBloc>(() => _i87.UserBloc());
    gh.lazySingleton<_i88.UserByIdBloc>(() => _i88.UserByIdBloc());
    gh.lazySingleton<_i89.UserByNameBloc>(() => _i89.UserByNameBloc());
    gh.lazySingleton<_i90.UserByRolesBloc>(() => _i90.UserByRolesBloc());
    gh.lazySingleton<_i91.UserRepository>(() => _i92.UserRepositoryImpl());
    gh.lazySingleton<_i93.UserService>(() => _i94.UserServiceImpl());
    gh.lazySingleton<_i95.UserUseCase>(() => _i96.UserUseCaseImpl());
    gh.lazySingleton<_i97.WorkAndSalaryBloc>(() => _i97.WorkAndSalaryBloc());
    gh.lazySingleton<_i98.WorkAndSalaryRepository>(
        () => _i99.WorkAndSalaryRepositoryImplement());
    gh.lazySingleton<_i100.WorkAndSalaryService>(
        () => _i101.WorkAndSalaryServiceImpl());
    gh.lazySingleton<_i102.WorkAndSalaryUseCase>(
        () => _i103.WorkAndSalaryUseCaseImplement());
    gh.lazySingleton<_i104.WorkSheetBloc>(() => _i104.WorkSheetBloc());
    return this;
  }
}
