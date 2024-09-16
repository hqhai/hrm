import 'dart:async';

import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_event.dart';
import 'package:base_app/presentations/bloc/auth/auth_event.dart';
import 'package:base_app/presentations/bloc/auth/auth_state.dart';
import 'package:base_app/presentations/bloc/check_in_check_out_gps/check_in_check_out_gps_bloc.dart';
import 'package:base_app/presentations/bloc/check_in_check_out_gps/check_in_check_out_gps_event.dart';
import 'package:base_app/presentations/bloc/checkin_setting/check_in_setting_bloc.dart';
import 'package:base_app/presentations/bloc/checkin_setting/check_in_setting_event.dart';
import 'package:base_app/presentations/bloc/department/department_bloc.dart';
import 'package:base_app/presentations/bloc/department/department_event.dart';
import 'package:base_app/presentations/bloc/leave/leave_history/leave_history_bloc.dart';
import 'package:base_app/presentations/bloc/leave/leave_history/leave_history_event.dart';
import 'package:base_app/presentations/bloc/leave/work_and_salary/work_and_salary_bloc.dart';
import 'package:base_app/presentations/bloc/leave/work_and_salary/work_and_salary_event.dart';
import 'package:base_app/presentations/bloc/location/address/address_bloc.dart';
import 'package:base_app/presentations/bloc/location/address/address_event.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_bloc.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_event.dart';
import 'package:base_app/presentations/bloc/location/school/school_bloc.dart';
import 'package:base_app/presentations/bloc/location/school/school_event.dart';
import 'package:base_app/presentations/bloc/notes/notes_bloc.dart';
import 'package:base_app/presentations/bloc/notes/notes_event.dart';
import 'package:base_app/presentations/bloc/notification/notification_bloc.dart';
import 'package:base_app/presentations/bloc/notification/notification_event.dart';
import 'package:base_app/presentations/bloc/personnel/personnel_bloc.dart';
import 'package:base_app/presentations/bloc/personnel/personnel_event.dart';
import 'package:base_app/presentations/bloc/position/position_bloc.dart';
import 'package:base_app/presentations/bloc/position/position_event.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_event.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_event.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_event.dart';
import 'package:base_app/presentations/bloc/shift/shift_bloc.dart';
import 'package:base_app/presentations/bloc/shift/shift_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_event.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_event.dart';
import 'package:base_app/presentations/bloc/user/user_by_name/user_by_name_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_name/user_by_name_event.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_event.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_bloc.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_event.dart';
import 'package:base_app/presentations/bloc/work_sheet/work_sheet_bloc.dart';
import 'package:base_app/presentations/bloc/work_sheet/work_sheet_event.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState(status: AuthStatus.authInitial)) {
    on<AuthEvent>((event, emit) {});
    on<CheckAuthenticated>(_checkAuthenticated);
    on<LogoutEvent>(_logOut);
    on<ResetEvent>(_resetEvent);
  }

  FutureOr<void> _checkAuthenticated(CheckAuthenticated event, Emitter<AuthState> emit) async {
    String userToken, email, password;
    List<String> roles;
    if (event.loginResponse != null) {
      userToken = event.loginResponse!.accessToken;
      email = event.email;
      password = event.password;
      roles = event.loginResponse!.roles;
    } else {
      userToken = state.token;
      email = state.email;
      password = state.password;
      roles = state.roles;
    }
    try {
      if (userToken.isNotEmpty) {
        AppConfig.setToken(userToken);
        dI<UserBloc>().add(const GetUserInfo());

        emit(AuthState(
            status: AuthStatus.loggedIn,
            token: userToken,
            saveLogin: event.saveLogin,
            email: email,
            password: password,
            roles: roles));
      } else {
        emit(const AuthState(status: AuthStatus.unAuthentication));
      }
    } catch (e) {
      emit(const AuthState(status: AuthStatus.unAuthentication));
    }
  }

  FutureOr<void> _logOut(LogoutEvent event, Emitter<AuthState> emit) async {
    if (dI<AuthBloc>().state.saveLogin) {
      resetData();
      emit(AuthState(
          status: AuthStatus.unAuthentication, email: state.email, password: state.password));
    } else {
      resetData();
      emit(const AuthState(status: AuthStatus.unAuthentication));
    }
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toJson();
  }

  void _resetEvent(ResetEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(
        token:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VyTmFtZSI6Iml0QGF0bGFudGljLmVkdS52biIsIkZ1bGxOYW1lIjoiSFIgSFIiLCJFbWFpbCI6Iml0QGF0bGFudGljLmVkdS52biIsIlVzZXJJZCI6IjY0REYxOTRFLTY1QUItNEI0Mi04REE5LUI1QjE3NDQ0ODlBRCIsIlN1YiI6ImJhc2VXZWJBcGlTdWJqZWN0IiwiSnRpIjoiZGI2OGMwODAtMGY0My00NGU3LTk0ODYtMzQyZmUyMThmZjk4IiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiSFIiLCJSb2xlcyI6IkhSIiwiZXhwIjoxNzA0MzY0NTMxLCJpc3MiOiJiYXNlV2ViQXBpSXNzdWVyIiwiYXVkIjoiYmFzZVdlYkFwaUF1ZGllbmNlIn0.stIeNHtQuT7O5ajACVDnd4RjXOtG9KciSULDDuunZGU"));
  }
}

resetData() {
  AppConfig.setToken('');
  dI<UserBloc>().add(const ResetUserEvent());
  dI<UserByRolesBloc>().add(const ResetUsersEvent());
  dI<AttendanceBloc>().add(const ResetAttendanceEvent());
  dI<CheckInCheckOutGpsBloc>().add(const ResetCheckInCheckOutGpsEvent());
  dI<CheckInSettingBloc>().add(const ResetCheckInSettingEvent());
  dI<LeaveHistoryBloc>().add(const ResetLeaveHistoryEvent());
  dI<WorkAndSalaryBloc>().add(const ResetWorkAndSalaryEvent());
  dI<AddressBloc>().add(const ResetAddressEvent());
  dI<ScheduleSchoolBloc>().add(const ResetScheduleSchoolEvent());
  dI<SchoolBloc>().add(const ResetSchoolEvent());
  dI<NotesBloc>().add(const ResetNotesEvent());
  dI<PersonnelBloc>().add(const ResetPersonnelEvent());
  dI<NotificationBloc>().add(const ResetNotificationEvent());
  dI<PositionBloc>().add(const ResetPositionEvent());
  dI<FlowBloc>().add(const ResetFlowEvent());
  dI<LeaveShiftBloc>().add(const ResetLeaveShiftEvent());
  dI<RequestWorkSheetBloc>().add(const ResetRequestWorkSheetEvent());
  dI<RequisitionBloc>().add(const ResetRequisitionEvent());
  dI<RequisitionApproveBloc>().add(const ResetRequisitionApproveEvent());
  dI<RequisitionFollowingBloc>().add(const ResetRequisitionFollowingEvent());
  dI<ShiftBloc>().add(const ResetShiftEvent());
  dI<UserByIdBloc>().add(const ResetUserByIdEvent());
  dI<UserByNameBloc>().add(const ResetUserByNameEvent());
  dI<WorkDayBloc>().add(const ResetWorkDayEvent());
  dI<WorkSheetBloc>().add(const ResetWorkSheetEvent());
  dI<DepartmentBloc>().add(const ResetDepartmentEvent());
}
