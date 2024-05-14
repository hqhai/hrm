import 'dart:convert';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/request/room_meeting/create_request_type_room_meeting_config.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/request/request/request_bloc.dart';
import 'package:base_app/presentations/bloc/request/request/request_event.dart';
import 'package:base_app/presentations/bloc/request/request/request_state.dart';
import 'package:base_app/presentations/bloc/request/room_meeting/room_meeting_bloc.dart';
import 'package:base_app/presentations/bloc/request/room_meeting/room_meeting_event.dart';
import 'package:base_app/presentations/bloc/request/room_meeting/room_meeting_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final roomMeetingRequestPageRoute = GoRoute(
    name: Pages.roomMeetingRequestPageRoute,
    path: Pages.roomMeetingRequestPageRoute,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return RoomMeetingRequestPage(
        id: data['id'],
      );
    });

class RoomMeetingRequestPage extends StatefulWidget {
  const RoomMeetingRequestPage({super.key, required this.id});

  final String id;

  @override
  State<RoomMeetingRequestPage> createState() => _RoomMeetingRequestPageState();
}

class _RoomMeetingRequestPageState extends State<RoomMeetingRequestPage> {
  CreateRequestTypeRoomMeetingConfigRequest result =
      const CreateRequestTypeRoomMeetingConfigRequest(roomMeetingId: '');
  String title = '', content = '', idRequest = '', nameRoom = '';

  final TextEditingController noteController = TextEditingController();

  _listener(RequestState state) {
    if (state.status == RequestStatus.getRequestByIdSuccess) {
      setState(() {
        if (state.request.configStr != null) {
          result = CreateRequestTypeRoomMeetingConfigRequest.fromJson(
              json.decode(state.request.configStr??''));
        }
        title = state.request.title??'';
        content = state.request.content??'';
        idRequest = state.request.createdUserId;
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
    dI<RoomMeetingBloc>().add(const GetRoomMeetingEvent());
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
          listener: (context, state) => _listener(state),
          listenWhen: (previous, current) => previous.status != current.status,
          child: BlocBuilder<RoomMeetingBloc, RoomMeetingState>(
            builder: (context, state) {
              return Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: SpacingUnit.x1, vertical: SpacingUnit.x2),
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
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      appLocalizations.startTime,
                                      style:
                                          const TextStyle(fontSize: SpacingUnit.x6, color: Colors.orange),
                                    ),
                                    Text(
                                      appLocalizations.endTime,
                                      style:
                                          const TextStyle(fontSize: SpacingUnit.x6, color: Colors.orange),
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
                                          formatYMD(result.meetingStartTime),
                                          style: TextStyle(
                                            color: colors.text,
                                            fontSize: SpacingUnit.x4_5,
                                          ),
                                        ),
                                        Text(
                                          maxLines: 2,
                                          formatHMS(result.meetingStartTime),
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
                                          formatYMD(result.meetingEndTime),
                                          style: TextStyle(
                                            color: colors.text,
                                            fontSize: SpacingUnit.x4_5,
                                          ),
                                        ),
                                        Text(
                                          maxLines: 2,
                                          formatHMS(result.meetingEndTime),
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
                              appLocalizations.roomName,
                              style: const TextStyle(
                                color: Colors.orange,
                                fontSize: SpacingUnit.x4_5,
                              ),
                            ),
                            const SizedBox(
                              height: SpacingUnit.x3,
                            ),
                            Text(
                              result.roomMeetingId.isNotEmpty
                                  ? state.roomMeetings
                                      .where((e) => e.id == result.roomMeetingId)
                                      .first
                                      .roomName
                                      ??''
                                  : '',
                              style: TextStyle(
                                color: colors.text,
                                fontSize: SpacingUnit.x4_5,
                              ),
                            ),
                            const SizedBox(
                              height: SpacingUnit.x3,
                            ),
                            Text(
                              appLocalizations.title,
                              style: const TextStyle(
                                color: Colors.orange,
                                fontSize: SpacingUnit.x4_5,
                              ),
                            ),
                            const SizedBox(
                              height: SpacingUnit.x3,
                            ),
                            Text(
                              title,
                              style: TextStyle(
                                color: colors.text,
                                fontSize: SpacingUnit.x4_5,
                              ),
                            ),
                            const SizedBox(
                              height: SpacingUnit.x6_5,
                            ),
                            Text(
                              appLocalizations.content,
                              style: const TextStyle(
                                color: Colors.orange,
                                fontSize: SpacingUnit.x4_5,
                              ),
                            ),
                            const SizedBox(
                              height: SpacingUnit.x3,
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
              );
            },
          )),
    );
  }
}
