import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/data/models/request/overtime/create_overtime_config_request.dart';
import 'package:base_app/data/models/request/overtime/list_request_types.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/request/request/request_bloc.dart';
import 'package:base_app/presentations/bloc/request/request/request_event.dart';
import 'package:base_app/presentations/bloc/request/request/request_state.dart';
import 'package:base_app/presentations/widgets/create_request/item_create_overtime_or_onleave.dart';
import 'package:base_app/presentations/widgets/dialog/dialog.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/success_or_unsuccess_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:themes/themes.dart';

class CreateRequestOTWidget extends StatefulWidget {
  const CreateRequestOTWidget({super.key});

  @override
  State<CreateRequestOTWidget> createState() => _CreateRequestOTWidgetState();
}

class _CreateRequestOTWidgetState extends State<CreateRequestOTWidget> {
  List<String> startTime = [""], endTime = [""], project = [""], task = [""];
  String notification = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _listener(BuildContext context, RequestState state) {
    if (state.status == RequestStatus.createRequestSuccess) {
      Navigator.of(context).pop();
      successDialog(context);
    } else if (state.status == RequestStatus.createRequestInit) {
      Navigator.of(context).pop();
      progressIndicatorDialog(context);
    } else if (state.status == RequestStatus.createRequestError) {
      Navigator.of(context).pop();
      unsuccessfulDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocConsumer<RequestBloc, RequestState>(
      listener: (context, state) => _listener(context, state),
      builder: (context, state) {
        return Container(
          height: MediaQuery.sizeOf(context).height,
          decoration: BoxDecoration(
            color: CustomsColor.colorBackground,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(SpacingUnit.x1),
                height: startTime.isNotEmpty ? 400 : 0,
                decoration: const BoxDecoration(
                  color: Color(0xff232d46),
                  borderRadius: BorderRadius.all(
                    Radius.circular(SpacingUnit.x4),
                  ),
                ),
                child: ListView.builder(
                  itemCount: startTime.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      ItemCreateOTOrOL(
                        onChangeTitle: (value) {
                          setState(() {
                            project[index] = value;
                          });
                        },
                        onChangeContent: (value) {
                          setState(() {
                            task[index] = value;
                          });
                        },
                        onChangeEndTime: (value) {
                          endTime[index] = value;
                        },
                        onChangeStartTime: (value) {
                          startTime[index] = value;
                        },
                        title: appLocalizations.project,
                        content: appLocalizations.task,
                        type: 'OT',
                      ),
                      IconButton(
                        onPressed: () {
                          _removeList(index);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(CustomsColor.colorBackground),
                          overlayColor: MaterialStateProperty.all<Color>(Colors.indigo),
                        ),
                        icon: const Icon(Icons.delete, color: Colors.red, size: 30),
                      ),
                      const SizedBox(
                        height: SpacingUnit.x4_5,
                      ),
                      const Divider(
                        height: 1,
                        thickness: 3,
                        indent: 0,
                        endIndent: 0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  _addList();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  overlayColor: MaterialStateProperty.all<Color>(Colors.indigo),
                ),
                icon: const Icon(Icons.add, color: Colors.white, size: 20),
              ),
              const SizedBox(
                height: SpacingUnit.x4_5,
              ),
              if (notification != '')
                Text(
                  notification,
                  style: TextStyle(fontSize: SpacingUnit.x4, color: colors.error),
                ),
              const SizedBox(height: SpacingUnit.x4),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: startTime.isNotEmpty ? Colors.blue : Colors.indigo),
                onPressed: () {
                  if (startTime.isNotEmpty) {
                    _notificationAndDialog(context);
                  }
                },
                child: Text(
                  appLocalizations.create,
                  style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5),
                ),
              ),
              const SizedBox(
                width: SpacingUnit.x5,
              ),
            ],
          ),
        );
      },
    );
  }

  _removeList(int index) {
    setState(() {
      task.removeAt(index);
      project.removeAt(index);
      startTime.removeAt(index);
      endTime.removeAt(index);
    });
  }

  _addList() {
    setState(() {
      task.add('');
      project.add('');
      startTime.add(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()));
      endTime.add(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()));
    });
  }

  _notificationAndDialog(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    if (onOTValue().listRequestTypes != null &&
        onOTValue()
            .listRequestTypes!
            .where((e) => e.project == '' || e.task == '')
            .toList()
            .isNotEmpty) {
      setState(() {
        notification = appLocalizations.projectAndTasksCannotBeLeftBlank;
      });
    } else if (onOTValue().listRequestTypes != null &&
        onOTValue()
            .listRequestTypes!
            .where((e) => DateTime.parse(e.startOverTime).difference(DateTime.now()).inSeconds < 0)
            .toList()
            .isNotEmpty) {
      setState(() {
        notification = appLocalizations.bookingTimeMustBeAfterCurrentTime;
      });
    } else if (onOTValue().listRequestTypes != null &&
        onOTValue().listRequestTypes!.where((e) => e.totalTime <= 0).toList().isNotEmpty) {
      setState(() {
        notification = appLocalizations.endTimeMustBeAfterStartTime;
      });
    } else {
      setState(() {
        notification = '';
      });
      createRequestDialog(
        context,
        () {
          dI<RequestBloc>().add(CreateOvertimeRequestEvent(
            type: 'Overtime',
            isApprove: true,
            config: onOTValue(),
          ));
        },
      );
    }
  }

  ListRequestTypes onOTValue() {
    final List<CreateOverTimeConfigRequest> list = [];
    for (int i = 0; i < startTime.length; i++) {
      if (startTime[i] == '' && endTime[i] == '') {
        list.add(CreateOverTimeConfigRequest(
          project: project[i],
          task: task[i],
          endOverTime: formatIso8601(
            DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
          ),
          startOverTime: formatIso8601(
            DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
          ),
          totalTime: 0,
        ));
      } else if (startTime[i] == '') {
        list.add(
          CreateOverTimeConfigRequest(
              project: project[i],
              task: task[i],
              endOverTime: formatIso8601(endTime[i]),
              startOverTime: formatIso8601(
                DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
              ),
              totalTime: (DateTime.parse(endTime[i]).difference(DateTime.now())).inHours.toInt()),
        );
      } else if (endTime[i] == '') {
        list.add(
          CreateOverTimeConfigRequest(
              project: project[i],
              task: task[i],
              endOverTime: formatIso8601(
                DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
              ),
              startOverTime: formatIso8601(startTime[i]),
              totalTime: (DateTime.now().difference(DateTime.parse(startTime[i]))).inHours.toInt()),
        );
      } else {
        list.add(
          CreateOverTimeConfigRequest(
              project: project[i],
              task: task[i],
              endOverTime: formatIso8601(endTime[i]),
              startOverTime: formatIso8601(startTime[i]),
              totalTime: (DateTime.parse(endTime[i]).difference(DateTime.parse(startTime[i])))
                  .inHours
                  .toInt()),
        );
      }
    }
    ListRequestTypes listRequestTypes = ListRequestTypes(listRequestTypes: list);
    return listRequestTypes;
  }
}
