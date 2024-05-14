import 'dart:convert';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/request/overtime/create_overtime_config_request.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/request/request/request_bloc.dart';
import 'package:base_app/presentations/bloc/request/request/request_event.dart';
import 'package:base_app/presentations/bloc/request/request/request_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final overTimeRequestPageRoute = GoRoute(
    name: Pages.overTimeRequest,
    path: Pages.overTimeRequest,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return RequestOverTimePage(
        id: data['id'],
      );
    });

class RequestOverTimePage extends StatefulWidget {
  const RequestOverTimePage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<RequestOverTimePage> createState() => _RequestOverTimePageState();
}

class _RequestOverTimePageState extends State<RequestOverTimePage> {
  List<CreateOverTimeConfigRequest> result = [];
  final TextEditingController noteController = TextEditingController();
  String idRequest = '', note = '', creator = '', timeCreated = '', phoneNumber = '';

  listener(RequestState state) {
    if (state.status == RequestStatus.getRequestByIdSuccess) {
      setState(() {
        Map<String, dynamic> jsonData = json.decode(state.request.configStr ?? '');
        List<dynamic> requestList = jsonData['listRequestTypes'];
        result = requestList.map((item) {
          return CreateOverTimeConfigRequest.fromJson(item);
        }).toList();
        idRequest = state.request.createdUserId;
        note = state.request.note ?? '';
        creator = state.request.createdFullName ?? '';
        timeCreated = state.request.createdDate ?? '';
        phoneNumber = state.request.phoneNumber ?? '';
      });
    }
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    dI<RequestBloc>().add(GetRequestByIdEvent(id: widget.id));
    noteController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<RequestBloc, RequestState>(
          listener: (context, state) => listener(state),
          listenWhen: (previous, current) => previous.status != current.status,
          child: Container(
            margin:
                const EdgeInsets.symmetric(horizontal: SpacingUnit.x1, vertical: SpacingUnit.x2),
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              color: CustomsColor.colorBackground,
              borderRadius: const BorderRadius.all(
                Radius.circular(SpacingUnit.x4),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(SpacingUnit.x5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          appLocalizations.creator,
                          style: const TextStyle(fontSize: SpacingUnit.x5, color: Colors.orange),
                        ),
                        const SizedBox(
                          width: SpacingUnit.x4_5,
                        ),
                        Text(
                          creator,
                          style: TextStyle(fontSize: SpacingUnit.x4_5, color: colors.text),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: SpacingUnit.x4,
                    ),
                    Row(
                      children: [
                        Text(
                          appLocalizations.phoneNumber,
                          style: const TextStyle(fontSize: SpacingUnit.x5, color: Colors.orange),
                        ),
                        const SizedBox(
                          width: SpacingUnit.x4_5,
                        ),
                        Text(
                          phoneNumber,
                          style: TextStyle(fontSize: SpacingUnit.x4_5, color: colors.text),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: SpacingUnit.x4,
                    ),
                    Row(
                      children: [
                        Text(
                          appLocalizations.createTime,
                          style: const TextStyle(fontSize: SpacingUnit.x5, color: Colors.orange),
                        ),
                        const SizedBox(
                          width: SpacingUnit.x4_5,
                        ),
                        Text(
                          formatYMD(timeCreated),
                          style: TextStyle(fontSize: SpacingUnit.x4_5, color: colors.text),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: SpacingUnit.x4,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: ListView.builder(
                        itemCount: result.length,
                        itemBuilder: (context, index) => Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          appLocalizations.startTime,
                                          style: const TextStyle(
                                              fontSize: SpacingUnit.x6, color: Colors.orange),
                                        ),
                                        const SizedBox(
                                          width: SpacingUnit.x3_5,
                                        ),
                                        Text(
                                          appLocalizations.endTime,
                                          style: const TextStyle(
                                              fontSize: SpacingUnit.x6, color: Colors.orange),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: SpacingUnit.x3,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              maxLines: 2,
                                              formatYMD(result[index].startOverTime),
                                              style: TextStyle(
                                                color: colors.text,
                                                fontSize: SpacingUnit.x4_5,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: SpacingUnit.x1,
                                            ),
                                            Text(
                                              maxLines: 2,
                                              formatHMS(result[index].startOverTime),
                                              style: TextStyle(
                                                color: colors.text,
                                                fontSize: SpacingUnit.x4_5,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: SpacingUnit.x3_5,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              maxLines: 2,
                                              formatYMD(result[index].endOverTime),
                                              style: TextStyle(
                                                color: colors.text,
                                                fontSize: SpacingUnit.x4_5,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: SpacingUnit.x1,
                                            ),
                                            Text(
                                              maxLines: 2,
                                              formatHMS(result[index].endOverTime),
                                              style: TextStyle(
                                                color: colors.text,
                                                fontSize: SpacingUnit.x4_5,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: SpacingUnit.x6_5,
                                ),
                                Text(
                                  appLocalizations.project,
                                  style: const TextStyle(
                                    color: Colors.orange,
                                    fontSize: SpacingUnit.x4_5,
                                  ),
                                ),
                                const SizedBox(
                                  height: SpacingUnit.x3,
                                ),
                                Text(
                                  result[index].project,
                                  style: TextStyle(
                                    color: colors.text,
                                    fontSize: SpacingUnit.x4_5,
                                  ),
                                ),
                                const SizedBox(
                                  height: SpacingUnit.x6_5,
                                ),
                                Text(
                                  appLocalizations.task,
                                  style: const TextStyle(
                                    color: Colors.orange,
                                    fontSize: SpacingUnit.x4_5,
                                  ),
                                ),
                                const SizedBox(
                                  height: SpacingUnit.x3,
                                ),
                                Text(
                                  result[index].task,
                                  maxLines: 10,
                                  style: TextStyle(
                                    color: colors.text,
                                    fontSize: SpacingUnit.x4_5,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: SpacingUnit.x4_5,
                            ),
                            const Divider(
                              height: 1,
                              thickness: 3,
                              indent: 0,
                              endIndent: 0,
                              color: Colors.blue,
                            ),
                            const SizedBox(
                              height: SpacingUnit.x4_5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (note != '')
                      Column(
                        children: [
                          const SizedBox(
                            height: SpacingUnit.x4_5,
                          ),
                          Text(
                            appLocalizations.note,
                            style: TextStyle(
                              color: colors.text,
                              fontSize: SpacingUnit.x4_5,
                            ),
                          ),
                          const SizedBox(
                            height: SpacingUnit.x4_5,
                          ),
                          Text(
                            note,
                            style: TextStyle(
                              color: colors.text,
                              fontSize: SpacingUnit.x4_5,
                            ),
                          ),
                          const SizedBox(
                            height: SpacingUnit.x4_5,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
