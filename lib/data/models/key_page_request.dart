import 'package:json_annotation/json_annotation.dart';

part 'key_page_request.g.dart';

@JsonSerializable()
class KeyPageRequest {
  final String? keyword;
  final int page;

  const KeyPageRequest({
    this.page = 1,
    this.keyword,
  });

  factory KeyPageRequest.fromJson(Map<String, dynamic> json) => _$KeyPageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$KeyPageRequestToJson(this);
}
