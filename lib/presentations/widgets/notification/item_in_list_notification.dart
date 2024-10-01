import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/notification/notification_message.dart';
import 'package:base_app/presentations/bloc/notification/notification_bloc.dart';
import 'package:base_app/presentations/bloc/notification/notification_event.dart';
import 'package:base_app/presentations/bloc/notification/notification_state.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemInListNotification extends StatefulWidget {
  const ItemInListNotification({super.key, required this.id, required this.checkSent});

  final String id;
  final bool checkSent;

  @override
  State<ItemInListNotification> createState() => _ItemInListNotificationState();
}

class _ItemInListNotificationState extends State<ItemInListNotification> {
  bool checkClick = false, checkRead = false;

  @override
  void initState() {
    checkClick = !widget.checkSent;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        final notification = state.notifications[widget.id] ?? const NotificationMessage();
        return InkWell(
          onTap: () => _onClick(),
          child: ContainerBorder(
            borderColors:
                widget.checkSent && !checkClick ? const Color(0xFFF4F7FF) : colors.background,
            backgroundColors:
                widget.checkSent && !checkClick ? const Color(0xFFF4F7FF) : colors.background,
            child: Column(
              children: [
                Text(
                  notification.message,
                  maxLines: checkRead ? null : 2,
                  overflow: checkRead ? null : TextOverflow.ellipsis,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                  ),
                ),
                const SizedBox(
                  height: SpacingUnit.x4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatHM(notification.createdDate.toString()),
                      style: TextStyle(
                        color: colors.text.withOpacity(0.5),
                        fontSize: SpacingUnit.x4,
                      ),
                    ),
                    Text(
                      formatDMY(dateTimeLocal(notification.createdDate).toString()),
                      style: TextStyle(
                        color: colors.text.withOpacity(0.5),
                        fontSize: SpacingUnit.x4,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _onClick() {
    if(!checkClick) {
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
