import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/notification_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/notification/notification_bloc.dart';
import 'package:base_app/presentations/bloc/notification/notification_event.dart';
import 'package:base_app/presentations/bloc/notification/notification_state.dart';
import 'package:base_app/presentations/widgets/custom/shimmer_load.dart';
import 'package:base_app/presentations/widgets/notification/item_in_list_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class NotificationTab extends StatefulWidget {
  const NotificationTab({
    super.key,
    required this.checkLoad,
    required this.checkSent,
  });

  final bool checkLoad;
  final bool checkSent;

  @override
  State<NotificationTab> createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  late ScrollController _scrollController;
  int pageIndex = 1, totalItems = 12, lengthList = 11;
  bool loadMore = true;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x4),
      child: BlocConsumer<NotificationBloc, NotificationState>(
        listener: (context, state) => _listener(state),
        builder: (context, state) {
          if (!widget.checkLoad) return const ShimmerLoad();

          if (state.keys.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off_outlined,
                    size: 64,
                    color: colors.text.withValues(alpha: 0.15),
                  ),
                  const SizedBox(height: SpacingUnit.x4),
                  Text(
                    l10n.noNotification,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.text.withValues(alpha: 0.4),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.only(top: SpacingUnit.x2),
            itemCount: state.keys.length,
            itemBuilder: (context, index) => ItemInListNotification(
              checkSent: widget.checkSent,
              id: state.keys[index],
            ),
          );
        },
      ),
    );
  }

  _scrollListener() async {
    if (lengthList < totalItems &&
        _scrollController.position.extentAfter < totalItems &&
        loadMore) {
      setState(() {
        pageIndex++;
        loadMore = false;
      });
      Completer completer = Completer<bool>();
      dI<NotificationBloc>().add(
        GetNotificationsEvent(
          page: pageIndex,
          status: widget.checkSent
              ? NotificationStatus.sent
              : NotificationStatus.read,
          completer: completer,
        ),
      );
      final check = await completer.future;
      if (check) {
        setState(() => loadMore = true);
      }
    }
  }

  _listener(NotificationState state) {
    setState(() {
      totalItems = state.totalItems;
      lengthList = state.keys.length;
    });
  }
}
