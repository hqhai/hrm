import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_state.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemFollowersInformationRequest extends StatelessWidget {
  const ItemFollowersInformationRequest({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<UserByIdBloc, UserByIdState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appLocalizations.follower,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: SpacingUnit.x2),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: state.userById
                      .mapIndexed(
                        (index, element) => ContainerBorder(
                          margin: SpacingUnit.x2,
                          child: Row(
                            children: [
                              Text(
                                '${index + 1}.   ${state.userById[index].fullName}',
                                style: TextStyle(
                                  color: colors.blue,
                                  fontSize: SpacingUnit.x4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
