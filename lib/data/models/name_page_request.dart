import 'package:json_annotation/json_annotation.dart';

part 'name_page_request.g.dart';

@JsonSerializable()
class NamePageRequest {
  final String name;
  final int page;

  const NamePageRequest({
    this.page = 1,
    this.name = '',
  });

  factory NamePageRequest.fromJson(Map<String, dynamic> json) => _$NamePageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NamePageRequestToJson(this);
}
