// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/repositories/attendances_repository.implement.dart' as _i8;
import '../../data/repositories/auth_repository.implement.dart' as _i15;
import '../../data/repositories/check_in_setting_repository.implement.dart'
    as _i22;
import '../../data/repositories/department_repository.implement.dart' as _i30;
import '../../data/repositories/location_repository.implement.dart' as _i40;
import '../../data/repositories/note_repository.implement.dart' as _i49;
import '../../data/repositories/notification_repository.implement.dart' as _i57;
import '../../data/repositories/personnel_repository.implement.dart' as _i64;
import '../../data/repositories/position_repository.implement.dart' as _i71;
import '../../data/repositories/request_repository.implement.dart' as _i78;
import '../../data/repositories/requisition_repository.implement.dart' as _i88;
import '../../data/repositories/user_repositoryimplement.dart' as _i103;
import '../../data/repositories/work_and_salary_repository.implement.dart'
    as _i110;
import '../../data/services/attendances_service.implement.dart' as _i10;
import '../../data/services/auth_service.implement.dart' as _i17;
import '../../data/services/base.service.dart' as _i27;
import '../../data/services/check_in_setting_service.implement.dart' as _i24;
import '../../data/services/department_service.implement.dart' as _i32;
import '../../data/services/location_service.implement.dart' as _i42;
import '../../data/services/note_service.implement.dart' as _i51;
import '../../data/services/notification_service.implement.dart' as _i59;
import '../../data/services/personnel_service.implement.dart' as _i66;
import '../../data/services/position_service.implement.dart' as _i73;
import '../../data/services/request_service.implement.dart' as _i80;
import '../../data/services/requisition_service.implement.dart' as _i90;
import '../../data/services/user_service.implement.dart' as _i105;
import '../../data/services/work_and_salary_service.implement.dart' as _i112;
import '../../data/use_cases/attendances_usecase.implement.dart' as _i12;
import '../../data/use_cases/check_in_setting_usecase.implement.dart' as _i26;
import '../../data/use_cases/department_usecase.implement.dart' as _i34;
import '../../data/use_cases/location_usecase.implement.dart' as _i44;
import '../../data/use_cases/login_usecase.implement.dart' as _i47;
import '../../data/use_cases/note_usecase.implement.dart' as _i53;
import '../../data/use_cases/notification_usecase.implement.dart' as _i61;
import '../../data/use_cases/personnel_usecase.implement.dart' as _i68;
import '../../data/use_cases/position_usecase.implement.dart' as _i75;
import '../../data/use_cases/request_usecase.implement.dart' as _i82;
import '../../data/use_cases/requisition_usecase.implement.dart' as _i92;
import '../../data/use_cases/user_usecase.implement.dart' as _i107;
import '../../data/use_cases/work_and_salary.usecase.implement.dart' as _i114;
import '../../domain/repositories/attendances.repository.dart' as _i7;
import '../../domain/repositories/auth.repository.dart' as _i14;
import '../../domain/repositories/check_in_setting.repository.dart' as _i21;
import '../../domain/repositories/department.repository.dart' as _i29;
import '../../domain/repositories/location.repositories.dart' as _i39;
import '../../domain/repositories/note.repositories.dart' as _i48;
import '../../domain/repositories/notification_repository.dart' as _i56;
import '../../domain/repositories/personnel.repository.dart' as _i63;
import '../../domain/repositories/position.repository.dart' as _i70;
import '../../domain/repositories/request.repository.dart' as _i77;
import '../../domain/repositories/requisition.repository.dart' as _i87;
import '../../domain/repositories/user.repositories.dart' as _i102;
import '../../domain/repositories/work_and_salary.repositories.dart' as _i109;
import '../../domain/services/attendances.service.dart' as _i9;
import '../../domain/services/auth.service.dart' as _i16;
import '../../domain/services/check_in_setting.service.dart' as _i23;
import '../../domain/services/department.service.dart' as _i31;
import '../../domain/services/location.service.dart' as _i41;
import '../../domain/services/note.service.dart' as _i50;
import '../../domain/services/notification_service.dart' as _i58;
import '../../domain/services/personnel.service.dart' as _i65;
import '../../domain/services/position.service.dart' as _i72;
import '../../domain/services/request.service.dart' as _i79;
import '../../domain/services/requisition.service.dart' as _i89;
import '../../domain/services/user.service.dart' as _i104;
import '../../domain/services/work_and_salary.service.dart' as _i111;
import '../../domain/use_cases/attendances_usecase.dart' as _i11;
import '../../domain/use_cases/check_in_setting_usecase.dart' as _i25;
import '../../domain/use_cases/departments_usecase.dart' as _i33;
import '../../domain/use_cases/location.usecase.dart' as _i43;
import '../../domain/use_cases/login_usecase.dart' as _i46;
import '../../domain/use_cases/note.usecase.dart' as _i52;
import '../../domain/use_cases/notification_usecase.dart' as _i60;
import '../../domain/use_cases/personnel_usecase.dart' as _i67;
import '../../domain/use_cases/position_usecase.dart' as _i74;
import '../../domain/use_cases/request_usecase.dart' as _i81;
import '../../domain/use_cases/requisition.usecase.dart' as _i91;
import '../../domain/use_cases/user_usecase.dart' as _i106;
import '../../domain/use_cases/work_and_salary.usecase.dart' as _i113;
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
    as _i108;
import '../../presentations/bloc/location/address/address_bloc.dart' as _i3;
import '../../presentations/bloc/location/schedule_school/schedule_school_bloc.dart'
    as _i93;
import '../../presentations/bloc/location/school/school_bloc.dart' as _i94;
import '../../presentations/bloc/login/login_bloc.dart' as _i45;
import '../../presentations/bloc/notes/notes_bloc.dart' as _i54;
import '../../presentations/bloc/notification/notification_bloc.dart' as _i55;
import '../../presentations/bloc/personnel/personnel_bloc.dart' as _i62;
import '../../presentations/bloc/position/position_bloc.dart' as _i69;
import '../../presentations/bloc/register/register_bloc.dart' as _i76;
import '../../presentations/bloc/requisition/flow/flow_bloc.dart' as _i35;
import '../../presentations/bloc/requisition/leave_shift/leave_shift_bloc.dart'
    as _i38;
import '../../presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_bloc.dart'
    as _i83;
import '../../presentations/bloc/requisition/requisition/requisition_bloc.dart'
    as _i85;
import '../../presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart'
    as _i84;
import '../../presentations/bloc/requisition/requisiton_following/requisition_following_bloc.dart'
    as _i86;
import '../../presentations/bloc/requisition/stationery/stationery_bloc.dart'
    as _i96;
import '../../presentations/bloc/shift/shift_bloc.dart' as _i95;
import '../../presentations/bloc/themes/theme_cubit.dart' as _i97;
import '../../presentations/bloc/user/user/user_bloc.dart' as _i98;
import '../../presentations/bloc/user/user_by_id/user_by_id_bloc.dart' as _i99;
import '../../presentations/bloc/user/user_by_name/user_by_name_bloc.dart'
    as _i100;
import '../../presentations/bloc/user/user_by_roles/user_by_roles_bloc.dart'
    as _i101;
import '../../presentations/bloc/work_day/work_day_bloc.dart' as _i115;
import '../../presentations/bloc/work_sheet/work_sheet_bloc.dart' as _i116;
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
    gh.lazySingleton<_i38.LeaveShiftBloc>(() => _i38.LeaveShiftBloc());
    gh.lazySingleton<_i39.LocationRepository>(
        () => _i40.LocationRepositoryImpl());
    gh.lazySingleton<_i41.LocationService>(() => _i42.LocationServiceImpl());
    gh.lazySingleton<_i43.LocationUseCase>(() => _i44.LocationUseCaseImpl());
    gh.lazySingleton<_i45.LoginBloc>(() => _i45.LoginBloc());
    gh.lazySingleton<_i46.LoginUseCase>(() => _i47.LoginUseCaseImpl());
    gh.lazySingleton<_i48.NoteRepository>(() => _i49.NoteRepositoryImpl());
    gh.lazySingleton<_i50.NoteService>(() => _i51.NoteServiceImpl());
    gh.lazySingleton<_i52.NoteUseCase>(() => _i53.NoteUseCaseImpl());
    gh.lazySingleton<_i54.NotesBloc>(() => _i54.NotesBloc());
    gh.lazySingleton<_i55.NotificationBloc>(() => _i55.NotificationBloc());
    gh.lazySingleton<_i56.NotificationRepository>(
        () => _i57.NotificationRepositoryImpl());
    gh.lazySingleton<_i58.NotificationService>(
        () => _i59.NotificationServiceImpl());
    gh.lazySingleton<_i60.NotificationUseCase>(
        () => _i61.NotificationUseCaseImpl());
    gh.lazySingleton<_i62.PersonnelBloc>(() => _i62.PersonnelBloc());
    gh.lazySingleton<_i63.PersonnelRepository>(
        () => _i64.PersonnelRepositoryImpl());
    gh.lazySingleton<_i65.PersonnelService>(() => _i66.PersonnelServiceImpl());
    gh.lazySingleton<_i67.PersonnelUseCase>(() => _i68.PersonnelUseCaseImpl());
    gh.lazySingleton<_i69.PositionBloc>(() => _i69.PositionBloc());
    gh.lazySingleton<_i70.PositionRepository>(
        () => _i71.PositionRepositoryImpl());
    gh.lazySingleton<_i72.PositionService>(() => _i73.PositionServiceImpl());
    gh.lazySingleton<_i74.PositionUseCase>(() => _i75.PositionUseCaseImpl());
    gh.lazySingleton<_i76.RegisterBloc>(() => _i76.RegisterBloc());
    gh.lazySingleton<_i77.RequestRepository>(
        () => _i78.RequestRepositoryImplement());
    gh.lazySingleton<_i79.RequestService>(() => _i80.RequestServiceImpl());
    gh.lazySingleton<_i81.RequestUseCase>(() => _i82.RequestUseCaseImplement());
    gh.lazySingleton<_i83.RequestWorkSheetBloc>(
        () => _i83.RequestWorkSheetBloc());
    gh.lazySingleton<_i84.RequisitionApproveBloc>(
        () => _i84.RequisitionApproveBloc());
    gh.lazySingleton<_i85.RequisitionBloc>(() => _i85.RequisitionBloc());
    gh.lazySingleton<_i86.RequisitionFollowingBloc>(
        () => _i86.RequisitionFollowingBloc());
    gh.lazySingleton<_i87.RequisitionRepository>(
        () => _i88.RequisitionRepositoryImplement());
    gh.lazySingleton<_i89.RequisitionService>(
        () => _i90.RequisitionServiceImpl());
    gh.lazySingleton<_i91.RequisitionUseCase>(
        () => _i92.RequisitionUseCaseImpl());
    gh.lazySingleton<_i93.ScheduleSchoolBloc>(() => _i93.ScheduleSchoolBloc());
    gh.lazySingleton<_i94.SchoolBloc>(() => _i94.SchoolBloc());
    gh.lazySingleton<_i95.ShiftBloc>(() => _i95.ShiftBloc());
    gh.lazySingleton<_i96.StationeryBloc>(() => _i96.StationeryBloc());
    gh.lazySingleton<_i97.ThemeCubit>(() => _i97.ThemeCubit());
    gh.lazySingleton<_i98.UserBloc>(() => _i98.UserBloc());
    gh.lazySingleton<_i99.UserByIdBloc>(() => _i99.UserByIdBloc());
    gh.lazySingleton<_i100.UserByNameBloc>(() => _i100.UserByNameBloc());
    gh.lazySingleton<_i101.UserByRolesBloc>(() => _i101.UserByRolesBloc());
    gh.lazySingleton<_i102.UserRepository>(() => _i103.UserRepositoryImpl());
    gh.lazySingleton<_i104.UserService>(() => _i105.UserServiceImpl());
    gh.lazySingleton<_i106.UserUseCase>(() => _i107.UserUseCaseImpl());
    gh.lazySingleton<_i108.WorkAndSalaryBloc>(() => _i108.WorkAndSalaryBloc());
    gh.lazySingleton<_i109.WorkAndSalaryRepository>(
        () => _i110.WorkAndSalaryRepositoryImplement());
    gh.lazySingleton<_i111.WorkAndSalaryService>(
        () => _i112.WorkAndSalaryServiceImpl());
    gh.lazySingleton<_i113.WorkAndSalaryUseCase>(
        () => _i114.WorkAndSalaryUseCaseImplement());
    gh.lazySingleton<_i115.WorkDayBloc>(() => _i115.WorkDayBloc());
    gh.lazySingleton<_i116.WorkSheetBloc>(() => _i116.WorkSheetBloc());
    return this;
  }
}
