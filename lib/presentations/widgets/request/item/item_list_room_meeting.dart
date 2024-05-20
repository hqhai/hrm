import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/request/room_meeting/room_meeting_bloc.dart';
import 'package:base_app/presentations/bloc/request/room_meeting/room_meeting_event.dart';
import 'package:base_app/presentations/bloc/request/room_meeting/room_meeting_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:base_app/presentations/widgets/dialog/delete_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemListRoomMeeting extends StatefulWidget {
  const ItemListRoomMeeting({super.key, this.index = 0});

  final int index;

  @override
  State<ItemListRoomMeeting> createState() => _ItemListRoomMeetingState();
}

class _ItemListRoomMeetingState extends State<ItemListRoomMeeting> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () {
        _pushScreen();
      },
      child: BlocBuilder<RoomMeetingBloc, RoomMeetingState>(
        builder: (context, stateRoomMeeting) {
          return BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
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
                child: Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 10,
                          child: Text(' ${widget.index + 1}',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontSize: SpacingUnit.x6, color: Colors.deepOrange)),
                        ),
                        Expanded(
                          flex: (!(state.user.id ==
                                  ConfigStringValues.generalManager.name))
                              ? 40
                              : 20,
                          child: Text(
                            maxLines: 3,
                            stateRoomMeeting.roomMeetings[widget.index].roomName??'',
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: SpacingUnit.x4, color: Colors.orange),
                          ),
                        ),
                        Expanded(
                          flex: (!(state.user.id ==
                                  ConfigStringValues.generalManager.name))
                              ? 15
                              : 10,
                          child: Text(
                              stateRoomMeeting.roomMeetings[widget.index].numberOfSeats.toString(),
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              style:
                                  const TextStyle(fontSize: SpacingUnit.x4, color: Colors.orange)),
                        ),
                        Expanded(
                          flex: 40,
                          child: Text(
                              stateRoomMeeting.roomMeetings[widget.index].address??'',
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  const TextStyle(fontSize: SpacingUnit.x4, color: Colors.orange)),
                        ),
                        if (state.user.id == ConfigStringValues.generalManager.name)
                          Expanded(
                            flex: 10,
                            child: GestureDetector(
                              onTap: () {
                                _dialog(context, stateRoomMeeting);
                              },
                              child: const Icon(Icons.delete, color: Colors.red, size: 24),
                            ),
                          ),
                        if (state.user.id == ConfigStringValues.generalManager.name)
                          Expanded(
                            flex: 10,
                            child: GestureDetector(
                              onTap: () => updateRoomMeetingDialog(
                                  context, stateRoomMeeting.roomMeetings[widget.index]),
                              child: const Icon(Icons.update, color: Colors.amber, size: 24),
                            ),
                          ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x1),
                        child: Text(
                            stateRoomMeeting.roomMeetings[widget.index].isApproval != null &&
                                    stateRoomMeeting.roomMeetings[widget.index].isApproval == true
                                ? appLocalizations.isApproval
                                : appLocalizations.isNotApproval,
                            style:
                                const TextStyle(fontSize: SpacingUnit.x3, color: Colors.white70)),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  _pushScreen() {
    dI<AppNavigation>()
        .pushName(context, page: Pages.createRoomMeetingPage, extra: {'index': widget.index});
  }

  _dialog(BuildContext context, RoomMeetingState state) {
    deleteDialog(
      context,
      () {
        dI<RoomMeetingBloc>().add(DeleteRoomMeetingEvent(state.roomMeetings[widget.index].id));
      },
    );
  }
}
