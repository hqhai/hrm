import 'package:base_app/domain/entities/request.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class GetRequestByAdminResponse {
  final int statusCode;
  final List<Request> requests;
  const GetRequestByAdminResponse({this.statusCode = 0, this.requests = const []});
}
