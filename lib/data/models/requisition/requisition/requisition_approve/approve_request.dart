import 'package:json_annotation/json_annotation.dart';

part 'approve_request.g.dart';

@JsonSerializable()
class ApproveRequest {
  final String id;
  final String note;
  final String status;

  const ApproveRequest({
    this.id = '',
    this.note = '',
    this.status = '',
  });

  factory ApproveRequest.fromJson(Map<String, dynamic> json) => _$ApproveRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ApproveRequestToJson(this);
}
