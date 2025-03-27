import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/notification/notification_bloc.dart';
import 'package:base_app/presentations/bloc/notification/notification_event.dart';
import 'package:base_app/presentations/bloc/notification/notification_state.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class NotificationBottomSheet extends StatelessWidget {
  const NotificationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocSelector<NotificationBloc, NotificationState, List<String>>(
      selector: (state) => state.keys,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(SpacingUnit.x8),
          child: InkWell(
            onTap: () => readAllNotification(state, context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ContainerBorder(
                  marginTop: 0,
                  paddingHorizontal: SpacingUnit.x1,
                  paddingVertical: SpacingUnit.x1,
                  circular: SpacingUnit.x20,
                  borderColors: colors.blue.withValues(alpha: 0.3),
                  backgroundColors: colors.blue.withValues(alpha: 0.3),
                  child: SvgPicture.asset(
                    Assets.images.icon.work.success,
                    colorFilter:
                        ColorFilter.mode(colors.primary, BlendMode.srcIn),
                  ),
                ),
                const SizedBox(
                  width: SpacingUnit.x4,
                ),
                Text(
                  appLocalizations.readAll,
                  style: TextStyle(
                      fontSize: SpacingUnit.x4,
                      color: colors.primary,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  readAllNotification(List<String> state, BuildContext context) {
    if (state.isNotEmpty) {
      dI<NotificationBloc>()
          .add(const ChangeNotificationsEvent(ids: null, isAll: true));
    }
    dI<AppNavigation>().pop(context);
  }
}
