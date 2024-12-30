import 'package:json_annotation/json_annotation.dart';

part 'position.g.dart';

@JsonSerializable()
class Position {
  final String name;
  final String description;
  final String id;
  final String createdUserId;
  final String updatedUserId;
  final String createdFullName;
  final String updatedFullName;
  final String createdDate;
  final String updatedDate;

  const Position({
    this.name = '',
    this.description = '',
    this.id = '',
    this.createdUserId = '',
    this.updatedUserId = '',
    this.createdFullName = '',
    this.updatedFullName = '',
    this.createdDate = '',
    this.updatedDate = '',
  });

  factory Position.fromJson(Map<String, dynamic> json) => _$PositionFromJson(json);
  Map<String, dynamic> toJson() => _$PositionToJson(this);
}
