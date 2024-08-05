import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:base_app/presentations/widgets/attendance/calendar/layout_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemHomeCalenderWidget extends StatelessWidget {
  const ItemHomeCalenderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SpacingUnit.x2),
            color: colors.background,
            border: Border.all(
              color: colors.text,
              width: 1,
            ),
          ),
          child: const LayoutCalendar(),
        );
      },
    );
  }

}
