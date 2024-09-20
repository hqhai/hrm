import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/activate.widget.dart';
import 'package:base_app/presentations/widgets/calendar_work/calendar_work.widget.dart';
import 'package:base_app/presentations/widgets/change_password/change_password.dart';
import 'package:base_app/presentations/widgets/home/home.widget.dart';
import 'package:base_app/presentations/widgets/notification/notification.widget.dart';
import 'package:base_app/presentations/widgets/profile/profile.widget.dart';
import 'package:base_app/presentations/widgets/trash_app/calendar/notes_system_list.dart';
import 'package:base_app/presentations/widgets/trash_app/create_note/create_note.dart';
import 'package:base_app/presentations/widgets/trash_app/delete_account/delete_account.dart';
import 'package:base_app/presentations/widgets/trash_app/salary/salary_widget.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

import '../../presentations/widgets/attendance/calendar/layout_calendar.dart';

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
    final colors = AppTheme.getColors(context);
    return [
      {'text': 'Salary', 'icon': Icon(Icons.monetization_on, color: colors.text, size: 30)},
      {'text': 'Create Note', 'icon': Icon(Icons.note, color: colors.text, size: 30)},
      {
        'text': appLocalizations.calendar,
        'icon': Icon(Icons.calendar_month, color: colors.text, size: 30)
      },
      {
        'text': appLocalizations.changePassword,
        'icon': Icon(Icons.password, color: colors.text, size: 30)
      },
      {
        'text': appLocalizations.deleteAccount,
        'icon': Icon(Icons.no_accounts, color: colors.text, size: 30)
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

  static const List<Widget> widgetOptionsUser = <Widget>[
    ActivateWidget(),
    HomeWidget(),
    CalendarWorkWidget(),
    NotificationWidget(),
    ProfileWidget(),
  ];

  static const List<Widget> widgetOptionsUserSystem = <Widget>[
    SalaryWidget(),
    CreateNoteWidget(),
    NotesSystemList(),
    ChangePassword(),
    DeleteAccountWidget(),
  ];

  static const List<Widget> widgetOptionsManager = <Widget>[
    LayoutCalendar(),
    ChangePassword(),
  ];

  /*static const List<Widget> widgetOptionsGeneralManager = <Widget>[
    ManagementRequest(),
    CreateRoomWidget(),
    LayoutCalendar(),
    ChangePassword(),
  ];*/

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

  static List<String> listPriority = [
    PriorityRequestStatus.high.name,
    PriorityRequestStatus.medium.name,
    PriorityRequestStatus.low.name
  ];

  static List<String> languageValue = [
    LanguageEnum.vi.name,
    LanguageEnum.en.name,
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

class TitleAppbarValues {
  static List<String> listTitleAppbar(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return [
      appLocalizations.request,
      appLocalizations.worksheet,
      appLocalizations.calendarWork,
      appLocalizations.notification,
      appLocalizations.userInformation,
    ];
  }
}

final Map<String, int> mapNumberDayInWeek = {
  'Sun': 7,
  'Mon': 1,
  'Tue': 2,
  'Wed': 3,
  'Thu': 4,
  'Fri': 5,
  'Sat': 6,
};

final Map<int, String> mapNameInWeek = {
  7: 'Sun',
  1: 'Mon',
  2: 'Tue',
  3: 'Wed',
  4: 'Thu',
  5: 'Fri',
  6: 'Sat',
};
