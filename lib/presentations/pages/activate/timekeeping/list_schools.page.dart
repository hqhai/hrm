import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/location/school/school_bloc.dart';
import 'package:base_app/presentations/bloc/location/school/school_event.dart';
import 'package:base_app/presentations/bloc/location/school/school_state.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final listSchoolsPageRoute = GoRoute(
    path: Pages.listSchoolsPage,
    name: Pages.listSchoolsPage,
    builder: (context, GoRouterState state) => const ListSchoolsPage());

class ListSchoolsPage extends StatefulWidget {
  const ListSchoolsPage({super.key});

  @override
  State<ListSchoolsPage> createState() => _ListSchoolsPageState();
}

class _ListSchoolsPageState extends State<ListSchoolsPage> {
  @override
  void initState() {
    dI<SchoolBloc>().add(const GetListSchoolsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocBuilder<SchoolBloc, SchoolState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              appLocalizations.timeKeeping,
              style: TextStyle(color: colors.text, fontSize: SpacingUnit.x6),
            ),
          ),
          body: ContainerScreenMain(
            child: ListView.builder(
              itemCount: state.schools.length,
              itemBuilder: (context, index) {
                final school = state.schools[state.schoolIds[index]];
                if (school == null) return const SizedBox();
                return GestureDetector(
                  onTap: () =>
                      _nextTimekeepingGPSScreen(context, state.schools.values.toList()[index].id),
                  child: ContainerBorder(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          school.nameSchool,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5),
                        ),
                        Text(
                          school.addressSchool,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: colors.blue, fontSize: SpacingUnit.x3),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  _nextTimekeepingGPSScreen(BuildContext context, String idSchool) {
    dI<AppNavigation>().pushName(
      context,
      page: Pages.timekeepingGPSPage,
      extra: {
        'idSchool': idSchool,
      },
    );
  }
}
