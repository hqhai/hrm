import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/auth/auth_bloc.dart';
import 'package:base_app/presentations/bloc/biometric/biometric_cubit.dart';
import 'package:base_app/presentations/bloc/checkin_setting/check_in_setting_bloc.dart';
import 'package:base_app/presentations/bloc/department/department_bloc.dart';
import 'package:base_app/presentations/bloc/language/language_cubit.dart';
import 'package:base_app/presentations/bloc/location/address/address_bloc.dart';
import 'package:base_app/presentations/bloc/login/login_bloc.dart';
import 'package:base_app/presentations/bloc/notes/notes_bloc.dart';
import 'package:base_app/presentations/bloc/personnel/personnel_bloc.dart';
import 'package:base_app/presentations/bloc/position/position_bloc.dart';
import 'package:base_app/presentations/bloc/register/register_bloc.dart';
import 'package:base_app/presentations/bloc/request/request/request_bloc.dart';
import 'package:base_app/presentations/bloc/request/room_meeting/room_meeting_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/stationery/stationery_bloc.dart';
import 'package:base_app/presentations/bloc/themes/theme_cubit.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_manager/user_by_admin_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_name/user_by_name_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBloc {
  static List<BlocProvider> allBlocs() => [
        BlocProvider<ThemeCubit>(create: (BuildContext context) => dI<ThemeCubit>()),
        BlocProvider<AuthBloc>(create: (BuildContext context) => dI<AuthBloc>()),
        BlocProvider<LoginBloc>(create: (BuildContext context) => dI<LoginBloc>()),
        BlocProvider<UserBloc>(create: (BuildContext context) => dI<UserBloc>()),
        BlocProvider<AttendanceBloc>(create: (BuildContext context) => dI<AttendanceBloc>()),
        BlocProvider<RegisterBloc>(create: (BuildContext context) => dI<RegisterBloc>()),
        BlocProvider<RequestBloc>(create: (BuildContext context) => dI<RequestBloc>()),
        BlocProvider<LanguageCubit>(create: (BuildContext context) => dI<LanguageCubit>()),
        BlocProvider<UserByRolesBloc>(create: (BuildContext context) => dI<UserByRolesBloc>()),
        BlocProvider<UserByAdminBloc>(create: (BuildContext context) => dI<UserByAdminBloc>()),
        BlocProvider<RoomMeetingBloc>(create: (BuildContext context) => dI<RoomMeetingBloc>()),
        BlocProvider<DepartmentBloc>(create: (BuildContext context) => dI<DepartmentBloc>()),
        BlocProvider<PositionBloc>(create: (BuildContext context) => dI<PositionBloc>()),
        BlocProvider<PersonnelBloc>(create: (BuildContext context) => dI<PersonnelBloc>()),
        BlocProvider<CheckInSettingBloc>(
            create: (BuildContext context) => dI<CheckInSettingBloc>()),
        BlocProvider<NotesBloc>(create: (BuildContext context) => dI<NotesBloc>()),
        BlocProvider<AddressBloc>(create: (BuildContext context) => dI<AddressBloc>()),
        BlocProvider<BiometricCubit>(create: (BuildContext context) => dI<BiometricCubit>()),
        BlocProvider<RequisitionBloc>(create: (BuildContext context) => dI<RequisitionBloc>()),
        BlocProvider<RequisitionApproveBloc>(
            create: (BuildContext context) => dI<RequisitionApproveBloc>()),
        BlocProvider<UserByNameBloc>(create: (BuildContext context) => dI<UserByNameBloc>()),
        BlocProvider<FlowBloc>(create: (BuildContext context) => dI<FlowBloc>()),
        BlocProvider<StationeryBloc>(create: (BuildContext context) => dI<StationeryBloc>()),
        BlocProvider<UserByIdBloc>(create: (BuildContext context) => dI<UserByIdBloc>()),
      ];
}
