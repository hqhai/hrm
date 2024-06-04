import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/presentations/pages/activate/create_requisition/create_requisition.dart';
import 'package:base_app/presentations/pages/activate/create_requisition/create_requisition_explanation.dart';
import 'package:base_app/presentations/pages/activate/create_requisition/create_requisition_leave.dart';
import 'package:base_app/presentations/pages/activate/requisition/requisition_list.dart';
import 'package:base_app/presentations/pages/activate/requisition/see_list_requisition.page.dart';
import 'package:base_app/presentations/pages/activate/requisition_form/requisition_infor.page.dart';
import 'package:base_app/presentations/pages/attendance/history_attendance_screen.dart';
import 'package:base_app/presentations/pages/attendance/layout_calendar_attendance_history.dart';
import 'package:base_app/presentations/pages/check_in_setting/create_check_in_setting.page.dart';
import 'package:base_app/presentations/pages/department/infor_department.page.dart';
import 'package:base_app/presentations/pages/department/update_department.page.dart';
import 'package:base_app/presentations/pages/error.page.dart';
import 'package:base_app/presentations/pages/forgot_password/forgot_password.page.dart';
import 'package:base_app/presentations/pages/home/home.page.dart';
import 'package:base_app/presentations/pages/login/login.page.dart';
import 'package:base_app/presentations/pages/login/register_biometric.page.dart';
import 'package:base_app/presentations/pages/main.page.dart';
import 'package:base_app/presentations/pages/personnel/create_personnel.page.dart';
import 'package:base_app/presentations/pages/position/create_position.page.dart';
import 'package:base_app/presentations/pages/position/update_position.page.dart';
import 'package:base_app/presentations/pages/profile/update_profile.page.dart';
import 'package:base_app/presentations/pages/register/register.page.dart';
import 'package:base_app/presentations/pages/request/create_request/create_explanation.page.dart';
import 'package:base_app/presentations/pages/request/create_request/create_room_meeting.dart';
import 'package:base_app/presentations/pages/request/get_request/explanation_request.page.dart';
import 'package:base_app/presentations/pages/request/get_request/list_explanation_by_user.page.dart';
import 'package:base_app/presentations/pages/request/get_request/onleave_request.page.dart';
import 'package:base_app/presentations/pages/request/get_request/overtime_request.page.dart';
import 'package:base_app/presentations/pages/request/get_request/request.page.dart';
import 'package:base_app/presentations/pages/request/get_request/roommeeting_request.page.dart';
import 'package:base_app/presentations/pages/request/update_request/request.update.page.dart';
import 'package:base_app/presentations/pages/department/create_department.page.dart';
import 'package:base_app/presentations/pages/time_keeping_gps/time_keeping_gps.dart';
import 'package:base_app/presentations/pages/time_keeping_gps/time_keeping_gps_check.dart';
import 'package:base_app/presentations/pages/trash_app/update_note.dart';
import 'package:base_app/presentations/widgets/change_password/change_password.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import 'pages.dart';

@lazySingleton
class AppRouters {
  final GoRouter goRouter;

  AppRouters() : goRouter = _router;

  static GoRouter get _router => GoRouter(
      routes: routerPages, navigatorKey: dI<AppNavigation>().navigatorKey, initialLocation: '/');

  static List<GoRoute> routerPages = {
    Pages.main: mainPageRoute,
    Pages.error: errorPageRoute,
    Pages.login: loginPageRoute,
    Pages.register: registerPageRoute,
    Pages.home: homePageRoute,
    Pages.requestDefault: requestDefaultPageRoute,
    Pages.overTimeRequest: overTimeRequestPageRoute,
    Pages.onLeaveRequest: onLeaveRequestPageRoute,
    Pages.explanationRequest: explanationPageRoute,
    Pages.getExplanationRequest: getExplanationRequestPageRoute,
    Pages.requestUpdatePage: requestUpdatePageRoute,
    Pages.createRoomMeetingPage: createRoomMeetingPageRoute,
    Pages.listExplanationByUserPage: listExplanationByUserPageRoute,
    Pages.roomMeetingRequestPageRoute: roomMeetingRequestPageRoute,
    Pages.createDepartmentPage: createDepartmentPageRoute,
    Pages.updateDepartmentPage: updateDepartmentPageRoute,
    Pages.informationDepartmentPage: informationDepartmentPageRoute,
    Pages.createPositionPage: createPositionPageRoute,
    Pages.updatePositionPage: updatePositionPageRoute,
    Pages.createPersonnelPage: createPersonnelPageRoute,
    Pages.createCheckInSettingPage: createCheckInSettingPageRoute,
    Pages.forgotPasswordPage: forgotPasswordPageRoute,
    Pages.updateNotesPage: updateNotePageRoute,
    Pages.changePasswordPage: changePasswordPageRoute,
    Pages.updateProfilePage: updateProfilePageRoute,
    Pages.layoutCalendarAttendanceHistoryPage: layoutCalendarAttendanceHistoryPageRoute,
    Pages.historyAttendancePage: historyAttendancePageRoute,
    Pages.biometricRegister: registerBiometricPageRoute,
    Pages.timekeepingGPSPage: timekeepingGPSPageRoute,
    Pages.timekeepingGPSCheckPage: timekeepingGPSCheckPageRoute,
    Pages.requisitionListPage: requisitionListPageRoute,
    Pages.seeRequisitionListPage: seeListRequisitionPageRoute,
    Pages.requisitionInformationPage: requisitionInformationPageRoute,
    Pages.createRequisitionPage: createRequisitionPageRoute,
    Pages.createRequisitionExplanationPage: createRequisitionExplanationPageRoute,
    Pages.createRequisitionLeavePage: createRequisitionLeavePageRoute,
  }.entries.map((entry) => entry.value).toList();
}
