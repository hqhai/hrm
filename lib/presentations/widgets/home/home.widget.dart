import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Container(
          padding:
          const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
          margin:
          const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
          height: MediaQuery
              .sizeOf(context)
              .height,
          decoration: BoxDecoration(
            color: CustomsColor.colorBackground,
            borderRadius: const BorderRadius.all(
              Radius.circular(SpacingUnit.x4),
            ),
          ),
          child: Column(children: [
            Container(
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
                children: [
                  Column(children: [
                    Text('Nguyeenx Van A'),
                    Text('Chuc vu:')
                  ],)
                ],
              ),
            ),
          ]),
        );
      },
    );
  }
}
