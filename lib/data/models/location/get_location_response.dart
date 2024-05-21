import 'package:base_app/domain/entities/address.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_location_response.g.dart';

@JsonSerializable()
class GetLocationResponse {
  final List<Address> items;

  const GetLocationResponse({
    this.items = const [],
  });

  factory GetLocationResponse.fromJson(Map<String, dynamic> json) =>
      _$GetLocationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetLocationResponseToJson(this);
}
