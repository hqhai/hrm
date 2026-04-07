import 'package:json_annotation/json_annotation.dart';

part 'change_status_request_command_models.g.dart';

@JsonSerializable()
class ChangeStatusRequestCommandModels {
  final String requestId;
  final String status;
  final String note;

  const ChangeStatusRequestCommandModels(
      {
        this.requestId = '',
        this.status = '',
        this.note = ''
      });

  ChangeStatusRequestCommandModels copyWith(
      {String? requestId,
      String? status,
      String? note,}) {
    return ChangeStatusRequestCommandModels(
      requestId: requestId ?? this.requestId,
      status: status ?? this.status,
      note: note ?? this.note
    );
  }

  factory ChangeStatusRequestCommandModels.fromJson(Map<String, dynamic> json) =>
      _$ChangeStatusRequestCommandModelsFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeStatusRequestCommandModelsToJson(this);
}
