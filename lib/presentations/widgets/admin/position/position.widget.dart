import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/position/position_bloc.dart';
import 'package:base_app/presentations/bloc/position/position_event.dart';
import 'package:base_app/presentations/bloc/position/position_state.dart';
import 'package:base_app/presentations/widgets/admin/position/item_position.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class PositionWidget extends StatefulWidget {
  const PositionWidget({super.key});

  @override
  State<PositionWidget> createState() => _PositionWidgetState();
}

class _PositionWidgetState extends State<PositionWidget> {
  @override
  void initState() {
    dI<PositionBloc>().add(const GetPositionsEvent());
    super.initState();
  }

  _listener(PositionState state) {
    if (state.status == PositionStatus.updatePositionSuccess ||
        state.status == PositionStatus.deletePositionSuccess) {
      dI<PositionBloc>().add(const GetPositionsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: BlocConsumer<PositionBloc, PositionState>(
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
                  SizedBox(
                    height: state.positions.length * SpacingUnit.x28,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.positions.length,
                        itemBuilder: (context, index) {
                          return ItemPosition(
                            index: index,
                          );
                        }),
                  ),
                  ElevatedButton(
                    onPressed: () => _nextCreatePositionPage(context),
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

  _nextCreatePositionPage(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.createPositionPage);
  }
}
