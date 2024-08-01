import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/item_data.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/leave/list_leave.dart';
import 'package:base_app/presentations/widgets/activate/leave/list_leave_history.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final leavePageRoute = GoRoute(
    path: Pages.leavePage,
    name: Pages.leavePage,
    builder: (context, GoRouterState state) => const LeavePage());

class LeavePage extends StatefulWidget {
  const LeavePage({super.key});

  @override
  State<LeavePage> createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this)..addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colors.text),
        title: Text(
          appLocalizations.leaveManagement,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ContainerScreenMain(
          child: SizedBox(
            height: height * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TabBar(
                  controller: _tabController,
                  tabs: ItemUtils.titlesTabBar(context)
                      .map(
                        (element) => Tab(
                          child: Text(
                            element,
                            style: TextStyle(color: colors.text, fontSize: SpacingUnit.x4),
                          ),
                        ),
                      )
                      .toList(),
                ),
                Expanded(
                  flex: 7,
                  child: SizedBox(
                    child: TabBarView(
                      controller: _tabController,
                      children: const [
                        ListLeaveWidget(),
                        ListLeaveHistoryWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _scrollListener() {}
}
