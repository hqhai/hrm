import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/room_meeting.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/request/room_meeting/room_meeting_bloc.dart';
import 'package:base_app/presentations/bloc/request/room_meeting/room_meeting_event.dart';
import 'package:base_app/presentations/bloc/request/room_meeting/room_meeting_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/widgets/custom/shimmer_load.dart';
import 'package:base_app/presentations/widgets/request/item/item_list_room_meeting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateRoomMeetingWidget extends StatefulWidget {
  const CreateRoomMeetingWidget({super.key});

  @override
  State<CreateRoomMeetingWidget> createState() => _CreateRoomMeetingWidgetState();
}

class _CreateRoomMeetingWidgetState extends State<CreateRoomMeetingWidget> {
  List<RoomMeeting> rooms = [];
  bool check = false;

  @override
  void initState() {
    dI<RoomMeetingBloc>().add(const GetRoomMeetingEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _listener(BuildContext context, RoomMeetingState state) {
    setState(() {
      rooms = state.roomMeetings;
      check = state.status == RequestStatus.roomMeetingSuccess ||
          state.status == RequestStatus.createRoomMeetingSuccess;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocListener<RoomMeetingBloc, RoomMeetingState>(
      listener: (context, state) => _listener(context, state),
      listenWhen: (previous, current) => previous.status != current.status,
      child: Container(
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          color: CustomsColor.colorBackground,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: _checkRole() ? const EdgeInsets.all(SpacingUnit.x4) : const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(flex: 10, child: SizedBox()),
                    Expanded(
                      flex: 45,
                      child: Text(appLocalizations.name,
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: SpacingUnit.x4, color: Colors.white)),
                    ),
                    Expanded(
                      flex: 15,
                      child: Text(appLocalizations.seats,
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: SpacingUnit.x4, color: Colors.white)),
                    ),
                    Expanded(
                      flex: 40,
                      child: Text(appLocalizations.address,
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: SpacingUnit.x4, color: Colors.white)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 115 * rooms.length.toDouble(),
                  child: check
                      ? ListView.builder(
                          itemCount: rooms.length,
                          itemBuilder: (context, index) {
                            return ItemListRoomMeeting(
                              index: index,
                            );
                          })
                      : const ShimmerLoad(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _checkRole(){
    return dI<UserBloc>().state.user.role == ConfigStringValues.manager.name;
  }
}
