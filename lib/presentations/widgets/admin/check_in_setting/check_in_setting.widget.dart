import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/checkin_setting/check_in_setting_bloc.dart';
import 'package:base_app/presentations/bloc/checkin_setting/check_in_setting_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class CheckInSettingWidget extends StatefulWidget {
  const CheckInSettingWidget({super.key});

  @override
  State<CheckInSettingWidget> createState() => _CheckInSettingWidgetState();
}

class _CheckInSettingWidgetState extends State<CheckInSettingWidget> {
  @override
  void initState() {
    //dI<CheckInSettingBloc>().add(const GetCheckInSettingsEvent());
    super.initState();
  }

  _listener(CheckInSettingState state) {
    if (state.status == CheckInSettingStatus.updateCheckInSettingSuccess ||
        state.status == CheckInSettingStatus.deleteCheckInSettingSuccess) {
      //dI<CheckInSettingBloc>().add(const GetCheckInSettingsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: BlocConsumer<CheckInSettingBloc, CheckInSettingState>(
        listener: (context, state) {
          _listener(state);
        },
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.all(SpacingUnit.x2),
            padding: const EdgeInsets.all(SpacingUnit.x2),
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: /*CustomsColor.colorBackground*/CustomsColor.colorBackground,
              borderRadius: const BorderRadius.all(
                Radius.circular(SpacingUnit.x4),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*SizedBox(
                    height: state.departments.length * SpacingUnit.x35,
                    child: ListView.builder(
                        itemCount: state.departments.length,
                        itemBuilder: (context, index) {
                          return ItemCheckInSetting(
                            index: index,
                          );
                        }),
                  ),*/
                  ElevatedButton(
                    onPressed: () => _nextCreateCheckInSettingPage(context),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: Text(
                        appLocalizations.create,
                      style: TextStyle(fontSize: SpacingUnit.x4, color: colors.text),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _nextCreateCheckInSettingPage(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.createCheckInSettingPage);
  }
}
