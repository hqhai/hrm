import 'package:json_annotation/json_annotation.dart';

part 'get_list_user_by_request_explanation.g.dart';

@JsonSerializable()
class GetListUserByRequestExplanationRequest {
  final String startDate;
  final String endDate;

  const GetListUserByRequestExplanationRequest(
      {
        this.endDate = '',
        this.startDate = ''
      });

  factory GetListUserByRequestExplanationRequest.fromJson(Map<String, dynamic> json) =>
      _$GetListUserByRequestExplanationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetListUserByRequestExplanationRequestToJson(this);
}
