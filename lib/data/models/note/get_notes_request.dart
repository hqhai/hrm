import 'package:json_annotation/json_annotation.dart';

part 'get_notes_request.g.dart';

@JsonSerializable()
class GetNotesRequest {
  final String startDate;
  final String endDate;

  const GetNotesRequest(
      {required this.startDate,
        required this.endDate,
        });

  factory GetNotesRequest.fromJson(Map<String, dynamic> json) =>
      _$GetNotesRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetNotesRequestToJson(this);
}
