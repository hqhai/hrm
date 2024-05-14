import 'package:base_app/data/models/request/change_list_status/change_status_request_command_models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_list_status_request.g.dart';

@JsonSerializable()
class ChangeListStatusRequest {
  final List<ChangeStatusRequestCommandModels> changeStatusRequestCommandModels;
  final String enumRequestType;

  const ChangeListStatusRequest(
      {
        required this.changeStatusRequestCommandModels,
        required this.enumRequestType ,
      });

  factory ChangeListStatusRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangeListStatusRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeListStatusRequestToJson(this);
}
