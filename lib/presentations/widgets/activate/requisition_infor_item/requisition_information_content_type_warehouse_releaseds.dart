import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/release_of_warehouse/item_list_release_of_warehouse.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/release_of_warehouse/item_list_release_of_warehouse_extend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class RequisitionInformationContentTypeWarehouseReleaseds extends StatefulWidget {
  const RequisitionInformationContentTypeWarehouseReleaseds({
    super.key,
  });

  @override
  State<RequisitionInformationContentTypeWarehouseReleaseds> createState() =>
      _RequisitionInformationContentTypeWarehouseReleasedsState();
}

class _RequisitionInformationContentTypeWarehouseReleasedsState
    extends State<RequisitionInformationContentTypeWarehouseReleaseds> {
  List<bool> listCheck = [];

  @override
  void initState() {
    if (dI<RequisitionBloc>().state.requisition.config.warehourseReleaseds?.isNotEmpty ?? false) {
      int count = dI<RequisitionBloc>().state.requisition.config.warehourseReleaseds!.length;
      listCheck = List.filled(count, true);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final height = MediaQuery.sizeOf(context).height;
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<RequisitionBloc, RequisitionState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appLocalizations.description,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x3,
                  fontWeight: FontWeight.w800,
                ),
              ),
              if (state.requisition.config.warehourseReleaseds?.isNotEmpty ?? false)
                Container(
                    height: _customHeight(height),
                    padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
                    child: ListView.builder(
                      itemCount: state.requisition.config.warehourseReleaseds?.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => checkSubmit(index),
                        child: listCheck[index]
                            ? ItemListReleaseOfWarehouse(
                                requisitionReleaseOfWarehouse:
                                    state.requisition.config.warehourseReleaseds?[index],
                                index: index,
                              )
                            : ItemListReleaseOfWarehouseExtend(
                                requisitionReleaseOfWarehouse:
                                    state.requisition.config.warehourseReleaseds?[index],
                                index: index,
                              ),
                      ),
                    )),
            ],
          ),
        );
      },
    );
  }

  checkSubmit(int index) {
    setState(() {
      listCheck[index] = !listCheck[index];
    });
  }

  double _customHeight(double height) {
    return (height * 0.125) * listCheck.where((e) => e == true).length +
        (height * 0.278) * listCheck.where((e) => e == false).length;
  }
}
