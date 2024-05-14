import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/menu_values.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/request/room_meeting/room_meeting_bloc.dart';
import 'package:base_app/presentations/bloc/request/room_meeting/room_meeting_event.dart';
import 'package:base_app/presentations/bloc/request/room_meeting/room_meeting_state.dart';
import 'package:base_app/presentations/widgets/custom/shimmer_load.dart';
import 'package:base_app/presentations/widgets/dialog/dialog.dart';
import 'package:base_app/presentations/widgets/request/item/item_list_room_meeting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';
import 'package:widgets/app_input.dart';

class CreateRoomWidget extends StatefulWidget {
  const CreateRoomWidget({super.key});

  @override
  State<CreateRoomWidget> createState() => _CreateRoomWidgetState();
}

class _CreateRoomWidgetState extends State<CreateRoomWidget> {
  late bool dropdownIsApprovalValue;
  final TextEditingController roomNameController = TextEditingController(),
      numberOfSeatsController = TextEditingController(),
      addressController = TextEditingController(),
      descriptionController = TextEditingController();
  bool checkCreate = true;

  @override
  void initState() {
    super.initState();
    dI<RoomMeetingBloc>().add(const GetRoomMeetingEvent());
    dropdownIsApprovalValue = MenuValues.isApprover.first;
    roomNameController.text = '';
    numberOfSeatsController.text = '';
    addressController.text = '';
    descriptionController.text = '';
  }

  @override
  void dispose() {
    super.dispose();
    roomNameController.dispose();
    numberOfSeatsController.dispose();
    addressController.dispose();
    descriptionController.dispose();
  }

  _listener(BuildContext context, RoomMeetingState state) {
    if (state.status == RequestStatus.createRoomMeetingSuccess ||
        state.status == RequestStatus.deleteRoomMeetingSuccess) {
      successDialog(context);
      dI<RoomMeetingBloc>().add(const GetRoomMeetingEvent());
    } else if (state.status == RequestStatus.updateRoomMeetingSuccess) {
      Navigator.of(context).pop();
      successDialog(context);
      dI<RoomMeetingBloc>().add(const GetRoomMeetingEvent());
    } else if (state.status == RequestStatus.roomMeetingError) {
      unsuccessfulDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: BlocConsumer<RoomMeetingBloc, RoomMeetingState>(
        listener: (context, state) {
          _listener(context, state);
        },
        builder: (context, state) {
          return Container(
            margin:
                const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
            height: MediaQuery.sizeOf(context).height,
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
                    SizedBox(
                      height: 110 * state.roomMeetings.length.toDouble(),
                      child: _checkStatus(state)
                          ? ListView.builder(
                              itemCount: state.roomMeetings.length,
                              itemBuilder: (context, index) {
                                return ItemListRoomMeeting(
                                  index: index,
                                );
                              })
                          : const ShimmerLoad(),
                    ),
                    const SizedBox(
                      height: SpacingUnit.x3_5,
                    ),
                    checkCreate
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: () {
                              setState(() {
                                checkCreate = false;
                              });
                            },
                            child: Text(
                              appLocalizations.add,
                              style: TextStyle(fontSize: SpacingUnit.x4_5, color: colors.text),
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                  onChange: (value) {
                                    setState(() {
                                      roomNameController.text = value;
                                    });
                                  }),
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
                                  onChange: (value) {
                                    setState(() {
                                      numberOfSeatsController.text = value;
                                    });
                                  }),
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
                                  onChange: (value) {
                                    setState(() {
                                      addressController.text = value;
                                    });
                                  }),
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
                              const SizedBox(
                                height: SpacingUnit.x3_5,
                              ),
                              Text(
                                appLocalizations.isApproval,
                                style: TextStyle(fontSize: SpacingUnit.x4_5, color: colors.text),
                              ),
                              const SizedBox(
                                height: SpacingUnit.x3_5,
                              ),
                              DropdownMenu<bool>(
                                initialSelection: MenuValues.isApprover.first,
                                onSelected: (bool? value) {
                                  setState(() {
                                    dropdownIsApprovalValue = value!;
                                  });
                                },
                                dropdownMenuEntries: MenuValues.isApprover
                                    .map<DropdownMenuEntry<bool>>((bool value) {
                                  return DropdownMenuEntry<bool>(
                                      value: value, label: value.toString());
                                }).toList(),
                              ),
                              const SizedBox(
                                height: SpacingUnit.x5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          _checkTextField() ? Colors.blue : Colors.indigo,
                                    ),
                                    onPressed: () => _dialog(context),
                                    child: Text(
                                      appLocalizations.create,
                                      style:
                                          TextStyle(color: colors.text, fontSize: SpacingUnit.x5),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                    ),
                                    onPressed: () => _resetTextField(context),
                                    child: Text(
                                      appLocalizations.cancel,
                                      style:
                                          TextStyle(color: colors.text, fontSize: SpacingUnit.x5),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _dialog(BuildContext context) {
    if (_checkTextField()) {
      createRoomMeetingDialog(
        context,
        () {
          dI<RoomMeetingBloc>().add(CreateRoomMeetingEvent(
              roomNameController.text,
              int.parse(numberOfSeatsController.text),
              addressController.text,
              descriptionController.text,
              dropdownIsApprovalValue));
          dI<RoomMeetingBloc>().add(const GetRoomMeetingEvent());
          setState(() {
            checkCreate = true;
          });
        },
      );
    }
  }

  _resetTextField(BuildContext context) {
    setState(() {
      checkCreate = true;
      roomNameController.text = '';
      numberOfSeatsController.text = '';
      addressController.text = '';
      descriptionController.text = '';
    });
  }

  bool _checkStatus(RoomMeetingState state) {
    return (state.status != RequestStatus.roomMeetingError ||
        state.status != RequestStatus.roomMeetingInit);
  }

  bool _checkTextField() {
    if (roomNameController.text != '' &&
        numberOfSeatsController.text != '' &&
        addressController.text != '' &&
        descriptionController.text != '') {
      return true;
    }
    return false;
  }
}
