import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/common/utils/tab_bar_attendance.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  //late final ItemScrollController itemScrollController;
  late final TabController _tabController;

  //final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  @override
  void initState() {
    //itemScrollController = ItemScrollController();
    //itemPositionsListener.itemPositions.addListener(_scrollListener);
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0)
      ..addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    ///Sau có khi cần dùng
    /*final positions = itemPositionsListener.itemPositions.value;

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
    }*/
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: colors.outline.withValues(alpha: 0.3),
            height: SpacingUnit.x0_5,
          ),
        ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: SpacingUnit.x4,
              vertical: SpacingUnit.x2,
            ),
            decoration: BoxDecoration(
              color: colors.text.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(SpacingUnit.x3),
            ),
            padding: const EdgeInsets.all(3),
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              dividerHeight: 0,
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
                boxShadow: [
                  BoxShadow(
                    color: colors.text.withValues(alpha: 0.08),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              labelColor: colors.text,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              unselectedLabelColor: colors.text.withValues(alpha: 0.5),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              tabs: tabBarAttendance(context).mapIndexed((index, element) {
                return Tab(
                  height: 36,
                  text: element,
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: Container(
              color: colors.background,
              child: TabBarView(
                controller: _tabController,
                children: tabAttendance(widget.dateTime).mapIndexed(
                  (index, element) {
                    return Container(
                      color: colors.background,
                      child: element,
                    );
                  },
                ).toList(),
              ),
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
}
