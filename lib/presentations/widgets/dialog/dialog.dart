import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/room_meeting.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/request/request/request_bloc.dart';
import 'package:base_app/presentations/bloc/request/request/request_state.dart';
import 'package:base_app/presentations/bloc/request/room_meeting/room_meeting_bloc.dart';
import 'package:base_app/presentations/bloc/request/room_meeting/room_meeting_event.dart';
import 'package:base_app/presentations/widgets/custom/app_input_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';
import 'package:widgets/app_input.dart';

createRequestDialog(BuildContext context, VoidCallback callback) {
  return showDialog(
    context: context,
    builder: (context) {
      final appLocalizations = AppLocalizations.of(context)!;
      return AlertDialog(
        content: Scrollbar(
          child: BlocBuilder<RequestBloc, RequestState>(
            builder: (context, stateRequest) {
              return SizedBox(
                height: 170,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      maxLines: 3,
                      appLocalizations.doYouWantToCreateARequest,
                      style: const TextStyle(color: Colors.white, fontSize: SpacingUnit.x6),
                    ),
                    const SizedBox(
                      height: SpacingUnit.x4,
                    ),
                    BlocBuilder<RequestBloc, RequestState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                callback.call();
                              },
                              child: Text(appLocalizations.ok),
                            ),
                            ElevatedButton(
                              child: Text(appLocalizations.cancel),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );
}

createDialog(BuildContext context, String title, VoidCallback callback) {
  return showDialog(
    context: context,
    builder: (context) {
      final appLocalizations = AppLocalizations.of(context)!;
      return AlertDialog(
        content: Scrollbar(
          child: BlocBuilder<RequestBloc, RequestState>(
            builder: (context, stateRequest) {
              return SizedBox(
                height: 170,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      maxLines: 3,
                      title,
                      style: const TextStyle(color: Colors.white, fontSize: SpacingUnit.x6),
                    ),
                    const SizedBox(
                      height: SpacingUnit.x4,
                    ),
                    BlocBuilder<RequestBloc, RequestState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                callback.call();
                              },
                              child: Text(appLocalizations.ok),
                            ),
                            ElevatedButton(
                              child: Text(appLocalizations.cancel),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );
}

createRoomMeetingDialog(BuildContext context, VoidCallback callback) async {
  return showDialog(
    context: context,
    builder: (context) {
      final appLocalizations = AppLocalizations.of(context)!;
      return AlertDialog(
        content: Scrollbar(
          child: SizedBox(
            height: 170,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  maxLines: 3,
                  appLocalizations.doYouWantToCreateARequest,
                  style: const TextStyle(color: Colors.white, fontSize: SpacingUnit.x6),
                ),
                const SizedBox(
                  height: SpacingUnit.x4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        callback.call();
                        Navigator.of(context).pop();
                      },
                      child: Text(appLocalizations.ok),
                    ),
                    ElevatedButton(
                      child: Text(appLocalizations.cancel),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

noteDialog(BuildContext context, ValueChanged<String> onChange) async {
  final TextEditingController noteController = TextEditingController();
  return showDialog(
    context: context,
    builder: (context) {
      final appLocalizations = AppLocalizations.of(context)!;
      return AlertDialog(
        content: SizedBox(
          height: 250,
          child: Column(
            children: [
              Text(appLocalizations.note),
              const SizedBox(
                height: SpacingUnit.x4_5,
              ),
              AppInputArea(
                minLines: 5,
                maxLines: 5,
                placeHolder: appLocalizations.note,
                controller: noteController,
              ),
              const SizedBox(
                height: SpacingUnit.x4_5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      onChange.call(noteController.text);
                      Navigator.of(context).pop();
                    },
                    child: Text(appLocalizations.ok),
                  ),
                  ElevatedButton(
                    child: Text(appLocalizations.cancel),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

updateRequestDialog(BuildContext context, VoidCallback callback) async {
  return showDialog(
    context: context,
    builder: (context) {
      final appLocalizations = AppLocalizations.of(context)!;
      return AlertDialog(
        content: Scrollbar(
          child: SizedBox(
            height: 140,
            child: Column(
              children: [
                Text(
                  maxLines: 3,
                  appLocalizations.doYouWantToUpdateARequest,
                  style: const TextStyle(color: Colors.white, fontSize: SpacingUnit.x6),
                ),
                const SizedBox(
                  height: SpacingUnit.x4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        callback.call();
                      },
                      child: Text(appLocalizations.ok),
                    ),
                    ElevatedButton(
                      child: Text(appLocalizations.cancel),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

deleteDialog(BuildContext context, VoidCallback callback) async {
  final appLocalizations = AppLocalizations.of(context)!;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Scrollbar(
          child: Text(
            appLocalizations.doYouWantToDeleteTheRoom,
            style: const TextStyle(fontSize: SpacingUnit.x6, color: Colors.white),
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              callback.call();
              Navigator.of(context).pop();
            },
            child: Text(
              appLocalizations.ok,
              style: const TextStyle(fontSize: SpacingUnit.x4, color: Colors.white),
            ),
          ),
          ElevatedButton(
            child: Text(
              appLocalizations.cancel,
              style: const TextStyle(fontSize: SpacingUnit.x4, color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

updateRoomMeetingDialog(BuildContext context, RoomMeeting roomMeeting) async {
  final TextEditingController roomNameController =
          TextEditingController(text: roomMeeting.roomName??''),
      numberOfSeatsController = TextEditingController(text: roomMeeting.numberOfSeats.toString()),
      addressController = TextEditingController(text: roomMeeting.address??''),
      descriptionController = TextEditingController(text: roomMeeting.description??'');
  final appLocalizations = AppLocalizations.of(context)!;
  return showDialog(
    context: context,
    builder: (context) {
      final colors = AppTheme.getColors(context);
      return AlertDialog(
        content: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appLocalizations.update,
                  style: TextStyle(fontSize: SpacingUnit.x4_5, color: colors.text),
                ),
                const SizedBox(
                  height: SpacingUnit.x3_5,
                ),
                Text(
                  appLocalizations.roomName,
                  style: TextStyle(fontSize: SpacingUnit.x4_5, color: colors.text),
                ),
                const SizedBox(
                  height: SpacingUnit.x3_5,
                ),
                AppInput(
                  placeHolder: appLocalizations.roomName,
                  controller: roomNameController,
                ),
                const SizedBox(
                  height: SpacingUnit.x4_5,
                ),
                Text(
                  appLocalizations.numberOfSeats,
                  style: TextStyle(fontSize: SpacingUnit.x4_5, color: colors.text),
                ),
                const SizedBox(
                  height: SpacingUnit.x3_5,
                ),
                AppInput(
                  inputFormatter: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  placeHolder: appLocalizations.numberOfSeats,
                  controller: numberOfSeatsController,
                ),
                const SizedBox(
                  height: SpacingUnit.x4_5,
                ),
                Text(
                  appLocalizations.address,
                  style: TextStyle(fontSize: SpacingUnit.x4_5, color: colors.text),
                ),
                const SizedBox(
                  height: SpacingUnit.x3_5,
                ),
                AppInput(
                  placeHolder: appLocalizations.address,
                  controller: addressController,
                ),
                const SizedBox(
                  height: SpacingUnit.x4_5,
                ),
                Text(
                  appLocalizations.description,
                  style: TextStyle(fontSize: SpacingUnit.x4_5, color: colors.text),
                ),
                const SizedBox(
                  height: SpacingUnit.x3_5,
                ),
                AppInput(
                  placeHolder: appLocalizations.description,
                  controller: descriptionController,
                ),
                BlocBuilder<RequestBloc, RequestState>(
                  builder: (context, state) {
                    return state.status == RequestStatus.updateRoomMeetingSuccess
                        ? Column(
                            children: [
                              const SizedBox(
                                height: SpacingUnit.x3_5,
                              ),
                              Text(
                                appLocalizations.updateSuccessful,
                                style: TextStyle(fontSize: SpacingUnit.x4_5, color: colors.text),
                              ),
                            ],
                          )
                        : const SizedBox();
                  },
                ),
                const SizedBox(
                  height: SpacingUnit.x3_5,
                ),
                BlocBuilder<RequestBloc, RequestState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            dI<RoomMeetingBloc>().add(
                              UpdateRoomMeetingEvent(
                                  roomNameController.text,
                                  int.parse(numberOfSeatsController.text),
                                  addressController.text,
                                  descriptionController.text,
                                  roomMeeting.id),
                            );
                            if (state.status == RequestStatus.updateRoomMeetingSuccess) {
                              Navigator.of(context).pop();
                              successDialog(context);
                            }
                            if (state.status == RequestStatus.roomMeetingError) {
                              Navigator.of(context).pop();
                              successDialog(context);
                            }
                          },
                          child: Text(
                            appLocalizations.save,
                            style: TextStyle(fontSize: SpacingUnit.x6, color: colors.text),
                          ),
                        ),
                        ElevatedButton(
                          child: Text(
                            appLocalizations.cancel,
                            style: TextStyle(fontSize: SpacingUnit.x6, color: colors.text),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

changeStatusRequestByManagerDialog(BuildContext context, VoidCallback callback) {
  return showDialog(
    context: context,
    builder: (context) {
      final appLocalizations = AppLocalizations.of(context)!;
      return AlertDialog(
        content: Scrollbar(
          child: BlocBuilder<RequestBloc, RequestState>(
            builder: (context, stateRequest) {
              return SizedBox(
                height: 200,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      maxLines: 3,
                      appLocalizations.changeStatusRequestByManager,
                      style: const TextStyle(color: Colors.white, fontSize: SpacingUnit.x6),
                    ),
                    const SizedBox(
                      height: SpacingUnit.x4,
                    ),
                    BlocBuilder<RequestBloc, RequestState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                callback.call();
                                Navigator.of(context).pop();
                              },
                              child: Text(appLocalizations.ok),
                            ),
                            ElevatedButton(
                              child: Text(appLocalizations.cancel),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );
}

changePasswordDialog(BuildContext context, VoidCallback callback) async {
  final appLocalizations = AppLocalizations.of(context)!;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Scrollbar(
          child: Text(
            appLocalizations.doYouWantToChangeYourPassword,
            style: const TextStyle(fontSize: SpacingUnit.x6, color: Colors.white),
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              callback.call();
              Navigator.of(context).pop();
            },
            child: Text(
              appLocalizations.ok,
              style: const TextStyle(fontSize: SpacingUnit.x4, color: Colors.white),
            ),
          ),
          ElevatedButton(
            child: Text(
              appLocalizations.cancel,
              style: const TextStyle(fontSize: SpacingUnit.x4, color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

successDialog(BuildContext context) async {
  final appLocalizations = AppLocalizations.of(context)!;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Scrollbar(
          child: Text(appLocalizations.success,
              textAlign: TextAlign.center, style: const TextStyle(fontSize: SpacingUnit.x8)),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(appLocalizations.ok),
          ),
        ],
      );
    },
  );
}

unsuccessfulDialog(BuildContext context) async {
  final appLocalizations = AppLocalizations.of(context)!;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Scrollbar(
          child: Text(appLocalizations.unsuccessful,
              textAlign: TextAlign.center, style: const TextStyle(fontSize: SpacingUnit.x8)),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(appLocalizations.ok),
          ),
        ],
      );
    },
  );
}

progressIndicatorDialog(BuildContext context) async {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return const AlertDialog(
        content: SizedBox(
          height: 100,
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      );
    },
  );
}

successFullDialog(BuildContext context, String content) async {
  final appLocalizations = AppLocalizations.of(context)!;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Scrollbar(
          child: Text(content,
              textAlign: TextAlign.center, style: const TextStyle(fontSize: SpacingUnit.x4, color: Colors.white)),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(appLocalizations.ok),
          ),
        ],
      );
    },
  );
}
