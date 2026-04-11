import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/notification_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/notification/notification_bloc.dart';
import 'package:base_app/presentations/bloc/notification/notification_event.dart';
import 'package:base_app/presentations/bloc/notification/notification_state.dart';
import 'package:base_app/presentations/widgets/notification/tab_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  bool checkLoad = true;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0)
      ..addListener(_scrollListener);
    super.initState();
    // Fetch fresh "unread" data for the default tab (index 0).
    // HomePage.initState already dispatches this, but with HydratedBloc
    // the stale persisted data may briefly show before the API responds.
    // The ResetNotificationEvent in HomePage.initState clears stale data,
    // so this fetch ensures the first tab always has fresh content.
    _fetchCurrentTab();
  }

  void _fetchCurrentTab() async {
    final completer = Completer<bool>();
    setState(() => checkLoad = false);
    dI<NotificationBloc>().add(
      GetNotificationsEvent(
        status: NotificationStatus.values[_tabController.index],
        completer: completer,
      ),
    );
    final check = await completer.future;
    if (check && mounted) {
      setState(() => checkLoad = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Header with "Mark all read" button
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingUnit.x4,
              vertical: SpacingUnit.x2,
            ),
            child: Row(
              children: [
                const Spacer(),
                BlocSelector<NotificationBloc, NotificationState, int>(
                  selector: (state) => state.totalItemsSent,
                  builder: (context, count) {
                    if (count == 0) return const SizedBox();
                    return GestureDetector(
                      onTap: () {
                        dI<NotificationBloc>().add(
                          const ChangeNotificationsEvent(
                              ids: null, isAll: true),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.done_all_rounded,
                              color: colors.primary, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            l10n.readAll,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // Tab bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: SpacingUnit.x4),
            decoration: BoxDecoration(
              color: colors.text.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(SpacingUnit.x3),
            ),
            padding: const EdgeInsets.all(3),
            child: TabBar(
              controller: _tabController,
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
              tabs: NotificationStatus.values
                  .where((e) => e != NotificationStatus.unknown)
                  .map(
                    (e) => Tab(
                      height: 38,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            e == NotificationStatus.sent
                                ? Icons.notifications_active_outlined
                                : Icons.notifications_none_rounded,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(e.configNotificationName),
                          if (e == NotificationStatus.sent)
                            BlocSelector<NotificationBloc, NotificationState,
                                int>(
                              selector: (state) => state.totalItemsSent,
                              builder: (context, count) => count > 0
                                  ? Container(
                                      margin: const EdgeInsets.only(left: 6),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 1),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        count > 99 ? '99+' : '$count',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: SpacingUnit.x2),
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                NotificationTab(checkLoad: checkLoad, checkSent: true),
                NotificationTab(checkLoad: checkLoad, checkSent: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _scrollListener() async {
    // Hide stale data immediately when swipe begins — don't wait for
    // the animation to finish, otherwise the old tab's cached data
    // briefly shows in the new tab.
    if (_tabController.indexIsChanging) {
      if (checkLoad) setState(() => checkLoad = false);
      return;
    }
    final Completer completer = Completer<bool>();
    if (checkLoad) setState(() => checkLoad = false);
    dI<NotificationBloc>().add(
      GetNotificationsEvent(
        status: NotificationStatus.values[_tabController.index],
        completer: completer,
      ),
    );
    final check = await completer.future;
    if (check) {
      setState(() => checkLoad = true);
    }
  }
}
