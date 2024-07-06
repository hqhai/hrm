import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/location/school/school_bloc.dart';
import 'package:base_app/presentations/bloc/location/school/school_event.dart';
import 'package:base_app/presentations/bloc/location/school/school_state.dart';
import 'package:base_app/presentations/widgets/activate/timekeeping/item_list_school.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:base_app/presentations/widgets/custom/app_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
  final TextEditingController searchController = TextEditingController();
  late ScrollController controller;
  int pageIndex = 1, totalItems = 0, lengthList = 0;
  bool checkLoad = true;

  @override
  void initState() {
    dI<SchoolBloc>().add(
      const GetListSchoolsEvent(page: 1),
    );
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocConsumer<SchoolBloc, SchoolState>(
      listener: (context, state) => _listener(state.totalItems, state.schoolIds.length),
      listenWhen: (previous, current) => _listenWhen(
        previous.schoolIds,
        current.schoolIds,
      ),
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(

            title: AppInput(
              controller: searchController,
              onChange: (value) => setSearch(value),
              placeHolder: appLocalizations.listSchools,
              icon:  Icons.search,
            ),
          ),
          body: ContainerScreenMain(
            child: ListView.builder(
              controller: controller,
              itemCount: state.schools.length,
              itemBuilder: (context, index) => ItemListSchool(
                schoolId: state.schoolIds[index],
              ),
            ),
          ),
        );
      },
    );
  }

  void _scrollListener() async {
    if (lengthList < totalItems &&
        checkLoad == true &&
        controller.position.extentAfter < totalItems) {
      setState(() {
        pageIndex++;
      });
      Completer completer = Completer<bool>();
      setState(() {
        checkLoad = false;
      });
      dI<SchoolBloc>().add(
        GetListSchoolsEvent(
          page: pageIndex,
          completer: completer,
        ),
      );
      final check = await completer.future;
      if (check) {
        setState(() {
          checkLoad = true;
        });
      }
    }
  }

  _listener(int total, int length) {
    setState(() {
      lengthList = length;
      checkLoad = true;
      totalItems = total;
    });
  }

  _listenWhen(List<String> schoolIds, List<String> schoolIds2) {
    return schoolIds != schoolIds2;
  }

  setSearch(String value) {
    setState(() {
      pageIndex = 1;
    });
    dI<SchoolBloc>().add(
      GetListSchoolsEvent(
        keyword: value,
        page: pageIndex,
      ),
    );
  }
}
