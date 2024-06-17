import 'package:base_app/common/enum/user_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:base_app/presentations/widgets/profile/item_text_content_profile.dart';
import 'package:base_app/presentations/widgets/profile/item_text_title_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemVehicleProfile extends StatelessWidget {
  const ItemVehicleProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: SpacingUnit.x3),
              child: Text(
                appLocalizations.vehicle,
                style: TextStyle(
                    color: colors.text, fontSize: SpacingUnit.x3, fontWeight: FontWeight.w800),
              ),
            ),
            ItemTitleProfile(
              title1: appLocalizations.vehicleType,
              title2: appLocalizations.licensePlate,
            ),
            ItemContentProfile(
              content1: state.user.vehicleType?.configVehicleTypeName ?? "",
              content2: state.user.licensePlate ?? "",
            ),
            Text(
              appLocalizations.autoMaker,
              style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: SpacingUnit.x1),
                    child: Container(
                      width: width * 0.5,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: colors.text,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Text(
                        state.user.autoMaker ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                        style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3),
                      ),
                    ),
                  ),
                ),
                const Expanded(
                    child: SizedBox(
                  width: SpacingUnit.x3,
                ))
              ],
            ),
          ],
        );
      },
    );
  }
}
