import 'package:json_annotation/json_annotation.dart';

part 'request.g.dart';

@JsonSerializable()
class Request {
  final String id;
  final String createdUserId;
  final String? updatedUserId;
  final String? createdFullName;
  final String? updatedFullName;
  final String? createdDate;
  final String? updatedDate;
  final String? type;
  final bool? isApprove;
  final String? approverId;
  final String? priority;
  final String? title;
  final String? content;
  final String? filePathsStr;
  final String? department;
  final String? phoneNumber;
  final String? note;
  final List<String>? filePaths;
  final String? status;
  final String? dateConfirmDone;
  final String? configStr;

  const Request({
    required this.id,
    required this.createdUserId,
    this.updatedUserId,
    this.createdFullName,
    this.updatedFullName,
    this.createdDate,
    this.updatedDate,
    this.type,
    this.isApprove,
    this.approverId,
    this.priority,
    this.title,
    this.content,
    this.filePathsStr,
    this.department ,
    this.phoneNumber,
    this.note,
    this.filePaths,
    this.status,
    this.dateConfirmDone,
    this.configStr,
  });

  factory Request.fromJson(Map<String, dynamic> json) => _$RequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToJson(this);
}
