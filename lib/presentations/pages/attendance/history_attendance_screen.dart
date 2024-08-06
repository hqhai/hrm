import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/common/utils/tab_bar_attendance.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/pages/attendance/tab/tab_bar_work_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:themes/themes.dart';

final historyAttendancePageRoute = GoRoute(
    name: Pages.historyAttendancePage,
    path: Pages.historyAttendancePage,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return HistoryAttendancePage(
        dateTime: data['dateTime'],
      );
    });

class HistoryAttendancePage extends StatefulWidget {
  const HistoryAttendancePage({super.key, required this.dateTime});

  final DateTime dateTime;

  @override
  State<HistoryAttendancePage> createState() => _HistoryAttendancePageState();
}

class _HistoryAttendancePageState extends State<HistoryAttendancePage>
    with TickerProviderStateMixin {
  late final ItemScrollController itemScrollController;
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  int checkIndex = 0;

  @override
  void initState() {
    itemScrollController = ItemScrollController();
    itemPositionsListener.itemPositions.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    final positions = itemPositionsListener.itemPositions.value;

    /// Lọc các item có itemLeadingEdge >= 0 và visiblePositions không null để tránh lỗi ở hàm reduce
    final visiblePositions =
        positions.where((ItemPosition position) => position.itemLeadingEdge >= 0).toList();
    if (visiblePositions.isNotEmpty) {
      int minIndex = visiblePositions
          .map((ItemPosition position) => position.index)
          .reduce((min, index) => index < min ? index : min);

      /// reduce để giảm danh sách các index xuống còn một giá trị duy nhất, là index nhỏ nhất.

      setState(() {
        checkIndex = minIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colors.text),
        title: Text(
          convertDate(context),
          style: TextStyle(
            fontSize: SpacingUnit.x5,
            color: colors.text,
          ),
        ),
      ),
      body: Column(
        children: [
          Divider(
            color: colors.outline.withOpacity(0.2),
            height: SpacingUnit.x0_25,
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width,
                  height: SpacingUnit.x15,
                  child: TabBarWorkSheet(index: checkIndex, setIndex: (value) => _setIndex(value)),
                ),
                SizedBox(
                  width: width,
                  height: height * 0.7,
                  child: ScrollablePositionedList.builder(
                    itemScrollController: itemScrollController,
                    itemPositionsListener: itemPositionsListener,
                    scrollDirection: Axis.horizontal,
                    itemCount: tabBarAttendance(context).length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(SpacingUnit.x4),
                        child: SizedBox(
                          width: width,
                          child: tabAttendance(widget.dateTime)[index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String convertDate(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return '${appLocalizations.day} ${widget.dateTime.day}, ${appLocalizations.month} ${widget.dateTime.month}, ${appLocalizations.year} ${widget.dateTime.year}';
  }

  _setIndex(int index) {
    setState(() {
      checkIndex = index;
      itemScrollController.scrollTo(
          index: index, duration: const Duration(milliseconds: 500), curve: Curves.linear);
    });
  }
}
