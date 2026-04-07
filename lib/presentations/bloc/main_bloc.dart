import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/auth/auth_bloc.dart';
import 'package:base_app/presentations/bloc/biometric/biometric_cubit.dart';
import 'package:base_app/presentations/bloc/check_in_check_out_gps/check_in_check_out_gps_bloc.dart';
import 'package:base_app/presentations/bloc/checkin_setting/check_in_setting_bloc.dart';
import 'package:base_app/presentations/bloc/department/department_bloc.dart';
import 'package:base_app/presentations/bloc/language/language_cubit.dart';
import 'package:base_app/presentations/bloc/leave/leave_history/leave_history_bloc.dart';
import 'package:base_app/presentations/bloc/leave/work_and_salary/work_and_salary_bloc.dart';
import 'package:base_app/presentations/bloc/location/address/address_bloc.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_bloc.dart';
import 'package:base_app/presentations/bloc/location/school/school_bloc.dart';
import 'package:base_app/presentations/bloc/login/login_bloc.dart';
import 'package:base_app/presentations/bloc/notes/notes_system_cubit.dart';
import 'package:base_app/presentations/bloc/notification/notification_bloc.dart';
import 'package:base_app/presentations/bloc/personnel/personnel_bloc.dart';
import 'package:base_app/presentations/bloc/position/position_bloc.dart';
import 'package:base_app/presentations/bloc/register/register_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/stationery/stationery_bloc.dart';
import 'package:base_app/presentations/bloc/shift/shift_bloc.dart';
import 'package:base_app/presentations/bloc/themes/theme_cubit.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_name/user_by_name_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_bloc.dart';
import 'package:base_app/presentations/bloc/work_sheet/work_sheet_bloc.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBloc {
  /// Core BLoCs needed at app startup (auth, theme, language)
  static List<BlocProvider> coreBlocs() => [
        BlocProvider<ThemeCubit>(create: (BuildContext context) => dI<ThemeCubit>()),
        BlocProvider<AuthBloc>(create: (BuildContext context) => dI<AuthBloc>()),
        BlocProvider<LoginBloc>(create: (BuildContext context) => dI<LoginBloc>()),
        BlocProvider<LanguageCubit>(create: (BuildContext context) => dI<LanguageCubit>()),
        BlocProvider<BiometricCubit>(create: (BuildContext context) => dI<BiometricCubit>()),
        BlocProvider<UserBloc>(create: (BuildContext context) => dI<UserBloc>()),
        BlocProvider<NotificationBloc>(create: (BuildContext context) => dI<NotificationBloc>()),
      ];

  /// Feature BLoCs loaded lazily when first accessed
  static List<BlocProvider> featureBlocs() => [
        BlocProvider<AttendanceBloc>(create: (BuildContext context) => dI<AttendanceBloc>()),
        BlocProvider<RegisterBloc>(create: (BuildContext context) => dI<RegisterBloc>()),
        BlocProvider<UserByRolesBloc>(create: (BuildContext context) => dI<UserByRolesBloc>()),
        BlocProvider<DepartmentBloc>(create: (BuildContext context) => dI<DepartmentBloc>()),
        BlocProvider<PositionBloc>(create: (BuildContext context) => dI<PositionBloc>()),
        BlocProvider<PersonnelBloc>(create: (BuildContext context) => dI<PersonnelBloc>()),
        BlocProvider<CheckInSettingBloc>(create: (BuildContext context) => dI<CheckInSettingBloc>()),
        BlocProvider<NoteSystemCubit>(create: (BuildContext context) => dI<NoteSystemCubit>()),
        BlocProvider<AddressBloc>(create: (BuildContext context) => dI<AddressBloc>()),
        BlocProvider<RequisitionBloc>(create: (BuildContext context) => dI<RequisitionBloc>()),
        BlocProvider<RequisitionApproveBloc>(create: (BuildContext context) => dI<RequisitionApproveBloc>()),
        BlocProvider<UserByNameBloc>(create: (BuildContext context) => dI<UserByNameBloc>()),
        BlocProvider<FlowBloc>(create: (BuildContext context) => dI<FlowBloc>()),
        BlocProvider<StationeryBloc>(create: (BuildContext context) => dI<StationeryBloc>()),
        BlocProvider<UserByIdBloc>(create: (BuildContext context) => dI<UserByIdBloc>()),
        BlocProvider<RequisitionFollowingBloc>(create: (BuildContext context) => dI<RequisitionFollowingBloc>()),
        BlocProvider<WorkAndSalaryBloc>(create: (BuildContext context) => dI<WorkAndSalaryBloc>()),
        BlocProvider<CheckInCheckOutGpsBloc>(create: (BuildContext context) => dI<CheckInCheckOutGpsBloc>()),
        BlocProvider<SchoolBloc>(create: (BuildContext context) => dI<SchoolBloc>()),
        BlocProvider<LeaveHistoryBloc>(create: (BuildContext context) => dI<LeaveHistoryBloc>()),
        BlocProvider<WorkSheetBloc>(create: (BuildContext context) => dI<WorkSheetBloc>()),
        BlocProvider<RequestWorkSheetBloc>(create: (BuildContext context) => dI<RequestWorkSheetBloc>()),
        BlocProvider<WorkDayBloc>(create: (BuildContext context) => dI<WorkDayBloc>()),
        BlocProvider<ShiftBloc>(create: (BuildContext context) => dI<ShiftBloc>()),
        BlocProvider<ScheduleSchoolBloc>(create: (BuildContext context) => dI<ScheduleSchoolBloc>()),
        BlocProvider<LeaveShiftBloc>(create: (BuildContext context) => dI<LeaveShiftBloc>()),
      ];

  /// All BLoCs combined (for backward compatibility)
  static List<BlocProvider> allBlocs() => [
        ...coreBlocs(),
        ...featureBlocs(),
      ];
}
