import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/notification_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
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

class _NotificationWidgetState extends State<NotificationWidget> with TickerProviderStateMixin {
  late final TabController _tabController;
  bool checkLoad = true;

  @override
  void initState() {
    dI<NotificationBloc>().add(const GetNotificationsEvent());
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0)
      ..addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Column(
      children: [
        Divider(
          color: colors.outline.withOpacity(0.2),
          height: SpacingUnit.x0_25,
        ),
        Container(
          color: colors.background,
          child: TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: colors.textLight.withOpacity(0.1),
            dividerHeight: 0.1,
            indicatorColor: colors.textLight,
            labelColor: colors.text,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: SpacingUnit.x4,
            ),
            unselectedLabelStyle: TextStyle(
              color: colors.text.withOpacity(0.5),
              fontSize: SpacingUnit.x4,
              fontWeight: FontWeight.normal,
            ),
            unselectedLabelColor: colors.text.withOpacity(0.5),
            tabs: NotificationStatus.values
                .map(
                  (e) => Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(e.configNotificationName),
                        if (e == NotificationStatus.sent)
                          BlocSelector<NotificationBloc, NotificationState, int>(
                            selector: (state) => state.totalItemsSent,
                            builder: (context, state) => state != 0
                                ? Chip(
                                    padding: EdgeInsets.zero,
                                    backgroundColor: colors.primary.withOpacity(0.3),
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(style: BorderStyle.none),
                                      borderRadius: BorderRadius.circular(SpacingUnit.x6),
                                    ),
                                    label: Text(
                                      '$state',
                                      style: TextStyle(
                                        fontSize: SpacingUnit.x3_5,
                                        fontWeight: FontWeight.w400,
                                        color: colors.primary,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          )
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        Expanded(
          child: Container(
            color: colors.background,
            child: TabBarView(
              controller: _tabController,
              children: [
                NotificationTab(checkLoad: checkLoad, checkSent: true),
                NotificationTab(checkLoad: checkLoad, checkSent: false),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _scrollListener() async {
    final Completer completer = Completer<bool>();
    setState(() {
      checkLoad = false;
    });
    dI<NotificationBloc>().add(
      GetNotificationsEvent(
        status: NotificationStatus.values[_tabController.index],
        completer: completer,
      ),
    );
    final check = await completer.future;
    if (check) {
      setState(() {
        checkLoad = true;
      });
    }
  }
}
