import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/presentations/pages/activate/create_requisition/create_requisition.dart';
import 'package:base_app/presentations/pages/activate/create_requisition/create_requisition_business.dart';
import 'package:base_app/presentations/pages/activate/create_requisition/create_requisition_explanation.dart';
import 'package:base_app/presentations/pages/activate/create_requisition/create_requisition_late_and_early.dart';
import 'package:base_app/presentations/pages/activate/create_requisition/create_requisition_leave.dart';
import 'package:base_app/presentations/pages/activate/create_requisition/create_requisition_make_up_work.dart';
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
import 'package:base_app/presentations/pages/attendance/history_attendance_screen.dart';
import 'package:base_app/presentations/pages/attendance/layout_calendar_attendance_history.dart';
import 'package:base_app/presentations/pages/calendar_work/register_shift_admin.dart/register_work_day_admin.dart';
import 'package:base_app/presentations/pages/calendar_work/register_shift_admin.dart/register_work_day_admin_detail.dart';
import 'package:base_app/presentations/pages/calendar_work/register_shifts.dart';
import 'package:base_app/presentations/pages/calendar_work/shifts.page.dart';
import 'package:base_app/presentations/pages/calendar_work/shifts.page_review.dart';
import 'package:base_app/presentations/pages/department/infor_department.page.dart';
import 'package:base_app/presentations/pages/department/update_department.page.dart';
import 'package:base_app/presentations/pages/error.page.dart';
import 'package:base_app/presentations/pages/forgot_password/forgot_password.page.dart';
import 'package:base_app/presentations/pages/home/home.page.dart';
import 'package:base_app/presentations/pages/login/login.page.dart';
import 'package:base_app/presentations/pages/login/register_biometric.page.dart';
import 'package:base_app/presentations/pages/main.page.dart';
import 'package:base_app/presentations/pages/position/create_position.page.dart';
import 'package:base_app/presentations/pages/position/update_position.page.dart';
import 'package:base_app/presentations/pages/profile/update_profile.page.dart';
import 'package:base_app/presentations/pages/register/register.page.dart';
import 'package:base_app/presentations/pages/department/create_department.page.dart';
import 'package:base_app/presentations/pages/time_keeping_gps/history_timekeeping_page.dart';
import 'package:base_app/presentations/pages/time_keeping_gps/successful_timekeeping_page.dart';
import 'package:base_app/presentations/pages/time_keeping_gps/time_keeping_gps_school.dart';
import 'package:base_app/presentations/pages/time_keeping_gps/unsuccessful_timekeeping_page.dart';
import 'package:base_app/presentations/widgets/attendance/calendar/layout_calendar.dart';
import 'package:base_app/presentations/widgets/change_password/change_password.dart';
import 'package:base_app/presentations/widgets/map_location/map_location_page.dart';
import 'package:base_app/presentations/widgets/trash_app/create_note/create_note.dart';
import 'package:base_app/presentations/widgets/trash_app/dialog/dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

/// Wraps a GoRoute so it uses CupertinoPage (iOS-style swipe-back gesture).
GoRoute _cupertino(GoRoute route) {
  return GoRoute(
    path: route.path,
    name: route.name,
    redirect: route.redirect,
    routes: route.routes,
    pageBuilder: (context, state) {
      // Call the original builder to get the widget.
      final child = route.builder!(context, state);
      return CupertinoPage(child: child);
    },
  );
}

@lazySingleton
class AppRouters {
  final GoRouter goRouter;

  AppRouters() : goRouter = _router;

  static GoRouter get _router => GoRouter(
      routes: routerPages,
      navigatorKey: dI<AppNavigation>().navigatorKey,
      initialLocation: '/');

  // Routes that should NOT have swipe-back (root/auth screens).
  static final _noSwipeRoutes = <GoRoute>[
    mainPageRoute,
    loginPageRoute,
    registerPageRoute,
    homePageRoute,
  ];

  // All other routes get iOS-style CupertinoPage (swipe-back enabled).
  static final _swipeRoutes = <GoRoute>[
    errorPageRoute,
    createDepartmentPageRoute,
    updateDepartmentPageRoute,
    informationDepartmentPageRoute,
    createPositionPageRoute,
    updatePositionPageRoute,
    forgotPasswordPageRoute,
    changePasswordPageRoute,
    updateProfilePageRoute,
    layoutCalendarAttendanceHistoryPageRoute,
    historyAttendancePageRoute,
    registerBiometricPageRoute,
    timekeepingGPSSchoolPageRoute,
    timekeepingGPSSuccessfulRoute,
    timekeepingGPSUnsuccessfulRoute,
    requisitionListPageRoute,
    seeRequestListPageRoute,
    requisitionInformationPageRoute,
    createRequestPageRoute,
    createRequestExplanationPageRoute,
    createRequestLeavePageRoute,
    pDFPageRoute,
    createRequestBusinessPageRoute,
    createRequestPostalDeliveryPageRoute,
    createRequestVehicleDispatchPageRoute,
    createRequestStationeryOderPageRoute,
    createRequestReleaseOfWarehousePageRoute,
    requisitionApproveListPageRoute,
    requisitionFollowerListPageRoute,
    createRequestOverTimePageRoute,
    createRequestLateAndEarlyPageRoute,
    createRequestMakeUpWorkPageRoute,
    leavePageRoute,
    layoutCalendarPageRoute,
    registerShiftsPageRoute,
    shiftsPageRoute,
    registerWorkDayPageRoute,
    registerWorkDayAdminDetailPageRoute,
    timekeepingGPSHistoryRoute,
    shiftsPageReviewRoute,
    noteSystemPageRoute,
    createNoteWidgetPageRoute,
    mapLocationRoute,
  ].map(_cupertino).toList();

  static List<GoRoute> routerPages = [
    ..._noSwipeRoutes,
    ..._swipeRoutes,
  ];
}
