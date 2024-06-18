import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/address.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'address_state.g.dart';

@CopyWith()
class AddressState extends Equatable {
  const AddressState(
      {this.provinces = const [],
      this.districts = const [],
      this.wards = const [],
      this.status = AddressStatus.init,
      this.totalItemDistricts = 0,
      this.totalItemProvinces = 0,
      this.totalItemWards = 0});

  final List<Address> provinces;
  final List<Address> districts;
  final List<Address> wards;
  final AddressStatus status;
  final int totalItemProvinces;
  final int totalItemDistricts;
  final int totalItemWards;

  @override
  List<Object> get props => [
        provinces,
        districts,
        wards,
        status,
        totalItemProvinces,
        totalItemDistricts,
        totalItemWards,
      ];
}
