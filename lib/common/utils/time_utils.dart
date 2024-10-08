import 'package:base_app/common/enum/emun_time.dart';

class GetMonth{
  static Map<int, String> mapMonth = {
    1: 'Jan',
    2: 'Feb',
    3: 'Mar',
    4: 'Apr',
    5: 'May',
    6: 'Jun',
    7: 'Jul',
    8: 'Aug',
    9: 'Sep',
    10: 'Oct',
    11: 'Nov',
    12: 'Dec'
  };

  static Map<int, MonthEnum> mapMonthName = {
    1: MonthEnum.january,
    2: MonthEnum.february,
    3: MonthEnum.march,
    4: MonthEnum.april,
    5: MonthEnum.may,
    6: MonthEnum.june,
    7: MonthEnum.july,
    8: MonthEnum.august,
    9: MonthEnum.september,
    10: MonthEnum.october,
    11: MonthEnum.november,
    12: MonthEnum.december
  };
}

