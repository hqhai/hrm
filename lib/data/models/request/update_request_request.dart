import 'package:json_annotation/json_annotation.dart';

part 'update_request_request.g.dart';

@JsonSerializable()
class UpdateRequestRequest {
  final String priority;
  final String? title;
  final String? content;
  final List<String>? filePaths;

  const UpdateRequestRequest({
    required this.priority,
    this.title = '',
    this.content = '',
    this.filePaths = const [],
  });

  UpdateRequestRequest copyWith({
    required String priority,
    String? title,
    String? content,
    List<String>? filePaths,
  }) {
    return UpdateRequestRequest(
      priority: priority,
      title: title ?? this.title,
      content: content ?? this.content,
      filePaths: filePaths ?? this.filePaths,
    );
  }

  factory UpdateRequestRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateRequestRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateRequestRequestToJson(this);
}
