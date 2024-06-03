import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/user_enum.dart';
import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/menu_values.dart';
import 'package:base_app/data/models/request/change_list_status/change_status_request_command_models.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/request/request/request_bloc.dart';
import 'package:base_app/presentations/bloc/request/request/request_event.dart';
import 'package:base_app/presentations/bloc/request/request/request_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_manager/user_by_admin_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_manager/user_by_admin_event.dart';
import 'package:base_app/presentations/bloc/user/user_by_manager/user_by_admin_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_event.dart';
import 'package:base_app/presentations/widgets/admin/request_by_manager/list_users_by_manager.dart';
import 'package:base_app/presentations/widgets/custom/shimmer_load.dart';
import 'package:base_app/presentations/widgets/dialog/dialog.dart';
import 'package:base_app/presentations/widgets/request/item/item_list_approve_by_manager.dart';
import 'package:common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ManagementRequest extends StatefulWidget {
  const ManagementRequest({super.key});

  @override
  State<ManagementRequest> createState() => _ManagementRequestState();
}

class _ManagementRequestState extends State<ManagementRequest> {
  late String dropdownTypeRequestValue;
  late String startDate, endDate;
  List<String> listDropdownCheckApproverValue = [], listNotes = [], listRequestId = [];

  @override
  void initState() {
    dropdownTypeRequestValue = MenuValues.listSearchTypeRequest.first;
    startDate = formatYMD(DateTime.now().toString());
    endDate = formatYMD(DateTime.now().toString());
    dI<RequestBloc>().add(GetRequestByAdminEvent(
        type: dropdownTypeRequestValue, startDate: startDate, endDate: endDate));
    dI<UserByAdminBloc>().add(GetUserByManagerEvent(startDate, endDate));
    dI<UserByRolesBloc>().add(GetUserByRoleEvent(role: dI<UserBloc>().state.user.id));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: BlocConsumer<RequestBloc, RequestState>(
        listener: (context, state) => _listener(context, state),
        listenWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return BlocBuilder<UserByAdminBloc, UserByAdminState>(
            builder: (context, stateUser) {
              return SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
                  padding: const EdgeInsets.symmetric(
                      vertical: SpacingUnit.x2, horizontal: SpacingUnit.x2),
                  height: MediaQuery.sizeOf(context).height,
                  decoration: BoxDecoration(
                    color: CustomsColor.colorBackground,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(SpacingUnit.x4),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            appLocalizations.typeRequest,
                            style: TextStyle(fontSize: SpacingUnit.x4_5, color: colors.text),
                          ),
                          const SizedBox(
                            width: SpacingUnit.x3_5,
                          ),
                          DropdownMenu<String>(
                            initialSelection: MenuValues.listSearchTypeRequest.first,
                            onSelected: (String? value) {
                              dropdownTypeRequestValue = value!;
                            },
                            dropdownMenuEntries: dI<UserBloc>().state.user.id ==
                                    ConfigRoleStringValues.generalManager.name
                                ? MenuValues.listSearchTypeRequestByAdmin
                                    .map<DropdownMenuEntry<String>>((String value) {
                                    return DropdownMenuEntry<String>(value: value, label: value);
                                  }).toList()
                                : MenuValues.listSearchTypeRequest
                                    .map<DropdownMenuEntry<String>>((String value) {
                                    return DropdownMenuEntry<String>(value: value, label: value);
                                  }).toList(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        onPressed: () => _getRequestsOrListUser(context),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
                          overlayColor: MaterialStateProperty.all<Color>(Colors.indigo),
                        ),
                        child: Text(
                          appLocalizations.search,
                          style: TextStyle(fontSize: 18, color: colors.text),
                        ),
                      ),
                      const SizedBox(
                        height: SpacingUnit.x4_5,
                      ),
                      if (_checkNotExplanation(state))
                        Expanded(
                          child: checkStatus(state)
                              ? ListView.builder(
                                  itemCount: state.requests.length,
                                  itemBuilder: (context, index) => GestureDetector(
                                    onTap: () async => _appNavigation(context, state, index),
                                    child: ItemListApproveByManager(
                                      index: index,
                                      dropdownTypeRequestValue: dropdownTypeRequestValue,
                                      onChangeStatus: (value) =>
                                          listDropdownCheckApproverValue[index] = value,
                                      callback: () => _openDialog(context, index),
                                    ),
                                  ),
                                )
                              : const ShimmerLoad(),
                        ),
                      if (_checkNotExplanation(state))
                        ElevatedButton(
                          onPressed: () => _changeStatusDialog(context),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
                            overlayColor: MaterialStateProperty.all<Color>(Colors.indigo),
                          ),
                          child: Text(
                            appLocalizations.save,
                            style: TextStyle(fontSize: 18, color: colors.text),
                          ),
                        ),
                      if (dropdownTypeRequestValue == TypeRequestStatus.explanation.name)
                        const Expanded(
                          child: ListUsersByManager(),
                        )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  bool _checkNotExplanation(RequestState state) {
    return state.requests.isNotEmpty &&
        dropdownTypeRequestValue != TypeRequestStatus.explanation.name;
  }

  countList(BuildContext context, RequestState state) {
    setState(() {
      listRequestId = state.requests.map((e) => e.id).toList();
      listDropdownCheckApproverValue =
          List.generate(state.requests.length, (index) => MenuValues.checkApprover.first);
      listNotes = List.generate(state.requests.length, (index) => '');
    });
  }

  List<ChangeStatusRequestCommandModels> changeStatusRequestCommandModels() {
    List<ChangeStatusRequestCommandModels> list = [];
    for (int i = 0; i < listRequestId.length; i++) {
      list.add(ChangeStatusRequestCommandModels(
          requestId: listRequestId[i],
          status: listDropdownCheckApproverValue[i],
          note: listNotes[i]));
    }
    list = list.where((e) => e.status != 'Pending').toList();
    return list;
  }

  _changeStatusDialog(BuildContext context) {
    changeStatusRequestByManagerDialog(
        context,
        () => dI<RequestBloc>().add(ChangeListStatusEvent(
            changeStatusRequestCommandModels: changeStatusRequestCommandModels(),
            enumRequestType: dropdownTypeRequestValue)));
  }

  _openDialog(BuildContext context, int index) {
    noteDialog(context, (value) {
      setState(() {
        listNotes[index] = value;
      });
    });
  }

  _getRequestsOrListUser(BuildContext context) {
    dI<RequestBloc>().add(const ResetRequestEvent());
    dI<RequestBloc>().add(GetRequestByAdminEvent(
        type: dropdownTypeRequestValue, startDate: startDate, endDate: endDate));
    if (dropdownTypeRequestValue == TypeRequestStatus.explanation.name) {
      dI<UserByAdminBloc>().add(GetUserByManagerEvent(startDate, endDate));
    }
  }

  _appNavigation(BuildContext context, RequestState state, int index) {
    if (dropdownTypeRequestValue == TypeRequestStatus.overTime.name) {
      dI<AppNavigation>()
          .pushName(context, page: Pages.overTimeRequest, extra: {'id': state.requests[index].id});
    } else if (dropdownTypeRequestValue == TypeRequestStatus.explanation.name) {
      dI<AppNavigation>().pushName(context,
          page: Pages.getExplanationRequest, extra: {'id': state.requests[index].id});
    } else if (dropdownTypeRequestValue == TypeRequestStatus.onLeave.name) {
      dI<AppNavigation>()
          .pushName(context, page: Pages.onLeaveRequest, extra: {'id': state.requests[index].id});
    } else {
      dI<RequestBloc>().add(GetRequestByIdEvent(id: state.requests[index].id));
      dI<AppNavigation>()
          .pushName(context, page: Pages.requestDefault, extra: {'id': state.requests[index].id});
    }
  }

  bool checkStatus(RequestState state) {
    return (state.status != RequestStatus.getRequestByAdminInit ||
        state.status != RequestStatus.getRequestByAdminError ||
        state.status != RequestStatus.getUsersInit ||
        state.status != RequestStatus.getUsersError);
  }

  _listener(BuildContext context, RequestState state) {
    if (checkStatus(state)) {
      countList(context, state);
    }
    if (state.status == RequestStatus.changeStatusRequestSuccess) {
      _getRequestsOrListUser(context);
    }
  }
}
