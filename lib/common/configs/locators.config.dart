// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:encrypt_shared_preferences/provider.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i19;

import '../../data/repositories/attendances_repository.implement.dart' as _i61;
import '../../data/repositories/auth_repository.implement.dart' as _i64;
import '../../data/repositories/check_in_setting_repository.implement.dart'
    as _i66;
import '../../data/repositories/department_repository.implement.dart' as _i69;
import '../../data/repositories/location_repository.implement.dart' as _i76;
import '../../data/repositories/note_repository.implement.dart' as _i80;
import '../../data/repositories/notification_repository.implement.dart' as _i83;
import '../../data/repositories/personnel_repository.implement.dart' as _i86;
import '../../data/repositories/position_repository.implement.dart' as _i89;
import '../../data/repositories/request_repository.implement.dart' as _i92;
import '../../data/repositories/requisition_repository.implement.dart' as _i53;
import '../../data/repositories/user_repositoryimplement.dart' as _i102;
import '../../data/repositories/work_and_salary_repository.implement.dart'
    as _i58;
import '../../data/source/api/client/auth_api_client.dart' as _i40;
import '../../data/source/api/client/base_url_api_client.dart' as _i42;
import '../../data/source/api/client/non_auth_api_client.dart' as _i14;
import '../../data/source/api/client/notification_api_client.dart' as _i47;
import '../../data/source/api/client/refresh_token_api_client.dart' as _i28;
import '../../data/source/api/client/request_api_client.dart' as _i31;
import '../../data/source/api/client/request_url_api_client.dart' as _i32;
import '../../data/source/api/client/system_api_client.dart' as _i34;
import '../../data/source/api/client/system_gate_way_api_client.dart' as _i35;
import '../../data/source/api/client/url_file_api_client.dart' as _i36;
import '../../data/source/api/client/user_api_client.dart' as _i37;
import '../../data/source/api/mapper/error/json_object_error_response_mapper.dart'
    as _i11;
import '../../data/source/api/middleware/access_token_interceptor.dart' as _i27;
import '../../data/source/api/middleware/connectivity_interceptor.dart' as _i8;
import '../../data/source/api/middleware/header_interceptor.dart' as _i10;
import '../../data/source/api/middleware/refresh_token_interceptor.dart'
    as _i30;
import '../../data/source/api/services/attendances_service.dart' as _i39;
import '../../data/source/api/services/auth_service.dart' as _i41;
import '../../data/source/api/services/check_in_setting_service.dart' as _i43;
import '../../data/source/api/services/department_service.dart' as _i44;
import '../../data/source/api/services/location_service.dart' as _i45;
import '../../data/source/api/services/note_service.dart' as _i46;
import '../../data/source/api/services/notification_service.dart' as _i48;
import '../../data/source/api/services/personnel_service.dart' as _i49;
import '../../data/source/api/services/position_service.dart' as _i50;
import '../../data/source/api/services/refresh_token_api_service.dart' as _i29;
import '../../data/source/api/services/request_service.dart' as _i51;
import '../../data/source/api/services/requisition_service.dart' as _i33;
import '../../data/source/api/services/user_service.dart' as _i56;
import '../../data/source/api/services/work_and_salary_service.dart' as _i38;
import '../../data/source/preference/preference.dart' as _i26;
import '../../domain/repositories/attendances.repository.dart' as _i60;
import '../../domain/repositories/auth.repository.dart' as _i63;
import '../../domain/repositories/check_in_setting.repository.dart' as _i65;
import '../../domain/repositories/department.repository.dart' as _i68;
import '../../domain/repositories/location.repositories.dart' as _i75;
import '../../domain/repositories/note.repositories.dart' as _i79;
import '../../domain/repositories/notification_repository.dart' as _i82;
import '../../domain/repositories/personnel.repository.dart' as _i85;
import '../../domain/repositories/position.repository.dart' as _i88;
import '../../domain/repositories/request.repository.dart' as _i91;
import '../../domain/repositories/requisition.repository.dart' as _i52;
import '../../domain/repositories/user.repositories.dart' as _i101;
import '../../domain/repositories/work_and_salary.repositories.dart' as _i57;
import '../../domain/use_cases/attendances_usecase.dart' as _i62;
import '../../domain/use_cases/check_in_setting_usecase.dart' as _i67;
import '../../domain/use_cases/department_usecase.dart' as _i70;
import '../../domain/use_cases/get_init_app_usecase.dart' as _i72;
import '../../domain/use_cases/location_usecase.dart' as _i77;
import '../../domain/use_cases/login_usecase.dart' as _i78;
import '../../domain/use_cases/note_usecase.dart' as _i81;
import '../../domain/use_cases/notification_usecase.dart' as _i84;
import '../../domain/use_cases/personnel_usecase.dart' as _i87;
import '../../domain/use_cases/position_usecase.dart' as _i90;
import '../../domain/use_cases/request_usecase.dart' as _i93;
import '../../domain/use_cases/requisition_usecase.dart' as _i54;
import '../../domain/use_cases/user_usecase.dart' as _i103;
import '../../domain/use_cases/work_and_salary_usecase.dart' as _i59;
import '../../presentations/bloc/attendance/attendance_bloc.dart' as _i107;
import '../../presentations/bloc/auth/auth_bloc.dart' as _i5;
import '../../presentations/bloc/biometric/biometric_cubit.dart' as _i6;
import '../../presentations/bloc/check_in_check_out_gps/check_in_check_out_gps_bloc.dart'
    as _i108;
import '../../presentations/bloc/checkin_setting/check_in_setting_bloc.dart'
    as _i7;
import '../../presentations/bloc/department/department_bloc.dart' as _i109;
import '../../presentations/bloc/language/language_cubit.dart' as _i12;
import '../../presentations/bloc/leave/leave_history/leave_history_bloc.dart'
    as _i73;
import '../../presentations/bloc/leave/work_and_salary/work_and_salary_bloc.dart'
    as _i104;
import '../../presentations/bloc/location/address/address_bloc.dart' as _i106;
import '../../presentations/bloc/location/schedule_school/schedule_school_bloc.dart'
    as _i98;
import '../../presentations/bloc/location/school/school_bloc.dart' as _i99;
import '../../presentations/bloc/login/login_bloc.dart' as _i13;
import '../../presentations/bloc/notes/notes_system_cubit.dart' as _i110;
import '../../presentations/bloc/notification/notification_bloc.dart' as _i15;
import '../../presentations/bloc/personnel/personnel_bloc.dart' as _i16;
import '../../presentations/bloc/position/position_bloc.dart' as _i17;
import '../../presentations/bloc/register/register_bloc.dart' as _i18;
import '../../presentations/bloc/requisition/flow/flow_bloc.dart' as _i71;
import '../../presentations/bloc/requisition/leave_shift/leave_shift_bloc.dart'
    as _i74;
import '../../presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_bloc.dart'
    as _i94;
import '../../presentations/bloc/requisition/requisition/requisition_bloc.dart'
    as _i96;
import '../../presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart'
    as _i95;
import '../../presentations/bloc/requisition/requisiton_following/requisition_following_bloc.dart'
    as _i97;
import '../../presentations/bloc/requisition/stationery/stationery_bloc.dart'
    as _i55;
import '../../presentations/bloc/shift/shift_bloc.dart' as _i100;
import '../../presentations/bloc/themes/theme_cubit.dart' as _i20;
import '../../presentations/bloc/user/user/user_bloc.dart' as _i21;
import '../../presentations/bloc/user/user_by_id/user_by_id_bloc.dart' as _i22;
import '../../presentations/bloc/user/user_by_name/user_by_name_bloc.dart'
    as _i23;
import '../../presentations/bloc/user/user_by_roles/user_by_roles_bloc.dart'
    as _i24;
import '../../presentations/bloc/work_day/work_day_bloc.dart' as _i105;
import '../../presentations/bloc/work_sheet/work_sheet_bloc.dart' as _i25;
import '../routers/navigation.dart' as _i3;
import '../routers/router.dart' as _i4;
import 'locators.dart' as _i111;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.lazySingleton<_i3.AppNavigation>(() => _i3.AppNavigation());
    gh.lazySingleton<_i4.AppRouters>(() => _i4.AppRouters());
    gh.lazySingleton<_i5.AuthBloc>(() => _i5.AuthBloc());
    gh.lazySingleton<_i6.BiometricCubit>(() => _i6.BiometricCubit());
    gh.lazySingleton<_i7.CheckInSettingBloc>(() => _i7.CheckInSettingBloc());
    gh.factory<_i8.ConnectivityInterceptor>(
        () => _i8.ConnectivityInterceptor());
    await gh.factoryAsync<_i9.EncryptedSharedPreferences>(
      () => appModule.prefs2,
      preResolve: true,
    );
    gh.factory<_i10.HeaderInterceptor>(() => _i10.HeaderInterceptor());
    gh.factory<_i11.JsonArrayErrorResponseMapper>(
        () => _i11.JsonArrayErrorResponseMapper());
    gh.lazySingleton<_i12.LanguageCubit>(() => _i12.LanguageCubit());
    gh.lazySingleton<_i13.LoginBloc>(() => _i13.LoginBloc());
    gh.lazySingleton<_i14.NoneAuthAppServerApiClient>(
        () => _i14.NoneAuthAppServerApiClient(gh<_i10.HeaderInterceptor>()));
    gh.lazySingleton<_i15.NotificationBloc>(() => _i15.NotificationBloc());
    gh.lazySingleton<_i16.PersonnelBloc>(() => _i16.PersonnelBloc());
    gh.lazySingleton<_i17.PositionBloc>(() => _i17.PositionBloc());
    gh.lazySingleton<_i18.RegisterBloc>(() => _i18.RegisterBloc());
    await gh.factoryAsync<_i19.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i20.ThemeCubit>(() => _i20.ThemeCubit());
    gh.lazySingleton<_i21.UserBloc>(() => _i21.UserBloc());
    gh.lazySingleton<_i22.UserByIdBloc>(() => _i22.UserByIdBloc());
    gh.lazySingleton<_i23.UserByNameBloc>(() => _i23.UserByNameBloc());
    gh.lazySingleton<_i24.UserByRolesBloc>(() => _i24.UserByRolesBloc());
    gh.lazySingleton<_i25.WorkSheetBloc>(() => _i25.WorkSheetBloc());
    gh.lazySingleton<_i26.AppPreferences>(() => _i26.AppPreferences(
          gh<_i19.SharedPreferences>(),
          gh<_i9.EncryptedSharedPreferences>(),
        ));
    gh.factory<_i27.AccessTokenInterceptor>(
        () => _i27.AccessTokenInterceptor(gh<_i26.AppPreferences>()));
    gh.lazySingleton<_i28.RefreshTokenApiClient>(
        () => _i28.RefreshTokenApiClient(
              gh<_i10.HeaderInterceptor>(),
              gh<_i27.AccessTokenInterceptor>(),
            ));
    gh.lazySingleton<_i29.RefreshTokenApiService>(
        () => _i29.RefreshTokenApiService(gh<_i28.RefreshTokenApiClient>()));
    gh.lazySingleton<_i30.RefreshTokenInterceptor>(
        () => _i30.RefreshTokenInterceptor(
              gh<_i26.AppPreferences>(),
              gh<_i29.RefreshTokenApiService>(),
              gh<_i14.NoneAuthAppServerApiClient>(),
            ));
    gh.lazySingleton<_i31.RequestApiClient>(() => _i31.RequestApiClient(
          gh<_i10.HeaderInterceptor>(),
          gh<_i27.AccessTokenInterceptor>(),
          gh<_i30.RefreshTokenInterceptor>(),
        ));
    gh.lazySingleton<_i32.RequestUrlApiClient>(() => _i32.RequestUrlApiClient(
          gh<_i10.HeaderInterceptor>(),
          gh<_i27.AccessTokenInterceptor>(),
          gh<_i30.RefreshTokenInterceptor>(),
        ));
    gh.lazySingleton<_i33.RequisitionService>(
        () => _i33.RequisitionService(gh<_i31.RequestApiClient>()));
    gh.lazySingleton<_i34.SystemApiClient>(() => _i34.SystemApiClient(
          gh<_i10.HeaderInterceptor>(),
          gh<_i27.AccessTokenInterceptor>(),
          gh<_i30.RefreshTokenInterceptor>(),
        ));
    gh.lazySingleton<_i35.SystemGateWayApiClient>(
        () => _i35.SystemGateWayApiClient(
              gh<_i10.HeaderInterceptor>(),
              gh<_i27.AccessTokenInterceptor>(),
              gh<_i30.RefreshTokenInterceptor>(),
            ));
    gh.lazySingleton<_i36.UrlFileApiClient>(() => _i36.UrlFileApiClient(
          gh<_i10.HeaderInterceptor>(),
          gh<_i27.AccessTokenInterceptor>(),
          gh<_i30.RefreshTokenInterceptor>(),
        ));
    gh.lazySingleton<_i37.UserApiClient>(() => _i37.UserApiClient(
          gh<_i10.HeaderInterceptor>(),
          gh<_i27.AccessTokenInterceptor>(),
          gh<_i30.RefreshTokenInterceptor>(),
        ));
    gh.lazySingleton<_i38.WorkAndSalaryService>(() => _i38.WorkAndSalaryService(
          gh<_i37.UserApiClient>(),
          gh<_i34.SystemApiClient>(),
        ));
    gh.lazySingleton<_i39.AttendanceService>(
        () => _i39.AttendanceService(gh<_i37.UserApiClient>()));
    gh.lazySingleton<_i40.AuthApiClient>(() => _i40.AuthApiClient(
          gh<_i10.HeaderInterceptor>(),
          gh<_i27.AccessTokenInterceptor>(),
          gh<_i30.RefreshTokenInterceptor>(),
        ));
    gh.lazySingleton<_i41.AuthService>(
        () => _i41.AuthService(gh<_i40.AuthApiClient>()));
    gh.lazySingleton<_i42.BaseUrlApiClient>(() => _i42.BaseUrlApiClient(
          gh<_i10.HeaderInterceptor>(),
          gh<_i27.AccessTokenInterceptor>(),
          gh<_i30.RefreshTokenInterceptor>(),
        ));
    gh.lazySingleton<_i43.CheckInSettingService>(
        () => _i43.CheckInSettingService(gh<_i34.SystemApiClient>()));
    gh.lazySingleton<_i44.DepartmentService>(
        () => _i44.DepartmentService(gh<_i37.UserApiClient>()));
    gh.lazySingleton<_i45.LocationService>(() => _i45.LocationService(
          gh<_i35.SystemGateWayApiClient>(),
          gh<_i37.UserApiClient>(),
          gh<_i34.SystemApiClient>(),
        ));
    gh.lazySingleton<_i46.NoteService>(
        () => _i46.NoteService(gh<_i37.UserApiClient>()));
    gh.lazySingleton<_i47.NotificationApiClient>(
        () => _i47.NotificationApiClient(
              gh<_i10.HeaderInterceptor>(),
              gh<_i27.AccessTokenInterceptor>(),
              gh<_i30.RefreshTokenInterceptor>(),
            ));
    gh.lazySingleton<_i48.NotificationService>(
        () => _i48.NotificationService(gh<_i47.NotificationApiClient>()));
    gh.lazySingleton<_i49.PersonnelService>(
        () => _i49.PersonnelService(gh<_i40.AuthApiClient>()));
    gh.lazySingleton<_i50.PositionService>(
        () => _i50.PositionService(gh<_i37.UserApiClient>()));
    gh.lazySingleton<_i51.RequestService>(() => _i51.RequestService(
          gh<_i31.RequestApiClient>(),
          gh<_i37.UserApiClient>(),
          gh<_i36.UrlFileApiClient>(),
        ));
    gh.lazySingleton<_i52.RequisitionRepository>(() =>
        _i53.RequisitionRepositoryImplement(gh<_i33.RequisitionService>()));
    gh.factory<_i54.RequisitionUseCase>(
        () => _i54.RequisitionUseCase(gh<_i52.RequisitionRepository>()));
    gh.lazySingleton<_i55.StationeryBloc>(
        () => _i55.StationeryBloc(gh<_i54.RequisitionUseCase>()));
    gh.lazySingleton<_i56.UserService>(() => _i56.UserService(
          gh<_i40.AuthApiClient>(),
          gh<_i37.UserApiClient>(),
        ));
    gh.lazySingleton<_i57.WorkAndSalaryRepository>(() =>
        _i58.WorkAndSalaryRepositoryImplement(gh<_i38.WorkAndSalaryService>()));
    gh.factory<_i59.WorkAndSalaryUseCase>(
        () => _i59.WorkAndSalaryUseCase(gh<_i57.WorkAndSalaryRepository>()));
    gh.lazySingleton<_i60.AttendanceRepository>(
        () => _i61.AttendanceRepositoryImplement(gh<_i39.AttendanceService>()));
    gh.factory<_i62.AttendanceUseCase>(
        () => _i62.AttendanceUseCase(gh<_i60.AttendanceRepository>()));
    gh.lazySingleton<_i63.AuthRepository>(() => _i64.AuthRepositoryImpl(
          gh<_i41.AuthService>(),
          gh<_i26.AppPreferences>(),
        ));
    gh.lazySingleton<_i65.CheckInSettingRepository>(() =>
        _i66.CheckInSettingRepositoryImpl(gh<_i43.CheckInSettingService>()));
    gh.factory<_i67.CheckInSettingUseCase>(
        () => _i67.CheckInSettingUseCase(gh<_i65.CheckInSettingRepository>()));
    gh.lazySingleton<_i68.DepartmentRepository>(
        () => _i69.DepartmentRepositoryImpl(gh<_i44.DepartmentService>()));
    gh.factory<_i70.DepartmentUseCase>(
        () => _i70.DepartmentUseCase(gh<_i68.DepartmentRepository>()));
    gh.lazySingleton<_i71.FlowBloc>(
        () => _i71.FlowBloc(gh<_i54.RequisitionUseCase>()));
    gh.factory<_i72.GetInitAppUseCase>(
        () => _i72.GetInitAppUseCase(gh<_i63.AuthRepository>()));
    gh.lazySingleton<_i73.LeaveHistoryBloc>(
        () => _i73.LeaveHistoryBloc(gh<_i59.WorkAndSalaryUseCase>()));
    gh.lazySingleton<_i74.LeaveShiftBloc>(
        () => _i74.LeaveShiftBloc(gh<_i59.WorkAndSalaryUseCase>()));
    gh.lazySingleton<_i75.LocationRepository>(
        () => _i76.LocationRepositoryImpl(gh<_i45.LocationService>()));
    gh.factory<_i77.LocationUseCase>(
        () => _i77.LocationUseCase(gh<_i75.LocationRepository>()));
    gh.factory<_i78.LoginUseCase>(
        () => _i78.LoginUseCase(gh<_i63.AuthRepository>()));
    gh.lazySingleton<_i79.NoteRepository>(
        () => _i80.NoteRepositoryImpl(gh<_i46.NoteService>()));
    gh.factory<_i81.NoteUseCase>(
        () => _i81.NoteUseCase(gh<_i79.NoteRepository>()));
    gh.lazySingleton<_i82.NotificationRepository>(
        () => _i83.NotificationRepositoryImpl(gh<_i48.NotificationService>()));
    gh.factory<_i84.NotificationUseCase>(
        () => _i84.NotificationUseCase(gh<_i82.NotificationRepository>()));
    gh.lazySingleton<_i85.PersonnelRepository>(
        () => _i86.PersonnelRepositoryImpl(gh<_i49.PersonnelService>()));
    gh.factory<_i87.PersonnelUseCase>(
        () => _i87.PersonnelUseCase(gh<_i85.PersonnelRepository>()));
    gh.lazySingleton<_i88.PositionRepository>(
        () => _i89.PositionRepositoryImpl(gh<_i50.PositionService>()));
    gh.factory<_i90.PositionUseCase>(
        () => _i90.PositionUseCase(gh<_i88.PositionRepository>()));
    gh.lazySingleton<_i91.RequestRepository>(
        () => _i92.RequestRepositoryImplement(gh<_i51.RequestService>()));
    gh.factory<_i93.RequestUseCase>(
        () => _i93.RequestUseCase(gh<_i91.RequestRepository>()));
    gh.lazySingleton<_i94.RequestWorkSheetBloc>(
        () => _i94.RequestWorkSheetBloc(gh<_i54.RequisitionUseCase>()));
    gh.lazySingleton<_i95.RequisitionApproveBloc>(
        () => _i95.RequisitionApproveBloc(gh<_i54.RequisitionUseCase>()));
    gh.lazySingleton<_i96.RequisitionBloc>(() => _i96.RequisitionBloc(
          gh<_i54.RequisitionUseCase>(),
          gh<_i93.RequestUseCase>(),
        ));
    gh.lazySingleton<_i97.RequisitionFollowingBloc>(
        () => _i97.RequisitionFollowingBloc(gh<_i54.RequisitionUseCase>()));
    gh.lazySingleton<_i98.ScheduleSchoolBloc>(
        () => _i98.ScheduleSchoolBloc(gh<_i77.LocationUseCase>()));
    gh.lazySingleton<_i99.SchoolBloc>(
        () => _i99.SchoolBloc(gh<_i77.LocationUseCase>()));
    gh.lazySingleton<_i100.ShiftBloc>(
        () => _i100.ShiftBloc(gh<_i77.LocationUseCase>()));
    gh.lazySingleton<_i101.UserRepository>(
        () => _i102.UserRepositoryImpl(gh<_i56.UserService>()));
    gh.factory<_i103.UserUseCase>(
        () => _i103.UserUseCase(gh<_i101.UserRepository>()));
    gh.lazySingleton<_i104.WorkAndSalaryBloc>(
        () => _i104.WorkAndSalaryBloc(gh<_i59.WorkAndSalaryUseCase>()));
    gh.lazySingleton<_i105.WorkDayBloc>(
        () => _i105.WorkDayBloc(gh<_i77.LocationUseCase>()));
    gh.lazySingleton<_i106.AddressBloc>(
        () => _i106.AddressBloc(gh<_i77.LocationUseCase>()));
    gh.lazySingleton<_i107.AttendanceBloc>(
        () => _i107.AttendanceBloc(gh<_i62.AttendanceUseCase>()));
    gh.lazySingleton<_i108.CheckInCheckOutGpsBloc>(
        () => _i108.CheckInCheckOutGpsBloc(gh<_i77.LocationUseCase>()));
    gh.lazySingleton<_i109.DepartmentBloc>(
        () => _i109.DepartmentBloc(gh<_i70.DepartmentUseCase>()));
    gh.lazySingleton<_i110.NoteSystemCubit>(
        () => _i110.NoteSystemCubit(gh<_i81.NoteUseCase>()));
    return this;
  }
}

class _$AppModule extends _i111.AppModule {}
