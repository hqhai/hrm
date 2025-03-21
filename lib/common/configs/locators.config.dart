// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:encrypt_shared_preferences/provider.dart' as _i930;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../data/repositories/attendances_repository.implement.dart' as _i21;
import '../../data/repositories/auth_repository.implement.dart' as _i660;
import '../../data/repositories/check_in_setting_repository.implement.dart'
    as _i551;
import '../../data/repositories/department_repository.implement.dart' as _i206;
import '../../data/repositories/location_repository.implement.dart' as _i524;
import '../../data/repositories/note_repository.implement.dart' as _i51;
import '../../data/repositories/notification_repository.implement.dart'
    as _i971;
import '../../data/repositories/personnel_repository.implement.dart' as _i86;
import '../../data/repositories/position_repository.implement.dart' as _i952;
import '../../data/repositories/request_repository.implement.dart' as _i521;
import '../../data/repositories/requisition_repository.implement.dart' as _i478;
import '../../data/repositories/user_repositoryimplement.dart' as _i235;
import '../../data/repositories/work_and_salary_repository.implement.dart'
    as _i793;
import '../../data/source/api/client/auth_api_client.dart' as _i368;
import '../../data/source/api/client/base_url_api_client.dart' as _i53;
import '../../data/source/api/client/non_auth_api_client.dart' as _i282;
import '../../data/source/api/client/notification_api_client.dart' as _i874;
import '../../data/source/api/client/refresh_token_api_client.dart' as _i1050;
import '../../data/source/api/client/request_api_client.dart' as _i959;
import '../../data/source/api/client/request_url_api_client.dart' as _i881;
import '../../data/source/api/client/system_api_client.dart' as _i602;
import '../../data/source/api/client/system_gate_way_api_client.dart' as _i798;
import '../../data/source/api/client/url_file_api_client.dart' as _i981;
import '../../data/source/api/client/user_api_client.dart' as _i1050;
import '../../data/source/api/mapper/error/json_object_error_response_mapper.dart'
    as _i29;
import '../../data/source/api/middleware/access_token_interceptor.dart'
    as _i689;
import '../../data/source/api/middleware/connectivity_interceptor.dart'
    as _i672;
import '../../data/source/api/middleware/header_interceptor.dart' as _i388;
import '../../data/source/api/middleware/refresh_token_interceptor.dart'
    as _i57;
import '../../data/source/api/services/attendances_service.dart' as _i400;
import '../../data/source/api/services/auth_service.dart' as _i296;
import '../../data/source/api/services/check_in_setting_service.dart' as _i940;
import '../../data/source/api/services/department_service.dart' as _i467;
import '../../data/source/api/services/location_service.dart' as _i717;
import '../../data/source/api/services/note_service.dart' as _i348;
import '../../data/source/api/services/notification_service.dart' as _i235;
import '../../data/source/api/services/personnel_service.dart' as _i569;
import '../../data/source/api/services/position_service.dart' as _i869;
import '../../data/source/api/services/refresh_token_api_service.dart' as _i593;
import '../../data/source/api/services/request_service.dart' as _i667;
import '../../data/source/api/services/requisition_service.dart' as _i735;
import '../../data/source/api/services/user_service.dart' as _i551;
import '../../data/source/api/services/work_and_salary_service.dart' as _i538;
import '../../data/source/preference/preference.dart' as _i928;
import '../../domain/repositories/attendances.repository.dart' as _i120;
import '../../domain/repositories/auth.repository.dart' as _i975;
import '../../domain/repositories/check_in_setting.repository.dart' as _i649;
import '../../domain/repositories/department.repository.dart' as _i822;
import '../../domain/repositories/location.repositories.dart' as _i192;
import '../../domain/repositories/note.repositories.dart' as _i55;
import '../../domain/repositories/notification_repository.dart' as _i1060;
import '../../domain/repositories/personnel.repository.dart' as _i796;
import '../../domain/repositories/position.repository.dart' as _i528;
import '../../domain/repositories/request.repository.dart' as _i635;
import '../../domain/repositories/requisition.repository.dart' as _i172;
import '../../domain/repositories/user.repositories.dart' as _i801;
import '../../domain/repositories/work_and_salary.repositories.dart' as _i336;
import '../../domain/use_cases/attendances_usecase.dart' as _i707;
import '../../domain/use_cases/check_in_setting_usecase.dart' as _i206;
import '../../domain/use_cases/department_usecase.dart' as _i103;
import '../../domain/use_cases/get_init_app_usecase.dart' as _i88;
import '../../domain/use_cases/location_usecase.dart' as _i927;
import '../../domain/use_cases/login_usecase.dart' as _i645;
import '../../domain/use_cases/note_usecase.dart' as _i845;
import '../../domain/use_cases/notification_usecase.dart' as _i701;
import '../../domain/use_cases/personnel_usecase.dart' as _i9;
import '../../domain/use_cases/position_usecase.dart' as _i751;
import '../../domain/use_cases/request_usecase.dart' as _i357;
import '../../domain/use_cases/requisition_usecase.dart' as _i739;
import '../../domain/use_cases/user_usecase.dart' as _i555;
import '../../domain/use_cases/work_and_salary_usecase.dart' as _i260;
import '../../presentations/bloc/attendance/attendance_bloc.dart' as _i841;
import '../../presentations/bloc/auth/auth_bloc.dart' as _i101;
import '../../presentations/bloc/biometric/biometric_cubit.dart' as _i212;
import '../../presentations/bloc/check_in_check_out_gps/check_in_check_out_gps_bloc.dart'
    as _i783;
import '../../presentations/bloc/checkin_setting/check_in_setting_bloc.dart'
    as _i139;
import '../../presentations/bloc/department/department_bloc.dart' as _i777;
import '../../presentations/bloc/language/language_cubit.dart' as _i595;
import '../../presentations/bloc/leave/leave_history/leave_history_bloc.dart'
    as _i759;
import '../../presentations/bloc/leave/work_and_salary/work_and_salary_bloc.dart'
    as _i633;
import '../../presentations/bloc/location/address/address_bloc.dart' as _i961;
import '../../presentations/bloc/location/schedule_school/schedule_school_bloc.dart'
    as _i527;
import '../../presentations/bloc/location/school/school_bloc.dart' as _i257;
import '../../presentations/bloc/login/login_bloc.dart' as _i387;
import '../../presentations/bloc/notes/notes_system_cubit.dart' as _i605;
import '../../presentations/bloc/notification/notification_bloc.dart' as _i44;
import '../../presentations/bloc/personnel/personnel_bloc.dart' as _i368;
import '../../presentations/bloc/position/position_bloc.dart' as _i383;
import '../../presentations/bloc/register/register_bloc.dart' as _i435;
import '../../presentations/bloc/requisition/flow/flow_bloc.dart' as _i276;
import '../../presentations/bloc/requisition/leave_shift/leave_shift_bloc.dart'
    as _i256;
import '../../presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_bloc.dart'
    as _i561;
import '../../presentations/bloc/requisition/requisition/requisition_bloc.dart'
    as _i809;
import '../../presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart'
    as _i134;
import '../../presentations/bloc/requisition/requisiton_following/requisition_following_bloc.dart'
    as _i313;
import '../../presentations/bloc/requisition/stationery/stationery_bloc.dart'
    as _i102;
import '../../presentations/bloc/shift/shift_bloc.dart' as _i74;
import '../../presentations/bloc/themes/theme_cubit.dart' as _i431;
import '../../presentations/bloc/user/user/user_bloc.dart' as _i987;
import '../../presentations/bloc/user/user_by_id/user_by_id_bloc.dart' as _i173;
import '../../presentations/bloc/user/user_by_name/user_by_name_bloc.dart'
    as _i945;
import '../../presentations/bloc/user/user_by_roles/user_by_roles_bloc.dart'
    as _i615;
import '../../presentations/bloc/work_day/work_day_bloc.dart' as _i662;
import '../../presentations/bloc/work_sheet/work_sheet_bloc.dart' as _i288;
import '../routers/navigation.dart' as _i888;
import '../routers/router.dart' as _i267;
import 'locators.dart' as _i156;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    await gh.factoryAsync<_i930.EncryptedSharedPreferences>(
      () => appModule.prefs2,
      preResolve: true,
    );
    gh.factory<_i388.HeaderInterceptor>(() => _i388.HeaderInterceptor());
    gh.factory<_i672.ConnectivityInterceptor>(
        () => _i672.ConnectivityInterceptor());
    gh.factory<_i29.JsonArrayErrorResponseMapper>(
        () => _i29.JsonArrayErrorResponseMapper());
    gh.lazySingleton<_i267.AppRouters>(() => _i267.AppRouters());
    gh.lazySingleton<_i888.AppNavigation>(() => _i888.AppNavigation());
    gh.lazySingleton<_i101.AuthBloc>(() => _i101.AuthBloc());
    gh.lazySingleton<_i44.NotificationBloc>(() => _i44.NotificationBloc());
    gh.lazySingleton<_i383.PositionBloc>(() => _i383.PositionBloc());
    gh.lazySingleton<_i595.LanguageCubit>(() => _i595.LanguageCubit());
    gh.lazySingleton<_i615.UserByRolesBloc>(() => _i615.UserByRolesBloc());
    gh.lazySingleton<_i987.UserBloc>(() => _i987.UserBloc());
    gh.lazySingleton<_i945.UserByNameBloc>(() => _i945.UserByNameBloc());
    gh.lazySingleton<_i173.UserByIdBloc>(() => _i173.UserByIdBloc());
    gh.lazySingleton<_i435.RegisterBloc>(() => _i435.RegisterBloc());
    gh.lazySingleton<_i212.BiometricCubit>(() => _i212.BiometricCubit());
    gh.lazySingleton<_i288.WorkSheetBloc>(() => _i288.WorkSheetBloc());
    gh.lazySingleton<_i139.CheckInSettingBloc>(
        () => _i139.CheckInSettingBloc());
    gh.lazySingleton<_i431.ThemeCubit>(() => _i431.ThemeCubit());
    gh.lazySingleton<_i368.PersonnelBloc>(() => _i368.PersonnelBloc());
    gh.lazySingleton<_i387.LoginBloc>(() => _i387.LoginBloc());
    gh.lazySingleton<_i928.AppPreferences>(() => _i928.AppPreferences(
          gh<_i460.SharedPreferences>(),
          gh<_i930.EncryptedSharedPreferences>(),
        ));
    gh.factory<_i689.AccessTokenInterceptor>(
        () => _i689.AccessTokenInterceptor(gh<_i928.AppPreferences>()));
    gh.lazySingleton<_i1050.RefreshTokenApiClient>(
        () => _i1050.RefreshTokenApiClient(
              gh<_i388.HeaderInterceptor>(),
              gh<_i689.AccessTokenInterceptor>(),
            ));
    gh.lazySingleton<_i593.RefreshTokenApiService>(
        () => _i593.RefreshTokenApiService(gh<_i1050.RefreshTokenApiClient>()));
    gh.lazySingleton<_i282.NoneAuthAppServerApiClient>(
        () => _i282.NoneAuthAppServerApiClient(gh<_i388.HeaderInterceptor>()));
    gh.factory<_i57.RefreshTokenInterceptor>(() => _i57.RefreshTokenInterceptor(
          gh<_i928.AppPreferences>(),
          gh<_i593.RefreshTokenApiService>(),
          gh<_i282.NoneAuthAppServerApiClient>(),
        ));
    gh.lazySingleton<_i981.UrlFileApiClient>(() => _i981.UrlFileApiClient(
          gh<_i388.HeaderInterceptor>(),
          gh<_i689.AccessTokenInterceptor>(),
          gh<_i57.RefreshTokenInterceptor>(),
        ));
    gh.lazySingleton<_i881.RequestUrlApiClient>(() => _i881.RequestUrlApiClient(
          gh<_i388.HeaderInterceptor>(),
          gh<_i689.AccessTokenInterceptor>(),
          gh<_i57.RefreshTokenInterceptor>(),
        ));
    gh.lazySingleton<_i798.SystemGateWayApiClient>(
        () => _i798.SystemGateWayApiClient(
              gh<_i388.HeaderInterceptor>(),
              gh<_i689.AccessTokenInterceptor>(),
              gh<_i57.RefreshTokenInterceptor>(),
            ));
    gh.lazySingleton<_i874.NotificationApiClient>(
        () => _i874.NotificationApiClient(
              gh<_i388.HeaderInterceptor>(),
              gh<_i689.AccessTokenInterceptor>(),
              gh<_i57.RefreshTokenInterceptor>(),
            ));
    gh.lazySingleton<_i602.SystemApiClient>(() => _i602.SystemApiClient(
          gh<_i388.HeaderInterceptor>(),
          gh<_i689.AccessTokenInterceptor>(),
          gh<_i57.RefreshTokenInterceptor>(),
        ));
    gh.lazySingleton<_i959.RequestApiClient>(() => _i959.RequestApiClient(
          gh<_i388.HeaderInterceptor>(),
          gh<_i689.AccessTokenInterceptor>(),
          gh<_i57.RefreshTokenInterceptor>(),
        ));
    gh.lazySingleton<_i368.AuthApiClient>(() => _i368.AuthApiClient(
          gh<_i388.HeaderInterceptor>(),
          gh<_i689.AccessTokenInterceptor>(),
          gh<_i57.RefreshTokenInterceptor>(),
        ));
    gh.lazySingleton<_i53.BaseUrlApiClient>(() => _i53.BaseUrlApiClient(
          gh<_i388.HeaderInterceptor>(),
          gh<_i689.AccessTokenInterceptor>(),
          gh<_i57.RefreshTokenInterceptor>(),
        ));
    gh.lazySingleton<_i1050.UserApiClient>(() => _i1050.UserApiClient(
          gh<_i388.HeaderInterceptor>(),
          gh<_i689.AccessTokenInterceptor>(),
          gh<_i57.RefreshTokenInterceptor>(),
        ));
    gh.lazySingleton<_i400.AttendanceService>(
        () => _i400.AttendanceService(gh<_i1050.UserApiClient>()));
    gh.lazySingleton<_i538.WorkAndSalaryService>(
        () => _i538.WorkAndSalaryService(
              gh<_i1050.UserApiClient>(),
              gh<_i602.SystemApiClient>(),
            ));
    gh.lazySingleton<_i467.DepartmentService>(
        () => _i467.DepartmentService(gh<_i1050.UserApiClient>()));
    gh.lazySingleton<_i869.PositionService>(
        () => _i869.PositionService(gh<_i1050.UserApiClient>()));
    gh.lazySingleton<_i348.NoteService>(
        () => _i348.NoteService(gh<_i1050.UserApiClient>()));
    gh.lazySingleton<_i940.CheckInSettingService>(
        () => _i940.CheckInSettingService(gh<_i602.SystemApiClient>()));
    gh.lazySingleton<_i120.AttendanceRepository>(() =>
        _i21.AttendanceRepositoryImplement(gh<_i400.AttendanceService>()));
    gh.lazySingleton<_i735.RequisitionService>(
        () => _i735.RequisitionService(gh<_i959.RequestApiClient>()));
    gh.lazySingleton<_i551.UserService>(() => _i551.UserService(
          gh<_i368.AuthApiClient>(),
          gh<_i1050.UserApiClient>(),
        ));
    gh.lazySingleton<_i717.LocationService>(() => _i717.LocationService(
          gh<_i798.SystemGateWayApiClient>(),
          gh<_i1050.UserApiClient>(),
          gh<_i602.SystemApiClient>(),
        ));
    gh.lazySingleton<_i649.CheckInSettingRepository>(() =>
        _i551.CheckInSettingRepositoryImpl(gh<_i940.CheckInSettingService>()));
    gh.lazySingleton<_i55.NoteRepository>(
        () => _i51.NoteRepositoryImpl(gh<_i348.NoteService>()));
    gh.lazySingleton<_i296.AuthService>(
        () => _i296.AuthService(gh<_i368.AuthApiClient>()));
    gh.lazySingleton<_i569.PersonnelService>(
        () => _i569.PersonnelService(gh<_i368.AuthApiClient>()));
    gh.lazySingleton<_i235.NotificationService>(
        () => _i235.NotificationService(gh<_i874.NotificationApiClient>()));
    gh.lazySingleton<_i667.RequestService>(() => _i667.RequestService(
          gh<_i959.RequestApiClient>(),
          gh<_i1050.UserApiClient>(),
          gh<_i981.UrlFileApiClient>(),
        ));
    gh.lazySingleton<_i822.DepartmentRepository>(
        () => _i206.DepartmentRepositoryImpl(gh<_i467.DepartmentService>()));
    gh.lazySingleton<_i635.RequestRepository>(
        () => _i521.RequestRepositoryImplement(gh<_i667.RequestService>()));
    gh.lazySingleton<_i336.WorkAndSalaryRepository>(() =>
        _i793.WorkAndSalaryRepositoryImplement(
            gh<_i538.WorkAndSalaryService>()));
    gh.factory<_i845.NoteUseCase>(
        () => _i845.NoteUseCase(gh<_i55.NoteRepository>()));
    gh.factory<_i707.AttendanceUseCase>(
        () => _i707.AttendanceUseCase(gh<_i120.AttendanceRepository>()));
    gh.lazySingleton<_i192.LocationRepository>(
        () => _i524.LocationRepositoryImpl(gh<_i717.LocationService>()));
    gh.lazySingleton<_i528.PositionRepository>(
        () => _i952.PositionRepositoryImpl(gh<_i869.PositionService>()));
    gh.lazySingleton<_i796.PersonnelRepository>(
        () => _i86.PersonnelRepositoryImpl(gh<_i569.PersonnelService>()));
    gh.lazySingleton<_i975.AuthRepository>(() => _i660.AuthRepositoryImpl(
          gh<_i296.AuthService>(),
          gh<_i928.AppPreferences>(),
        ));
    gh.lazySingleton<_i801.UserRepository>(
        () => _i235.UserRepositoryImpl(gh<_i551.UserService>()));
    gh.lazySingleton<_i172.RequisitionRepository>(() =>
        _i478.RequisitionRepositoryImplement(gh<_i735.RequisitionService>()));
    gh.lazySingleton<_i1060.NotificationRepository>(() =>
        _i971.NotificationRepositoryImpl(gh<_i235.NotificationService>()));
    gh.factory<_i206.CheckInSettingUseCase>(() =>
        _i206.CheckInSettingUseCase(gh<_i649.CheckInSettingRepository>()));
    gh.factory<_i103.DepartmentUseCase>(
        () => _i103.DepartmentUseCase(gh<_i822.DepartmentRepository>()));
    gh.factory<_i739.RequisitionUseCase>(
        () => _i739.RequisitionUseCase(gh<_i172.RequisitionRepository>()));
    gh.factory<_i927.LocationUseCase>(
        () => _i927.LocationUseCase(gh<_i192.LocationRepository>()));
    gh.factory<_i645.LoginUseCase>(
        () => _i645.LoginUseCase(gh<_i975.AuthRepository>()));
    gh.factory<_i88.GetInitAppUseCase>(
        () => _i88.GetInitAppUseCase(gh<_i975.AuthRepository>()));
    gh.factory<_i751.PositionUseCase>(
        () => _i751.PositionUseCase(gh<_i528.PositionRepository>()));
    gh.lazySingleton<_i841.AttendanceBloc>(
        () => _i841.AttendanceBloc(gh<_i707.AttendanceUseCase>()));
    gh.factory<_i701.NotificationUseCase>(
        () => _i701.NotificationUseCase(gh<_i1060.NotificationRepository>()));
    gh.lazySingleton<_i777.DepartmentBloc>(
        () => _i777.DepartmentBloc(gh<_i103.DepartmentUseCase>()));
    gh.lazySingleton<_i257.SchoolBloc>(
        () => _i257.SchoolBloc(gh<_i927.LocationUseCase>()));
    gh.lazySingleton<_i527.ScheduleSchoolBloc>(
        () => _i527.ScheduleSchoolBloc(gh<_i927.LocationUseCase>()));
    gh.lazySingleton<_i662.WorkDayBloc>(
        () => _i662.WorkDayBloc(gh<_i927.LocationUseCase>()));
    gh.lazySingleton<_i74.ShiftBloc>(
        () => _i74.ShiftBloc(gh<_i927.LocationUseCase>()));
    gh.factory<_i357.RequestUseCase>(
        () => _i357.RequestUseCase(gh<_i635.RequestRepository>()));
    gh.lazySingleton<_i102.StationeryBloc>(
        () => _i102.StationeryBloc(gh<_i739.RequisitionUseCase>()));
    gh.lazySingleton<_i313.RequisitionFollowingBloc>(
        () => _i313.RequisitionFollowingBloc(gh<_i739.RequisitionUseCase>()));
    gh.lazySingleton<_i561.RequestWorkSheetBloc>(
        () => _i561.RequestWorkSheetBloc(gh<_i739.RequisitionUseCase>()));
    gh.lazySingleton<_i134.RequisitionApproveBloc>(
        () => _i134.RequisitionApproveBloc(gh<_i739.RequisitionUseCase>()));
    gh.lazySingleton<_i276.FlowBloc>(
        () => _i276.FlowBloc(gh<_i739.RequisitionUseCase>()));
    gh.factory<_i555.UserUseCase>(
        () => _i555.UserUseCase(gh<_i801.UserRepository>()));
    gh.lazySingleton<_i605.NoteSystemCubit>(
        () => _i605.NoteSystemCubit(gh<_i845.NoteUseCase>()));
    gh.factory<_i9.PersonnelUseCase>(
        () => _i9.PersonnelUseCase(gh<_i796.PersonnelRepository>()));
    gh.lazySingleton<_i783.CheckInCheckOutGpsBloc>(
        () => _i783.CheckInCheckOutGpsBloc(gh<_i927.LocationUseCase>()));
    gh.lazySingleton<_i961.AddressBloc>(
        () => _i961.AddressBloc(gh<_i927.LocationUseCase>()));
    gh.factory<_i260.WorkAndSalaryUseCase>(
        () => _i260.WorkAndSalaryUseCase(gh<_i336.WorkAndSalaryRepository>()));
    gh.lazySingleton<_i256.LeaveShiftBloc>(
        () => _i256.LeaveShiftBloc(gh<_i260.WorkAndSalaryUseCase>()));
    gh.lazySingleton<_i633.WorkAndSalaryBloc>(
        () => _i633.WorkAndSalaryBloc(gh<_i260.WorkAndSalaryUseCase>()));
    gh.lazySingleton<_i759.LeaveHistoryBloc>(
        () => _i759.LeaveHistoryBloc(gh<_i260.WorkAndSalaryUseCase>()));
    gh.lazySingleton<_i809.RequisitionBloc>(() => _i809.RequisitionBloc(
          gh<_i739.RequisitionUseCase>(),
          gh<_i357.RequestUseCase>(),
        ));
    return this;
  }
}

class _$AppModule extends _i156.AppModule {}
