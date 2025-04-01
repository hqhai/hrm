import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/address.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/location/address/address_bloc.dart';
import 'package:base_app/presentations/bloc/location/address/address_event.dart';
import 'package:base_app/presentations/bloc/location/address/address_state.dart';
import 'package:base_app/presentations/widgets/dialog/filter_request/item/header_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class BottomSheetWardWidget extends StatefulWidget {
  const BottomSheetWardWidget({
    super.key,
    required this.onChange,
    required this.parentId,
  });

  final ValueChanged<Address> onChange;
  final String parentId;

  @override
  State<BottomSheetWardWidget> createState() => _BottomSheetWardWidgetState();
}

class _BottomSheetWardWidgetState extends State<BottomSheetWardWidget> {
  String searchStr = '';
  late ScrollController controller;
  int pageIndex = 1, totalItems = 12, lengthList = 11;
  AddressStatus status = AddressStatus.init;

  @override
  void initState() {
    dI<AddressBloc>().add(GetWardsEvent(
      parentId: widget.parentId,
      page: 1,
    ));
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final height = MediaQuery.of(context).size.height;
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocConsumer<AddressBloc, AddressState>(
      listener: (context, state) => _listener(context, state),
      builder: (context, state) {
        return Container(
          height: height * 0.6,
          color: colors.text.withValues(alpha: 0.1),
          child: Center(
            child: Column(
              children: [
                HeaderFilter(
                    callback: () => close(context),
                    title: appLocalizations.ward),
                Expanded(
                  child: ListView.builder(
                    controller: controller,
                    itemCount: state.wards.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => addAddress(
                        address: state.wards[index],
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(SpacingUnit.x4),
                        margin: const EdgeInsets.all(SpacingUnit.x2),
                        decoration: BoxDecoration(
                          color: colors.background,
                          borderRadius: BorderRadius.circular(SpacingUnit.x2),
                          border: Border.all(
                            color: colors.background,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              '${index + 1}.    ',
                              style: TextStyle(
                                color: colors.text,
                                fontSize: SpacingUnit.x4,
                              ),
                            ),
                            Text(
                              state.wards[index].name ?? "",
                              style: TextStyle(
                                color: colors.text,
                                fontSize: SpacingUnit.x4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  close(BuildContext context) {
    dI<AppNavigation>().pop(context);
  }

  _scrollListener() {
    if (lengthList < totalItems &&
        status == AddressStatus.getWardsSuccess &&
        controller.position.extentAfter < totalItems) {
      setState(() {
        pageIndex++;
      });
      dI<AddressBloc>().add(GetWardsEvent(
        parentId: widget.parentId,
        page: pageIndex,
      ));
    }
  }

  _listener(BuildContext context, AddressState state) {
    setState(() {
      status = state.status;
      totalItems = state.totalItemWards;
      lengthList = state.wards.length;
    });
  }

  addAddress({required Address address}) {
    widget.onChange.call(address);
    Navigator.of(context).pop();
  }
}
