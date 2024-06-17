import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/address.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/location/address/address_bloc.dart';
import 'package:base_app/presentations/bloc/location/address/address_event.dart';
import 'package:base_app/presentations/bloc/location/address/address_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class BottomSheetProvinceWidget extends StatefulWidget {
  const BottomSheetProvinceWidget({
    super.key,
    required this.onChange,
  });

  final ValueChanged<Address> onChange;

  @override
  State<BottomSheetProvinceWidget> createState() => _BottomSheetProvinceWidgetState();
}

class _BottomSheetProvinceWidgetState extends State<BottomSheetProvinceWidget> {
  String searchStr = '';
  late ScrollController controller;
  int pageIndex = 1, totalItems = 0, lengthList = 0;
  AddressStatus status = AddressStatus.init;

  @override
  void initState() {
    dI<AddressBloc>().add(const GetProvincesEvent(
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
          color: colors.surface,
          child: Center(
            child: Column(
              children: [
                Text(
                  appLocalizations.province,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x6,
                  ),
                ),
                SizedBox(
                  height: height * 0.4,
                  child: ListView.builder(
                    controller: controller,
                    itemCount: state.provinces.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => addAddress(
                        address: state.provinces[index],
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(SpacingUnit.x2),
                        margin: const EdgeInsets.all(SpacingUnit.x2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(SpacingUnit.x2),
                          border: Border.all(
                            color: colors.text,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              '${index + 1}.    ',
                              style: TextStyle(
                                color: colors.text,
                                fontSize: SpacingUnit.x3,
                              ),
                            ),
                            Text(
                              state.provinces[index].name ?? "",
                              style: TextStyle(
                                color: colors.text,
                                fontSize: SpacingUnit.x3,
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

  _scrollListener() {
    if (lengthList <= totalItems &&
        status == AddressStatus.getProvincesSuccess &&
        controller.position.extentAfter < totalItems) {
      setState(() {
        pageIndex++;
      });
      dI<AddressBloc>().add(GetProvincesEvent(
        page: pageIndex,
      ));
    }
  }

  _listener(BuildContext context, AddressState state) {
    setState(() {
      status = state.status;
      totalItems = state.totalItemProvinces;
      lengthList = state.provinces.length;
    });
  }

  addAddress({required Address address}) {
    widget.onChange.call(address);
    Navigator.of(context).pop();
  }
}
