import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/admin/check_in_setting/check_in_setting.widget.dart';
import 'package:base_app/presentations/widgets/admin/department/department.widget.dart';
import 'package:base_app/presentations/widgets/admin/personnel/personnel.widget.dart';
import 'package:base_app/presentations/widgets/admin/position/position.widget.dart';
import 'package:base_app/presentations/widgets/admin/request_by_manager/management_request.admin.widget.dart';
import 'package:base_app/presentations/widgets/attendance/timekeeping.dart';
import 'package:base_app/presentations/widgets/change_password/change_password.dart';
import 'package:base_app/presentations/widgets/create_request/create_request.dart';
import 'package:base_app/presentations/widgets/create_request/roommetting_request/create_request_roommetting.dart';
import 'package:base_app/presentations/widgets/request/doing_request.widget.dart';
import 'package:base_app/presentations/widgets/request/done_request.widget.dart';
import 'package:base_app/presentations/widgets/request/recent_request.widget.dart';
import 'package:base_app/presentations/widgets/trash_app/calendar/layout_calendar_2.dart';
import 'package:base_app/presentations/widgets/trash_app/create_note/create_note.dart';
import 'package:flutter/material.dart';

import '../../presentations/widgets/attendance/layout_calendar.dart';

class MenuValues {
  static List<Map<String, dynamic>> menuValues(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return [
      {
        'text': appLocalizations.createRequest,
        'icon': const Icon(Icons.add, color: Colors.white, size: 30)
      },
      {
        'text': appLocalizations.recentRequest,
        'icon': const Icon(Icons.request_page, color: Colors.white, size: 30)
      },
      {
        'text': appLocalizations.requestIsProcessing,
        'icon': const Icon(Icons.hourglass_bottom, color: Colors.white, size: 30)
      },
      {
        'text': appLocalizations.requestProcessed,
        'icon': const Icon(Icons.done, color: Colors.white, size: 30)
      },
      {
        'text': appLocalizations.timeKeeping,
        'icon': const Icon(Icons.calendar_month, color: Colors.white, size: 30)
      },
      {
        'text': appLocalizations.changePassword,
        'icon': const Icon(Icons.password, color: Colors.white, size: 30)
      }
    ];
  }

  static List<Map<String, dynamic>> menuUserSystemValues(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return [
      {
        'text': 'Create Note',
        'icon': const Icon(Icons.note, color: Colors.white, size: 30)
      },
      {
        'text': appLocalizations.calendar,
        'icon': const Icon(Icons.calendar_month, color: Colors.white, size: 30)
      },
      {
        'text': appLocalizations.changePassword,
        'icon': const Icon(Icons.password, color: Colors.white, size: 30)
      }
    ];
  }

  static List<Map<String, dynamic>> menuGeneralManagerValues(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return [
      /*{
        'text': appLocalizations.managementRequests,
        'icon': const Icon(Icons.manage_accounts, color: Colors.white, size: 30)
      },
      {
        'text': appLocalizations.managementRoom,
        'icon': const Icon(Icons.meeting_room, color: Colors.white, size: 30)
      },
      {
        'text': appLocalizations.timeKeeping,
        'icon': const Icon(Icons.calendar_month, color: Colors.white, size: 30)
      },*/
      {
        'text': 'Chấm công',
        'icon': const Icon(Icons.timelapse_outlined, color: Colors.white, size: 30)
      },
      {
        'text': appLocalizations.workingTime,
        'icon': const Icon(Icons.timer, color: Colors.white, size: 30)
      },
      {
        'text': appLocalizations.personnel,
        'icon': const Icon(Icons.person_outline, color: Colors.white, size: 30)
      },
      {
        'text': appLocalizations.position,
        'icon': const Icon(Icons.chair_alt, color: Colors.white, size: 30)
      },
      {
        'text': appLocalizations.department,
        'icon': const Icon(Icons.room_preferences, color: Colors.white, size: 30)
      },
      {
        'text': appLocalizations.changePassword,
        'icon': const Icon(Icons.password, color: Colors.white, size: 30)
      }
    ];
  }

  static List<Map<String, dynamic>> menuManagerValues(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return [
      {
        'text': appLocalizations.managementRequests,
        'icon': const Icon(Icons.manage_accounts, color: Colors.white, size: 30)
      },
      {
        'text': appLocalizations.setRoom,
        'icon': const Icon(Icons.meeting_room, color: Colors.white, size: 30)
      },
      {'text': appLocalizations.timeKeeping, 'icon': const Icon(Icons.calendar_month, color: Colors.white, size: 30)},
      {'text': appLocalizations.changePassword, 'icon': const Icon(Icons.password, color: Colors.white, size: 30)}
    ];
  }

  static const List<Widget> widgetOptions = <Widget>[
    CreateRequestWidget(),
    RecentRequest(),
    DoingRequest(),
    DoneRequest(),
    LayoutCalendar(),
    ChangePassword(),
  ];

  static const List<Widget> widgetOptionsUserSystem = <Widget>[
    CreateNoteWidget(),
    LayoutCalendar2(),
    ChangePassword(),
  ];

  static const List<Widget> widgetOptionsManager = <Widget>[
    ManagementRequest(),
    CreateRoomMeetingWidget(),
    LayoutCalendar(),
    ChangePassword(),
  ];

  /*static const List<Widget> widgetOptionsGeneralManager = <Widget>[
    ManagementRequest(),
    CreateRoomWidget(),
    LayoutCalendar(),
    ChangePassword(),
  ];*/

  static const List<Widget> widgetOptionsGeneralManager = <Widget>[
    TimekeepingWidget(),
    CheckInSettingWidget(),
    PersonnelWidget(),
    PositionWidget(),
    DepartmentWidget(),
    ChangePassword(),
  ];

  static List<String> listTypeRequest = [
    TypeRequestStatus.cRM.name,
    TypeRequestStatus.iT.name,
    TypeRequestStatus.website.name,
    TypeRequestStatus.onLeave.name,
    TypeRequestStatus.roomMeeting.name,
    TypeRequestStatus.overTime.name
  ];
  static List<String> listSearchTypeRequest = [
    TypeRequestStatus.cRM.name,
    TypeRequestStatus.iT.name,
    TypeRequestStatus.website.name,
    TypeRequestStatus.explanation.name,
    TypeRequestStatus.onLeave.name,
    TypeRequestStatus.roomMeeting.name,
    TypeRequestStatus.overTime.name
  ];

  static List<String> listSearchTypeRequestByAdmin = [
    TypeRequestStatus.cRM.name,
    TypeRequestStatus.iT.name,
    TypeRequestStatus.website.name,
    TypeRequestStatus.explanation.name,
    TypeRequestStatus.onLeave.name,
    TypeRequestStatus.overTime.name
  ];

  static List<String> checkApprover = [
    StatusRequestStatus.pending.name,
    StatusRequestStatus.done.name,
    StatusRequestStatus.reject.name,
  ];

  static List<String> checkManagerApprover = [
    StatusRequestStatus.subsequentApproval.name,
    StatusRequestStatus.pending.name,
    StatusRequestStatus.done.name,
    StatusRequestStatus.reject.name,
  ];
  static List<String> listPriority = [
    PriorityRequestStatus.high.name,
    PriorityRequestStatus.medium.name,
    PriorityRequestStatus.low.name
  ];
  static List<String> listParentId = [
    ParentId.aG.name,
    ParentId.fsel.name
  ];

  static List<String> listOTvsOL = [
    TypeRequestStatus.onLeave.name,
    TypeRequestStatus.overTime.name
  ];

  static const List<bool> isApprover = [
    true,
    false,
  ];

  static Map<int, String> mapMonth = {
    1: 'January',
    2: 'February',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'August',
    9: 'September',
    10: 'October',
    11: 'November',
    12: 'December'
  };
  static Map<String, String> mapDayInWeek = {
    'Monday': 'Mon',
    'Tuesday': 'Tue',
    'Wednesday': 'Wed',
    'Thursday': 'Thu',
    'Friday': 'Fri',
    'Saturday': 'Sat',
    'Sunday': 'Sun',
  };
  static Map<String, int> mapNumberDayInWeek = {
    'Mon': 1,
    'Tue': 2,
    'Wed': 3,
    'Thu': 4,
    'Fri': 5,
    'Sat': 6,
    'Sun': 0,
  };
}
