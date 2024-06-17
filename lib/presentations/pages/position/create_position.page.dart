import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/position/position_bloc.dart';
import 'package:base_app/presentations/bloc/position/position_event.dart';
import 'package:base_app/presentations/bloc/position/position_state.dart';
import 'package:base_app/presentations/widgets/base_page.dart';
import 'package:base_app/presentations/widgets/custom/app_input_area.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/dialog.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/success_or_unsuccess_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';
import 'package:widgets/app_input.dart';

final createPositionPageRoute = GoRoute(
    name: Pages.createPositionPage,
    path: Pages.createPositionPage,
    builder: (context, GoRouterState state) => const CreatePositionWidget());

class CreatePositionWidget extends StatefulWidget {
  const CreatePositionWidget({super.key});

  @override
  State<CreatePositionWidget> createState() => _CreatePositionWidgetState();
}

class _CreatePositionWidgetState extends State<CreatePositionWidget> {
  final TextEditingController nameController = TextEditingController(),
      descriptionController = TextEditingController();
  String name = '';

  @override
  void initState() {
    dI<PositionBloc>().add(const GetPositionsEvent());
    super.initState();
  }

  _listener(BuildContext context, PositionState state) {
    if (state.status == PositionStatus.createPositionSuccess) {
      Navigator.of(context).pop();
      successDialog(context);
      nameController.text = '';
      descriptionController.text = '';
      dI<PositionBloc>().add(const GetPositionsEvent());
    } else if (state.status == PositionStatus.createPositionInit) {
      Navigator.of(context).pop();
      progressIndicatorDialog(context);
    } else if (state.status == PositionStatus.createPositionError) {
      Navigator.of(context).pop();
      unsuccessfulDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final height = MediaQuery.sizeOf(context).height;
    return BasePage(
      appbar: AppBar(
        title: Text(appLocalizations.createPosition,
            style: TextStyle(fontSize: SpacingUnit.x5, color: colors.text)),
      ),
      body: BlocConsumer<PositionBloc, PositionState>(
        listener: (context, state) {
          _listener(context, state);
        },
        builder: (context, state) => Container(
          margin: const EdgeInsets.all(SpacingUnit.x2),
          padding: const EdgeInsets.all(SpacingUnit.x2),
          height: height,
          decoration: BoxDecoration(
            color: CustomsColor.colorBackground,
            borderRadius: const BorderRadius.all(
              Radius.circular(SpacingUnit.x4),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: SpacingUnit.x4),
                Text(appLocalizations.name,
                    style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                const SizedBox(height: SpacingUnit.x2),
                AppInput(
                  placeHolder: appLocalizations.name,
                  controller: nameController,
                  onChange: (value) => setState(() => name = value),
                ),
                const SizedBox(height: SpacingUnit.x2),
                Text(appLocalizations.description,
                    style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                const SizedBox(height: SpacingUnit.x2),
                AppInputArea(
                  placeHolder: appLocalizations.description,
                  controller: descriptionController,
                  minLines: 5,
                  maxLines: 5,
                ),
                const SizedBox(height: SpacingUnit.x4),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: _checkTextField() ? Colors.blue : Colors.indigo),
                  onPressed: () => _createDialog(context, state),
                  child: Text(appLocalizations.create,
                      style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _checkTextField() {
    return name != '';
  }

  _createDialog(BuildContext context, PositionState state) {
    final appLocalizations = AppLocalizations.of(context)!;
    if (_checkTextField()) {
      createDialog(
          context,
          appLocalizations.doYouWantToCreatePosition,
          () => dI<PositionBloc>().add(CreatePositionEvent(
                name: nameController.text,
                description: descriptionController.text,
              )));
    }
  }
}
