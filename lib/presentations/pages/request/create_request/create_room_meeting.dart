import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/value_string.dart';
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
import 'package:base_app/presentations/bloc/request/room_meeting/room_meeting_state.dart';
import 'package:base_app/presentations/widgets/create_request/item_create_overtime_or_onleave.dart';
import 'package:base_app/presentations/widgets/dialog/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final createRoomMeetingPageRoute = GoRoute(
    name: Pages.createRoomMeetingPage,
    path: Pages.createRoomMeetingPage,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return CreateRoomMeetingPage(
        index: data['index'],
      );
    });

class CreateRoomMeetingPage extends StatefulWidget {
  const CreateRoomMeetingPage({super.key, required this.index});

  final int index;

  @override
  State<CreateRoomMeetingPage> createState() => _CreateRoomMeetingPageState();
}

class _CreateRoomMeetingPageState extends State<CreateRoomMeetingPage> {
  String startTime = formatYMDHMS(DateTime.now().toString()),
      endTime = formatYMDHMS(DateTime.now().toString()),
      title = '',
      content = '',
      notification = '';

  _listener(BuildContext context, RequestState state) {
    if (state.status == RequestStatus.createRoomMeetingSuccess) {
      Navigator.of(context).pop();
      successDialog(context);
    } else if (state.status == RequestStatus.roomMeetingInit) {
      Navigator.of(context).pop();
      progressIndicatorDialog(context);
    } else if (state.status == RequestStatus.roomMeetingError) {
      Navigator.of(context).pop();
      unsuccessfulDialog(context);
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
        child: BlocBuilder<RoomMeetingBloc, RoomMeetingState>(
          builder: (context, state) {
            return Container(
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
                      const SizedBox(
                        height: SpacingUnit.x4_5,
                      ),
                      Text(
                        appLocalizations.roomName,
                        style: TextStyle(
                          color: colors.text,
                          fontSize: SpacingUnit.x4_5,
                        ),
                      ),
                      const SizedBox(
                        height: SpacingUnit.x4_5,
                      ),
                      Text(
                        state.roomMeetings[widget.index].roomName ?? '',
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: SpacingUnit.x4,
                        ),
                      ),
                      const SizedBox(
                        height: SpacingUnit.x4_5,
                      ),
                      Text(
                        appLocalizations.numberOfSeats,
                        style: TextStyle(
                          color: colors.text,
                          fontSize: SpacingUnit.x4_5,
                        ),
                      ),
                      const SizedBox(
                        height: SpacingUnit.x4_5,
                      ),
                      Text(
                        '${state.roomMeetings[widget.index].numberOfSeats ?? 0}',
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: SpacingUnit.x4,
                        ),
                      ),
                      const SizedBox(
                        height: SpacingUnit.x4_5,
                      ),
                      Text(
                        appLocalizations.address,
                        style: TextStyle(
                          color: colors.text,
                          fontSize: SpacingUnit.x4_5,
                        ),
                      ),
                      const SizedBox(
                        height: SpacingUnit.x4_5,
                      ),
                      Text(
                        state.roomMeetings[widget.index].address ?? '',
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: SpacingUnit.x4,
                        ),
                      ),
                      const SizedBox(
                        height: SpacingUnit.x4_5,
                      ),
                      Text(
                        appLocalizations.description,
                        style: TextStyle(
                          color: colors.text,
                          fontSize: SpacingUnit.x4_5,
                        ),
                      ),
                      const SizedBox(
                        height: SpacingUnit.x4_5,
                      ),
                      Text(
                        maxLines: 4,
                        state.roomMeetings[widget.index].description??'',
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: SpacingUnit.x4,
                        ),
                      ),
                      const SizedBox(
                        height: SpacingUnit.x4_5,
                      ),
                      Text(
                        appLocalizations.previouslyAvailableSchedules,
                        style: TextStyle(
                          color: colors.text,
                          fontSize: SpacingUnit.x4_5,
                        ),
                      ),
                      const SizedBox(
                        height: SpacingUnit.x4_5,
                      ),
                      if (state.roomMeetings[widget.index].requestRoomMeeting.isEmpty)
                        Text(
                          appLocalizations.thereAreCurrentlyNoMeetingsScheduled,
                          style: const TextStyle(
                            color: Colors.orange,
                            fontSize: SpacingUnit.x4_5,
                          ),
                        ),
                      if (state.roomMeetings[widget.index].requestRoomMeeting.isNotEmpty)
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x0_5),
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 20,
                                  child: SizedBox(),
                                ),
                                Expanded(
                                  flex: 40,
                                  child: Text(appLocalizations.startTime,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontSize: SpacingUnit.x4_5, color: Colors.deepOrange)),
                                ),
                                Expanded(
                                  flex: 40,
                                  child: Text(appLocalizations.endTime,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontSize: SpacingUnit.x4_5, color: Colors.deepOrange)),
                                ),
                              ],
                            )),
                      if (state.roomMeetings[widget.index].requestRoomMeeting.isNotEmpty)
                        SizedBox(
                          height: 120 *
                              state.roomMeetings[widget.index].requestRoomMeeting.length.toDouble(),
                          child: ListView.builder(
                            itemCount: state.roomMeetings[widget.index].requestRoomMeeting.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
                                padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
                                decoration: const BoxDecoration(
                                  color: Color(0xff293656),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                height: 100,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 20,
                                      child: Text('  ${index + 1}',
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              fontSize: SpacingUnit.x6, color: Colors.deepOrange)),
                                    ),
                                    Expanded(
                                      flex: 40,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              formatYMD(state.roomMeetings[widget.index]
                                                  .requestRoomMeeting[index].meetingStartTime
                                                  ??''),
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontSize: SpacingUnit.x4, color: Colors.orange)),
                                          Text(
                                              formatHMS(state.roomMeetings[widget.index]
                                                  .requestRoomMeeting[index].meetingStartTime
                                                  ??''),
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontSize: SpacingUnit.x4, color: Colors.orange)),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 40,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              formatYMD(state.roomMeetings[widget.index]
                                                  .requestRoomMeeting[index].meetingEndTime??''),
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontSize: SpacingUnit.x4, color: Colors.orange)),
                                          Text(
                                              formatHMS(state.roomMeetings[widget.index]
                                                  .requestRoomMeeting[index].meetingEndTime
                                                  ??''),
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontSize: SpacingUnit.x4, color: Colors.orange)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      const SizedBox(
                        height: SpacingUnit.x4_5,
                      ),
                      Text(
                        appLocalizations.scheduleAMeeting,
                        style: TextStyle(
                          color: colors.text,
                          fontSize: SpacingUnit.x4_5,
                        ),
                      ),
                      const SizedBox(
                        height: SpacingUnit.x4_5,
                      ),
                      ItemCreateOTOrOL(
                        onChangeTitle: (value) {
                          setState(() {
                            title = value;
                          });
                        },
                        onChangeContent: (value) {
                          setState(() {
                            content = value;
                          });
                        },
                        onChangeEndTime: (value) {
                          endTime = value;
                        },
                        onChangeStartTime: (value) {
                          startTime = value;
                        },
                        title: appLocalizations.title,
                        content: appLocalizations.content,
                        type: 'RM',
                      ),
                      const SizedBox(
                        height: SpacingUnit.x4_5,
                      ),
                      if (notification != '')
                        Text(notification,
                            style: TextStyle(fontSize: SpacingUnit.x4, color: colors.error)),
                      const SizedBox(
                        height: SpacingUnit.x4_5,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _checkTextField() ? Colors.blue : Colors.indigo,
                        ),
                        onPressed: () => _onClick(context, state),
                        child: Text(
                          appLocalizations.book,
                          style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  bool _checkTextField() {
    return title != '' && content != '';
  }

  _onClick(BuildContext context, RoomMeetingState state) {
    if (_checkTextField()) {
      _checkNotificationOrDialog(context, state);
    }
  }

  _checkNotificationOrDialog(BuildContext context, RoomMeetingState state) {
    final appLocalizations = AppLocalizations.of(context)!;
    if (DateTime.parse(startTime).difference(DateTime.now()).inSeconds < 0) {
      setState(() {
        notification = appLocalizations.bookingTimeMustBeAfterCurrentTime;
      });
    } else if (DateTime.parse(endTime).difference(DateTime.parse(startTime)).inSeconds <= 0) {
      setState(() {
        notification = appLocalizations.endTimeMustBeAfterStartTime;
      });
    } else {
      setState(() {
        notification = '';
      });
      createRoomMeetingDialog(
        context,
        () {
          dI<RequestBloc>().add(
            CreateRoomMeetingRequestEvent(
              type: TypeRequestStatus.roomMeeting.name,
              title: title,
              content: content,
              config: CreateRequestTypeRoomMeetingConfigRequest(
                roomMeetingId: state.roomMeetings[widget.index].id,
                meetingStartTime: formatIso8601(startTime),
                meetingEndTime: formatIso8601(endTime),
              ),
            ),
          );
        },
      );
    }
  }
}
