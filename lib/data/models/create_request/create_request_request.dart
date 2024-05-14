import 'package:json_annotation/json_annotation.dart';

part 'create_request_request.g.dart';

@JsonSerializable()
class CreateRequestRequest {
  final String type;
  final bool isApprove;
  final String priority;
  final String? title;
  final String? content;
  final List<String>? filePaths;
  final String? approverId;
  final String? config;

  const CreateRequestRequest(
      {required this.type,
      required this.isApprove,
      this.title = '',
      this.content = '',
      required this.priority,
      this.approverId = '',
      this.filePaths = const [],
      this.config = ''});

  factory CreateRequestRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateRequestRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateRequestRequestToJson(this);
}
