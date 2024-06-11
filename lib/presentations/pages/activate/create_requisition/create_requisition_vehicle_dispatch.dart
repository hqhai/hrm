
import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/data/models/requisition/vehicle_driver/vehicle_driver_response/vehicle_driver_response.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/on_leave/item_create_interval_on_leave.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final createRequestVehicleDispatchPageRoute = GoRoute(
  path: Pages.createRequestVehicleDispatchPage,
  name: Pages.createRequestVehicleDispatchPage,
  builder: (context, GoRouterState state) => const CreateRequestVehicleDispatchPage(),
);

class CreateRequestVehicleDispatchPage extends StatefulWidget {
  const CreateRequestVehicleDispatchPage({super.key});

  @override
  State<CreateRequestVehicleDispatchPage> createState() => _CreateRequestVehicleDispatchPageState();
}

class _CreateRequestVehicleDispatchPageState extends State<CreateRequestVehicleDispatchPage> {
  final TextEditingController scheduleController = TextEditingController(),
      contentController = TextEditingController(),
      destinationController = TextEditingController();
  int totalMinute = 0;
  String startTime = '', endTime = '', schedule = '', content = '';
  List<String> followers = [], walkers = [];

  bool _checkValue(){
    bool check = schedule!= ''&& content != '' && walkers != [];
    return check;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          RequisitionTypeEnum.vehicleDriver.configTypeName,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(SpacingUnit.x3),
          margin: const EdgeInsets.all(SpacingUnit.x3),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
            border: Border.all(
              width: 1,
              color: colors.surface,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemCreateIntervalOnLeave(
                dayOrHours: false,
                title: appLocalizations.intervalOnLeave,
                startTime: (value) => setStartTime(value),
                endTime: (value) => setEndTime(value),
              ),
              ItemCreateInputArea(
                textController: scheduleController,
                title: appLocalizations.schedule,
                onChange: (value) => _setSchedule(value),
              ),
              ItemCreateInputArea(
                textController: contentController,
                title: appLocalizations.content,
                onChange: (value) => _setContent(value),
              ),
              ItemCreateFollower(
                  title: appLocalizations.walker, onChange: (value) => _setWalker(value)),
              ItemCreateFollower(
                  title: appLocalizations.follower, onChange: (value) => _setFollower(value)),
              ItemButton(
                callbackSave: () => _save(),
                callbackCancel: () => _cancel(),
              )
            ],
          ),
        ),
      ),
    );
  }

  _setFollower(List<User> value) {
    setState(() {
      followers = value.map((e) => e.id).toList();
    });
  }

  _save() {
    if(_checkValue()) {
      dI<RequisitionBloc>().add(
      PostRequestEvent(
        postRequestRequest: PostRequestRequest(
          description: scheduleController.text,
          followerIds: followers,
          flowId: 'b11bc307-7e58-4eb7-9d14-7b393359f864',
          config: VehicleDriverResponse(
            content: contentController.text,
            endDate: endTime,
            startDate: startTime,
            subtitudePersons: walkers,
          ),
        ),
      ),
    );
    }
  }

  _cancel() {}

  _setWalker(List<User> value) {
    setState(() {
      walkers = value.map((e) => e.id).toList();
    });
  }

  setStartTime(String value) {
    setState(() {
      startTime = formatIso8601(value);
    });
  }

  setEndTime(String value) {
    setState(() {
      endTime = formatIso8601(value);
    });
  }

  _setSchedule(String value) {
    setState(() {
      schedule = value;
    });
  }

  _setContent(String value) {
    setState(() {
      content = value;
    });
  }
}
