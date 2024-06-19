import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_request_request.g.dart';

@CopyWith()
@JsonSerializable()
class PostRequestRequest {
  final String? flowId;
  final dynamic config;
  final List<String>? followerIds;



  const PostRequestRequest({
    this.followerIds,
    this.config,
    this.flowId
  });

  factory PostRequestRequest.fromJson(Map<String, dynamic> json) =>
      _$PostRequestRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PostRequestRequestToJson(this);
}
