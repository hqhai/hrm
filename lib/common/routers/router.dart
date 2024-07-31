import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/presentations/pages/activate/create_requisition/create_requisition.dart';
import 'package:base_app/presentations/pages/activate/create_requisition/create_requisition_business.dart';
import 'package:base_app/presentations/pages/activate/create_requisition/create_requisition_explanation.dart';
import 'package:base_app/presentations/pages/activate/create_requisition/create_requisition_late_and_early.dart';
import 'package:base_app/presentations/pages/activate/create_requisition/create_requisition_leave.dart';
import 'package:base_app/presentations/pages/activate/create_requisition/create_requisition_over_time.dart';
import 'package:base_app/presentations/pages/activate/create_requisition/create_requisition_postal_delivery.dart';
import 'package:base_app/presentations/pages/activate/create_requisition/create_requisition_release_of_warehouse.dart';
import 'package:base_app/presentations/pages/activate/create_requisition/create_requisition_stationery.dart';
import 'package:base_app/presentations/pages/activate/create_requisition/create_requisition_vehicle_dispatch.dart';
import 'package:base_app/presentations/pages/activate/file/pdf.page.dart';
import 'package:base_app/presentations/pages/activate/leave/leave.page.dart';
import 'package:base_app/presentations/pages/activate/requisition_approve/requisition_approve_list.dart';
import 'package:base_app/presentations/pages/activate/requisition_follower/requisition_follower_list.dart';
import 'package:base_app/presentations/pages/activate/requisition_form/requisition_infor.page.dart';
import 'package:base_app/presentations/pages/activate/requisition_self/requisition_list.dart';
import 'package:base_app/presentations/pages/activate/requisition_self/see_list_requisition.page.dart';
import 'package:base_app/presentations/pages/activate/timekeeping/list_schools.page.dart';
import 'package:base_app/presentations/pages/attendance/history_attendance_screen.dart';
import 'package:base_app/presentations/pages/attendance/layout_calendar_attendance_history.dart';
import 'package:base_app/presentations/pages/calendar_work/register_shift_admin.dart/register_work_day_admin.dart';
import 'package:base_app/presentations/pages/calendar_work/register_shift_admin.dart/register_work_day_admin_detail.dart';
import 'package:base_app/presentations/pages/calendar_work/register_shifts.dart';
import 'package:base_app/presentations/pages/calendar_work/register_shift_admin.dart/register_work_day_admin.dart';
import 'package:base_app/presentations/pages/calendar_work/register_shift_admin.dart/register_work_day_admin_detail.dart';
import 'package:base_app/presentations/pages/calendar_work/register_shifts.dart';
import 'package:base_app/presentations/pages/calendar_work/shifts.page.dart';
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
import 'package:base_app/presentations/pages/department/create_department.page.dart';
import 'package:base_app/presentations/pages/time_keeping_gps/time_keeping_gps.dart';
import 'package:base_app/presentations/pages/time_keeping_gps/time_keeping_gps_check.dart';
import 'package:base_app/presentations/pages/trash_app/update_note.dart';
import 'package:base_app/presentations/widgets/attendance/calendar/layout_calendar.dart';
import 'package:base_app/presentations/widgets/change_password/change_password.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import 'pages.dart';

@lazySingleton
class AppRouters {
  final GoRouter goRouter;

  AppRouters() : goRouter = _router;

  static GoRouter get _router => GoRouter(
      routes: routerPages,
      navigatorKey: dI<AppNavigation>().navigatorKey,
      initialLocation: '/');

  static List<GoRoute> routerPages = {
    Pages.main: mainPageRoute,
    Pages.error: errorPageRoute,
    Pages.login: loginPageRoute,
    Pages.register: registerPageRoute,
    Pages.home: homePageRoute,
    Pages.createDepartmentPage: createDepartmentPageRoute,
    Pages.updateDepartmentPage: updateDepartmentPageRoute,
    Pages.informationDepartmentPage: informationDepartmentPageRoute,
    Pages.createPositionPage: createPositionPageRoute,
    Pages.updatePositionPage: updatePositionPageRoute,
    Pages.createPersonnelPage: createPersonnelPageRoute,
    Pages.forgotPasswordPage: forgotPasswordPageRoute,
    Pages.updateNotesPage: updateNotePageRoute,
    Pages.changePasswordPage: changePasswordPageRoute,
    Pages.updateProfilePage: updateProfilePageRoute,
    Pages.layoutCalendarAttendanceHistoryPage:
        layoutCalendarAttendanceHistoryPageRoute,
    Pages.historyAttendancePage: historyAttendancePageRoute,
    Pages.biometricRegister: registerBiometricPageRoute,
    Pages.timekeepingGPSPage: timekeepingGPSPageRoute,
    Pages.timekeepingGPSCheckPage: timekeepingGPSCheckPageRoute,
    Pages.requisitionListPage: requisitionListPageRoute,
    Pages.seeRequestListPage: seeRequestListPageRoute,
    Pages.requisitionInformationPage: requisitionInformationPageRoute,
    Pages.createRequestPage: createRequestPageRoute,
    Pages.createRequestExplanationPage: createRequestExplanationPageRoute,
    Pages.createRequestLeavePage: createRequestLeavePageRoute,
    Pages.pDFPage: pDFPageRoute,
    Pages.createRequestBusinessPage: createRequestBusinessPageRoute,
    Pages.createRequestPostalDeliveryPage: createRequestPostalDeliveryPageRoute,
    Pages.createRequestVehicleDispatchPage:
        createRequestVehicleDispatchPageRoute,
    Pages.createRequestStationeryOderPage: createRequestStationeryOderPageRoute,
    Pages.createRequestReleaseOfWarehousePage:
        createRequestReleaseOfWarehousePageRoute,
    Pages.requisitionApproveListPage: requisitionApproveListPageRoute,
    Pages.requisitionFollowerListPage: requisitionFollowerListPageRoute,
    Pages.createRequestOverTimePage: createRequestOverTimePageRoute,
    Pages.createRequestLateAndEarlyPage: createRequestLateAndEarlyPageRoute,
    Pages.listSchoolsPage: listSchoolsPageRoute,
    Pages.leavePage: leavePageRoute,
    Pages.layoutCalendarPage: layoutCalendarPageRoute,
    Pages.registerShiftsPage: registerShiftsPageRoute,
    Pages.shiftsPage: shiftsPageRoute,
    Pages.registerWorkDayAdmin: registerWorkDayPageRoute,
    Pages.registerWorkDayAdminDetail: registerWorkDayAdminDetailPageRoute,
  }.entries.map((entry) => entry.value).toList();
}
