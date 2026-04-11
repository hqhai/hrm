import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/notification/notification_message.dart';
import 'package:base_app/presentations/bloc/notification/notification_bloc.dart';
import 'package:base_app/presentations/bloc/notification/notification_event.dart';
import 'package:base_app/presentations/bloc/notification/notification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemInListNotification extends StatefulWidget {
  const ItemInListNotification({
    super.key,
    required this.id,
    required this.checkSent,
  });

  final String id;
  final bool checkSent;

  @override
  State<ItemInListNotification> createState() => _ItemInListNotificationState();
}

class _ItemInListNotificationState extends State<ItemInListNotification> {
  bool checkClick = false;
  bool checkRead = false;

  @override
  void initState() {
    checkClick = !widget.checkSent;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);
    final isUnread = widget.checkSent && !checkClick;

    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        final notification =
            state.notifications[widget.id] ?? const NotificationMessage();
        final createdDate = notification.createdDate;
        final timeStr =
            createdDate != null ? formatHM(dateTimeLocal(createdDate).toString()) : '';
        final dateStr =
            createdDate != null ? formatDMY(dateTimeLocal(createdDate).toString()) : '';

        return GestureDetector(
          onTap: _onClick,
          child: Container(
            margin: const EdgeInsets.only(bottom: SpacingUnit.x2),
            padding: const EdgeInsets.all(SpacingUnit.x3_5),
            decoration: BoxDecoration(
              color: isUnread
                  ? Colors.blue.withValues(alpha: 0.05)
                  : Colors.white,
              borderRadius: BorderRadius.circular(SpacingUnit.x3),
              border: Border.all(
                color: isUnread
                    ? Colors.blue.withValues(alpha: 0.15)
                    : colors.text.withValues(alpha: 0.06),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isUnread
                        ? Colors.blue.withValues(alpha: 0.1)
                        : colors.text.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
                  ),
                  child: Icon(
                    isUnread
                        ? Icons.notifications_active_rounded
                        : Icons.notifications_none_rounded,
                    color: isUnread
                        ? Colors.blue
                        : colors.text.withValues(alpha: 0.4),
                    size: 22,
                  ),
                ),
                const SizedBox(width: SpacingUnit.x3),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.message,
                        maxLines: checkRead ? null : 2,
                        overflow: checkRead ? null : TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colors.text,
                          fontWeight:
                              isUnread ? FontWeight.w600 : FontWeight.w400,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: SpacingUnit.x2),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 13,
                            color: colors.text.withValues(alpha: 0.35),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$timeStr  •  $dateStr',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colors.text.withValues(alpha: 0.4),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Unread dot
                if (isUnread)
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(top: 6),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onClick() {
    if (!checkClick) {
      dI<NotificationBloc>().add(ChangeNotificationsEvent(
        ids: [widget.id],
      ));
    }
    setState(() {
      checkClick = true;
      checkRead = !checkRead;
    });
  }
}
