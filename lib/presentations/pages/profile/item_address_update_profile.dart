import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/address.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet_district.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet_province.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet_ward.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemAddressUpdateProfile extends StatefulWidget {
  const ItemAddressUpdateProfile({
    super.key,
    required this.onChangeProvince,
    required this.onChangeDistrict,
    required this.onChangeWard,
    this.district = const Address(),
    this.ward = const Address(),
    this.province = const Address(),
  });

  final ValueChanged<Address?> onChangeProvince, onChangeDistrict, onChangeWard;
  final Address province, district, ward;

  @override
  State<ItemAddressUpdateProfile> createState() =>
      _ItemAddressUpdateProfileState();
}

class _ItemAddressUpdateProfileState extends State<ItemAddressUpdateProfile> {
  Address? province, district, ward;

  @override
  void initState() {
    province = widget.province;
    district = widget.district;
    ward = widget.ward;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ItemAddressUpdateProfile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.province != oldWidget.province) {
      setState(() => province = widget.province);
    }
    if (widget.district != oldWidget.district) {
      setState(() => district = widget.district);
    }
    if (widget.ward != oldWidget.ward) {
      setState(() => ward = widget.ward);
    }
  }

  void _setAddress() {
    widget.onChangeProvince.call(province);
    widget.onChangeDistrict.call(district);
    widget.onChangeWard.call(ward);
  }

  void _getProvince(Address address) {
    setState(() {
      province = address;
      district = null;
      ward = null;
    });
    _setAddress();
  }

  void _getDistrict(Address address) {
    setState(() {
      district = address;
      ward = null;
    });
    _setAddress();
  }

  void _getWard(Address address) {
    setState(() {
      ward = address;
    });
    _setAddress();
  }

  void _addProvince(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetProvinceWidget(
          onChange: (value) => _getProvince(value),
        );
      },
    );
  }

  void _addDistrict(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetDistrictWidget(
          parentId: province?.id ?? "",
          onChange: (value) => _getDistrict(value),
        );
      },
    );
  }

  void _addWard(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetWardWidget(
          parentId: district?.id ?? "",
          onChange: (value) => _getWard(value),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DropdownField(
          label: l10n.province,
          value: province?.name ?? '',
          onTap: () => _addProvince(context),
        ),
        _DropdownField(
          label: l10n.district,
          value: district?.name ?? '',
          onTap: () => _addDistrict(context),
        ),
        _DropdownField(
          label: l10n.ward,
          value: ward?.name ?? '',
          onTap: () => _addWard(context),
        ),
      ],
    );
  }
}

class _DropdownField extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const _DropdownField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.text.withValues(alpha: 0.5),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: SpacingUnit.x1_5),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: SpacingUnit.x3,
                vertical: SpacingUnit.x3,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
                border: Border.all(
                  color: colors.text.withValues(alpha: 0.12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      value.isNotEmpty ? value : '--',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: value.isNotEmpty
                            ? colors.text
                            : colors.text.withValues(alpha: 0.3),
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: colors.text.withValues(alpha: 0.4),
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
