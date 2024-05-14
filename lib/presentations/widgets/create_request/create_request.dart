import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/menu_values.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/request/request/request_bloc.dart';
import 'package:base_app/presentations/bloc/request/request/request_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:base_app/presentations/widgets/create_request/create_request_default/create_request_default.dart';
import 'package:base_app/presentations/widgets/create_request/onleave_request/create_request_onleave.dart';
import 'package:base_app/presentations/widgets/create_request/overtime_request/create_request_overtime.dart';
import 'package:base_app/presentations/widgets/create_request/roommetting_request/create_request_roommetting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class CreateRequestWidget extends StatefulWidget {
  const CreateRequestWidget({super.key});

  @override
  State<CreateRequestWidget> createState() => _CreateRequestWidgetState();
}

class _CreateRequestWidgetState extends State<CreateRequestWidget> {
  late String dropdownTypeRequestValue;

  @override
  void initState() {
    super.initState();
    dropdownTypeRequestValue = MenuValues.listTypeRequest.first;
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
      body: BlocListener<RequestBloc, RequestState>(
        listener: (context, stateRequest) {},
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, stateUser) {
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
                            initialSelection: MenuValues.listTypeRequest.first,
                            onSelected: (String? value) {
                              setState(() {
                                dropdownTypeRequestValue = value!;
                              });
                            },
                            dropdownMenuEntries: MenuValues.listTypeRequest
                                .map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry<String>(value: value, label: value);
                            }).toList(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: SpacingUnit.x4_5,
                      ),
                      _checkItemRequestByType(),
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

  Widget _checkItemRequestByType() {
    if (dropdownTypeRequestValue == TypeRequestStatus.overTime.name) {
      return const CreateRequestOTWidget();
    } else if (dropdownTypeRequestValue == TypeRequestStatus.onLeave.name) {
      return const CreateRequestOLWidget();
    } else if (dropdownTypeRequestValue == TypeRequestStatus.roomMeeting.name) {
      return const CreateRoomMeetingWidget();
    } else {
      return CreateRequestDefaultWidget(typeRequest: dropdownTypeRequestValue);
    }
  }
}
