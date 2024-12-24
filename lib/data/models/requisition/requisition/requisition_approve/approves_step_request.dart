
import 'package:json_annotation/json_annotation.dart';


part 'approves_step_request.g.dart';

@JsonSerializable()
class ApprovesStepRequest {
  final List<String> stepRequestApproverId;
  final bool isAll;

  ApprovesStepRequest({
    required this.stepRequestApproverId,
    this.isAll = false,
  });

  factory ApprovesStepRequest.fromJson(Map<String, dynamic> json) => _$ApprovesStepRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ApprovesStepRequestToJson(this);
}
