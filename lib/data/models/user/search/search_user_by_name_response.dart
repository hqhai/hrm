import 'package:base_app/domain/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_user_by_name_response.g.dart';

@JsonSerializable()
class SearchUserByNameResponse {
  final List<User> users;
  final int totalItems;

  const SearchUserByNameResponse({
    this.users = const [],
    this.totalItems = 0
  });

  factory SearchUserByNameResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchUserByNameResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchUserByNameResponseToJson(this);
}
