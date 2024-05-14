import 'dart:convert';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/menu_values.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/data/models/request/change_list_status/change_status_request_command_models.dart';
import 'package:base_app/domain/entities/request.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/request/request/request_bloc.dart';
import 'package:base_app/presentations/bloc/request/request/request_event.dart';
import 'package:base_app/presentations/bloc/request/request/request_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/widgets/dialog/dialog.dart';
import 'package:common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final listExplanationByUserPageRoute = GoRoute(
    name: Pages.listExplanationByUserPage,
    path: Pages.listExplanationByUserPage,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return ListExplanationByUserPage(
        id: data['id'],
      );
    });

class ListExplanationByUserPage extends StatefulWidget {
  const ListExplanationByUserPage({super.key, required this.id});

  final String id;

  @override
  State<ListExplanationByUserPage> createState() => _ListExplanationByUserPageState();
}

class _ListExplanationByUserPageState extends State<ListExplanationByUserPage> {
  List<String> listDropdownCheckApproverValue = [], listNotes = [], listRequestId = [];
  List<Request> listRequest = [];
  List<bool> check = [];

  @override
  void initState() {
    listRequest = dI<RequestBloc>().state.requestsByUser;
    countList(listRequest);
    super.initState();
  }

  _listener(BuildContext context, RequestState state) {
    if (state.status == RequestStatus.changeStatusRequestError) {
      setState(() {
        check = List.generate(listRequest.length, (index) => true);
      });
    } else if (state.status == RequestStatus.changeStatusRequestSuccess) {
      setState(() {
        final List<Request> list1 =
            listRequest.where((request) => check[listRequest.indexOf(request)] != false).toList();
        final List<String> list2 = listDropdownCheckApproverValue
            .where((e) => check[listDropdownCheckApproverValue.indexOf(e)] != false)
            .toList();
        final List<String> list3 =
            listNotes.where((e) => check[listNotes.indexOf(e)] != false).toList();
        final List<String> list4 =
            listRequestId.where((e) => check[listRequestId.indexOf(e)] != false).toList();

        listRequest = list1;
        listDropdownCheckApproverValue = list2;
        listNotes = list3;
        listRequestId = list4;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<RequestBloc, RequestState>(
        listener: (context, state) {
          _listener(context, state);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2, horizontal: SpacingUnit.x2),
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            color: CustomsColor.colorBackground,
            borderRadius: const BorderRadius.all(
              Radius.circular(SpacingUnit.x4),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  height: 120 * listRequest.length.toDouble(),
                  child: ListView.builder(
                    itemCount: listRequest.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _getExplanation(index),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
                          padding: const EdgeInsets.all(SpacingUnit.x2),
                          decoration: const BoxDecoration(
                            color: Color(0xff293656),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      listRequest[index].createdFullName??'',
                                      style:
                                          TextStyle(fontSize: SpacingUnit.x4, color: colors.text),
                                    ),
                                    Text(
                                      '${appLocalizations.lateTime} ${lateDay(listRequest[index].configStr??'')}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          TextStyle(fontSize: SpacingUnit.x4, color: colors.text),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () => _note(context, index),
                                child: const Icon(
                                  Icons.note,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(
                                width: SpacingUnit.x3,
                              ),
                              DropdownMenu<String>(
                                width: 100,
                                textStyle: const TextStyle(
                                  fontSize: SpacingUnit.x3,
                                ),
                                initialSelection: listRequest[index].status,
                                onSelected: (String? value) {
                                  setState(() {
                                    listDropdownCheckApproverValue[index] = value!;
                                  });
                                },
                                dropdownMenuEntries: _check()
                                    ? MenuValues.checkApprover
                                        .map<DropdownMenuEntry<String>>((String value) {
                                        return DropdownMenuEntry<String>(
                                            value: value, label: value);
                                      }).toList()
                                    : MenuValues.checkManagerApprover
                                        .map<DropdownMenuEntry<String>>((String value) {
                                        return DropdownMenuEntry<String>(
                                            value: value, label: value);
                                      }).toList(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => dI<RequestBloc>().add(ChangeListStatusEvent(
                    changeStatusRequestCommandModels: changeStatusRequestCommandModels(), enumRequestType: TypeRequestStatus.explanation.name)),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
                  overlayColor: MaterialStateProperty.all<Color>(Colors.indigo),
                ),
                child: Text(
                  appLocalizations.save,
                  style: TextStyle(fontSize: 18, color: colors.text),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _check() {
    return dI<UserBloc>().state.user.role == ConfigStringValues.manager.name;
  }

  countList(List<Request> listRequest) {
    listRequestId = listRequest.map((e) => e.id).toList();
    listDropdownCheckApproverValue =
        List.generate(listRequest.length, (index) => MenuValues.checkManagerApprover.first);
    listNotes = List.generate(listRequest.length, (index) => '');
    check = List.generate(listRequest.length, (index) => true);
  }

  String lateDay(String json) {
    Map<String, dynamic> jsonMap = jsonDecode(json);
    String lateDay = jsonMap['lateDay'];
    return formatYMDHMS(lateDay);
  }

  _note(BuildContext context, int index) {
    noteDialog(
      context,
      (value) {
        setState(() {
          listNotes[index] = value;
        });
      },
    );
  }

  _getExplanation(int index) {
    dI<AppNavigation>().pushName(context, page: Pages.getExplanationRequest, extra: {
      'id': listRequest[index].id,
    });
  }

  List<ChangeStatusRequestCommandModels> changeStatusRequestCommandModels() {
    List<ChangeStatusRequestCommandModels> list = [];
    for (int i = 0; i < listRequestId.length; i++) {
      list.add(ChangeStatusRequestCommandModels(
          requestId: listRequestId[i],
          status: listDropdownCheckApproverValue[i],
          note: listNotes[i]));
      if (listDropdownCheckApproverValue[i] != StatusRequestStatus.subsequentApproval.name &&
          listDropdownCheckApproverValue[i] != StatusRequestStatus.pending.name) {
        setState(() {
          check[i] = false;
        });
      }
    }
    list = list
        .where((e) =>
            e.status != StatusRequestStatus.pending.name &&
            e.status != StatusRequestStatus.subsequentApproval.name)
        .toList();
    return list;
  }

  List<Request> requests(List<Request> requests, String userId) {
    List<Request> listRequests = requests.where((e) => e.createdUserId == userId).toList();
    return listRequests;
  }
}
