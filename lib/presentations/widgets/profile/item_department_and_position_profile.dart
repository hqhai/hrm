import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemDepartmentAndPositionProfile extends StatelessWidget {
  const ItemDepartmentAndPositionProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final department = state.user.userDepartmentPositions;
        final position = state.user.userDepartmentPositions;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLocalizations.department,
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x4,
                fontWeight: FontWeight.w600,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: department
                  .map(
                    (e) => Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
                      child: ContainerBorder(
                        paddingVertical: SpacingUnit.x4,
                        width: width,
                        marginTop: 0,
                        borderColors: colors.text.withValues(alpha: 0.2),
                        child: Text(
                          e.department?.name ?? "",
                          style: TextStyle(
                              color: colors.text, fontSize: SpacingUnit.x4),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            Text(
              appLocalizations.position,
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x4,
                fontWeight: FontWeight.w600,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: position
                  .map(
                    (e) => Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
                      child: ContainerBorder(
                        paddingVertical: SpacingUnit.x4,
                        width: width,
                        marginTop: 0,
                        borderColors: colors.text.withValues(alpha: 0.2),
                        child: Text(
                          e.position?.name ?? "",
                          style: TextStyle(
                              color: colors.text, fontSize: SpacingUnit.x4),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}
