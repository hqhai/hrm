import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/bloc/location/school/school_bloc.dart';
import 'package:base_app/presentations/bloc/location/school/school_state.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemListSchool extends StatelessWidget {
  const ItemListSchool({
    super.key,
    this.schoolId = '',
  });

  final String schoolId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SchoolBloc, SchoolState>(
      builder: (context, state) {
        final school = state.schools[schoolId];
        final colors = AppTheme.getColors(context);
        if (school == null) return const SizedBox();
        return GestureDetector(
          onTap: () => _nextTimekeepingGPSScreen(context,),
          child: ContainerBorder(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  school.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5),
                ),
                Text(
                  school.address,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: colors.blue, fontSize: SpacingUnit.x3),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _nextTimekeepingGPSScreen(BuildContext context,) {
    dI<AppNavigation>().pushName(
      context,
      page: Pages.timekeepingGPSPage,
      extra: {
        'idSchool': schoolId,
      },
    );
  }
}
