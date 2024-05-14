import 'dart:convert';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/request/on_leave/create_onleave_config_request.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/request/request/request_bloc.dart';
import 'package:base_app/presentations/bloc/request/request/request_event.dart';
import 'package:base_app/presentations/bloc/request/request/request_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final onLeaveRequestPageRoute = GoRoute(
    name: Pages.onLeaveRequest,
    path: Pages.onLeaveRequest,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return RequestOnLeavePage(
        id: data['id'],
      );
    });

class RequestOnLeavePage extends StatefulWidget {
  const RequestOnLeavePage({super.key, required this.id});

  final String id;

  @override
  State<RequestOnLeavePage> createState() => _RequestOnLeavePageState();
}

class _RequestOnLeavePageState extends State<RequestOnLeavePage> {
  CreateOnLeaveConfigRequest result = const CreateOnLeaveConfigRequest();
  String title = '', content = '', idRequest = '', creator = '', timeCreated = '', phoneNumber = '';

  final TextEditingController noteController = TextEditingController();

  listener(RequestState state) {
    setState(() {
      result = CreateOnLeaveConfigRequest.fromJson(json.decode(state.request.configStr??''));
      title = state.request.title ?? '';
      content = state.request.content ?? '';
      idRequest = state.request.createdUserId;
      creator = state.request.createdFullName ?? '';
      timeCreated = state.request.createdDate ?? '';
      phoneNumber = state.request.phoneNumber ?? '';
    });
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
          listener: (context, state) {
            listener(state);
          },
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
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  appLocalizations.creator,
                                  style: const TextStyle(
                                      fontSize: SpacingUnit.x5, color: Colors.orange),
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
                                  style: const TextStyle(
                                      fontSize: SpacingUnit.x5, color: Colors.orange),
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
                                  style: const TextStyle(
                                      fontSize: SpacingUnit.x5, color: Colors.orange),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  appLocalizations.startTime,
                                  style: const TextStyle(
                                      fontSize: SpacingUnit.x6, color: Colors.orange),
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
                                      formatYMD(result.startOnLeave),
                                      style: TextStyle(
                                        color: colors.text,
                                        fontSize: SpacingUnit.x4_5,
                                      ),
                                    ),
                                    Text(
                                      maxLines: 2,
                                      formatHMS(result.startOnLeave),
                                      style: TextStyle(
                                        color: colors.text,
                                        fontSize: SpacingUnit.x4_5,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      maxLines: 2,
                                      formatYMD(result.endOnLeave),
                                      style: TextStyle(
                                        color: colors.text,
                                        fontSize: SpacingUnit.x4_5,
                                      ),
                                    ),
                                    Text(
                                      maxLines: 2,
                                      formatHMS(result.endOnLeave),
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
                        Row(
                          children: [
                            Text(
                              appLocalizations.title,
                              style: const TextStyle(
                                color: Colors.orange,
                                fontSize: SpacingUnit.x5,
                              ),
                            ),
                            const SizedBox(
                              width: SpacingUnit.x4_5,
                            ),
                            Text(
                              title,
                              style: TextStyle(
                                color: colors.text,
                                fontSize: SpacingUnit.x4_5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: SpacingUnit.x6_5,
                        ),
                        Row(
                          children: [
                            Text(
                              appLocalizations.content,
                              style:
                                  const TextStyle(color: Colors.orange, fontSize: SpacingUnit.x5),
                            ),
                            const SizedBox(
                              width: SpacingUnit.x4_5,
                            ),
                            Text(
                              content,
                              style: TextStyle(
                                color: colors.text,
                                fontSize: SpacingUnit.x4_5,
                              ),
                            ),
                          ],
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
          )),
    );
  }
}
