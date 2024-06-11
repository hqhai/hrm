import 'package:json_annotation/json_annotation.dart';

part 'search_user_by_name_request.g.dart';

@JsonSerializable()
class SearchUserByNameRequest {
  final String fullName;
  final int page;

  const SearchUserByNameRequest({
    this.fullName = '',
    this.page = 0
  });

  factory SearchUserByNameRequest.fromJson(Map<String, dynamic> json) =>
      _$SearchUserByNameRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SearchUserByNameRequestToJson(this);
}
