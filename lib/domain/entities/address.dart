import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@CopyWith()
@JsonSerializable()
class Address {
  final String? name;
  final String? id;

  const Address({
    this.name,
    this.id,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
