import 'package:json_annotation/json_annotation.dart';

part 'cancel_request.g.dart';

@JsonSerializable()
class CancelRequest {
  final String id;
  final String note;

  const CancelRequest({
    this.id = '',
    this.note = '',
  });

  factory CancelRequest.fromJson(Map<String, dynamic> json) => _$CancelRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CancelRequestToJson(this);
}
