import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_request_request.g.dart';

@JsonSerializable()
@CopyWith()
class GetRequestRequest {
  final int page;
  final int pageSize;

  const GetRequestRequest({
    this.page = 1,
    this.pageSize = 10
  });

  factory GetRequestRequest.fromJson(Map<String, dynamic> json) =>
      _$GetRequestRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetRequestRequestToJson(this);
}
