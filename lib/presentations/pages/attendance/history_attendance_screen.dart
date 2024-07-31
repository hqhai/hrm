import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/common/utils/tab_bar_attendance.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/base_page.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
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
  late final TabController _tabController;
  final TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this)..addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {}

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final height = MediaQuery.sizeOf(context).height;
    return BasePage(
      appbar: AppBar(
        iconTheme: IconThemeData(color: colors.text),
        title: Text(
          convertDate(context),
          style: TextStyle(
            fontSize: SpacingUnit.x5,
            color: colors.text,
          ),
        ),
      ),
      body: ContainerScreenMain(
        child: SingleChildScrollView(
          child: DefaultTabController(
            length: 5,
            initialIndex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBar(
                  isScrollable: true,
                  controller: _tabController,
                  tabs: tabBarAttendance(context)
                      .map(
                        (e) => Tab(
                          child: Text(
                            e,
                            style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5),
                          ),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(
                  height: height * 0.7,
                  child: TabBarView(
                    controller: _tabController,
                    children: tabAttendance(widget.dateTime)
                        .map(
                          (e) => e,
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String convertDate(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return '${appLocalizations.day} ${widget.dateTime.day}, ${appLocalizations.month} ${widget.dateTime.month}, ${appLocalizations.year} ${widget.dateTime.year}';
  }
}
