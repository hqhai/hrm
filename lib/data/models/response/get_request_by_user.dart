import 'package:base_app/domain/entities/request.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class GetRequestByUserResponse {
  final int totalItems;
  final List<Request> requests;
  const GetRequestByUserResponse({this.totalItems = 0, this.requests = const []});
}
