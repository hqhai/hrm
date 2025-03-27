import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_state.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemPersonInformationRequest extends StatelessWidget {
  const ItemPersonInformationRequest({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return BlocBuilder<UserByIdBloc, UserByIdState>(
      builder: (context, state) {
        return Padding(
          padding:
              const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
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
                  children: state.subtitudePersons
                      .mapIndexed(
                        (index, element) => ContainerBorder(
                          paddingVertical: SpacingUnit.x4,
                          borderColors: colors.text.withValues(alpha: 0.4),
                          marginTop: SpacingUnit.x2,
                          child: Row(
                            children: [
                              Text(
                                '${index + 1}.   ${state.subtitudePersons[index].fullName}',
                                style: TextStyle(
                                  color: colors.text,
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
