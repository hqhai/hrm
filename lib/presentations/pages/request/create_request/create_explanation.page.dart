import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/request/explanation/create_explanation_config_request.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/request/request/request_bloc.dart';
import 'package:base_app/presentations/bloc/request/request/request_event.dart';
import 'package:base_app/presentations/bloc/request/request/request_state.dart';
import 'package:base_app/presentations/widgets/custom/app_input_area.dart';
import 'package:base_app/presentations/widgets/dialog/dialog.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/success_or_unsuccess_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';
import 'package:widgets/app_input.dart';

final explanationPageRoute = GoRoute(
    name: Pages.explanationRequest,
    path: Pages.explanationRequest,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return CreateExplanationRequest(
        lateDay: data['lateDay'],
        lateTime: data['lateTime'],
      );
    });

class CreateExplanationRequest extends StatefulWidget {
  const CreateExplanationRequest({super.key, required this.lateDay, required this.lateTime});

  final String lateDay, lateTime;

  @override
  State<CreateExplanationRequest> createState() => _CreateExplanationRequestState();
}

class _CreateExplanationRequestState extends State<CreateExplanationRequest> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  String title = '', content = '';

  @override
  void initState() {
    super.initState();
    titleController.text = 'Đơn giải trình lý do đi muộn ngày: ${widget.lateDay} ';
    contentController.text = '';
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  _listener(BuildContext context, RequestState state) {
    if (state.status == RequestStatus.createRequestSuccess) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      successDialog(context);
    } else if (state.status == RequestStatus.createRequestInit) {
      Navigator.of(context).pop();
      progressIndicatorDialog(context);
    } else if (state.status == RequestStatus.createRequestError) {
      unsuccessfulDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: BlocListener<RequestBloc, RequestState>(
            listener: (context, state) {
              _listener(context, state);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: SpacingUnit.x4),
              padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x4),
              decoration: const BoxDecoration(
                color: Color(0xff293656),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: SpacingUnit.x6_5,
                  ),
                  Text(
                    appLocalizations.title,
                    style: TextStyle(
                      color: colors.text,
                      fontSize: SpacingUnit.x4_5,
                    ),
                  ),
                  const SizedBox(
                    height: SpacingUnit.x4_5,
                  ),
                  AppInput(
                    controller: titleController,
                    onChange: (value) => setState(() {
                      title = value;
                    }),
                  ),
                  const SizedBox(
                    height: SpacingUnit.x6_5,
                  ),
                  Text(
                    appLocalizations.content,
                    style: TextStyle(
                      color: colors.text,
                      fontSize: SpacingUnit.x4_5,
                    ),
                  ),
                  const SizedBox(
                    height: SpacingUnit.x4_5,
                  ),
                  AppInputArea(
                    maxLines: 10,
                    minLines: 10,
                    placeHolder: appLocalizations.content,
                    controller: contentController,
                    onChange: (value) => setState(() {
                      content = value;
                    }),
                  ),
                  const SizedBox(
                    height: SpacingUnit.x4_5,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _checkTextField() ? Colors.blue : Colors.indigo,
                    ),
                    onPressed: () => _diaLogFunction(context),
                    child: Text(
                      appLocalizations.create,
                      style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5),
                    ),
                  ),
                  const SizedBox(
                    height: SpacingUnit.x4_5,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  bool _checkTextField(){
    return title != '' &&
    content != '';
  }

  createExplanation() {
    dI<RequestBloc>().add(CreateExplanationRequestEvent(
      type: TypeRequestStatus.explanation.name,
      isApprove: true,
      priority: PriorityRequestStatus.high.name,
      title: titleController.text,
      content: contentController.text,
      config: CreateExplanationConfigRequest(
        lateDay: formatIso8601('${widget.lateDay} ${widget.lateTime}'),
      ),
    ));
  }

  _diaLogFunction(BuildContext context) {
    if(_checkTextField()){
      createRequestDialog(
        context,
            () {
          createExplanation();
        },
      );
    }

  }
}
