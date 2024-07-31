import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_bloc.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_state.dart';
import 'package:base_app/presentations/widgets/activate/timekeeping/item_list_school.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleSchoolBloc, ScheduleSchoolState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: ContainerScreenMain(
            child: Column(
              children: [
                ItemListSchool(
                  schoolId: state.scheduleSchool.school?.id ?? "",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
