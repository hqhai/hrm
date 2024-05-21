import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/address.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_state.g.dart';

@CopyWith()
@JsonSerializable()
class AddressState extends Equatable {
  const AddressState(
      {this.provinces = const [],
      this.districts = const [],
      this.wards = const [],
      this.status = AddressStatus.init});

  final List<Address> provinces;
  final List<Address> districts;
  final List<Address> wards;
  final AddressStatus status;

  @override
  List<Object> get props => [provinces, districts, wards, status];
}
