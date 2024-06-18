import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemHomeInforWidget extends StatelessWidget {
  const ItemHomeInforWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(SpacingUnit.x3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SpacingUnit.x2),
            color: CustomsColor.colorBackground,
            border: Border.all(
              color: colors.text,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(state.user.fullName,
                        maxLines: 1,
                        style: TextStyle(
                            overflow: TextOverflow.clip,
                            color: colors.text,
                            fontSize: SpacingUnit.x6,
                            fontWeight: FontWeight.w500)),
                    Row(
                      children: [
                        Text(
                          '${appLocalizations.position}:  ',
                          style: TextStyle(
                            color: colors.text,
                            fontSize: SpacingUnit.x4,
                          ),
                        ),
                        Text(
                          _getPositionName(state),
                          style: TextStyle(
                            color: colors.text,
                            fontSize: SpacingUnit.x4,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(SpacingUnit.x100),
                  child: Image.network(
                    height: width * 0.2,
                    state.user.avatarPath,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        height: width * 0.2,
                        Assets.images.error.imageError.path,
                        fit: BoxFit.fill,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getPositionName(UserState state) {
    return state.user.userDepartmentPositions.isNotEmpty
        ? state.user.userDepartmentPositions[0].position?.name ?? ""
        : "";
  }
}
