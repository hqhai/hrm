import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class DataResponse<T> {
  @JsonKey(name: 'result')
  final T? data;
  @JsonKey(name: 'statusCode')
  final int? statusCode;

  const DataResponse({this.data, required this.statusCode});

  factory DataResponse.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) => _$DataResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(
    DataResponse<T> instance,
    Object? Function(T value) toJsonT,
  ) =>
      _$DataResponseToJson(instance, toJsonT);
}

@JsonSerializable(genericArgumentFactories: true)
class DataListResponse<T> {
  @JsonKey(name: 'result')
  final List<T>? result;
  @JsonKey(name: 'statusCode')
  final int? statusCode;

  const DataListResponse({
    this.result,
    this.statusCode,
  });

  factory DataListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$DataListResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(
    Object? Function(T value) toJsonT,
  ) =>
      _$DataListResponseToJson(this, toJsonT);
}

@JsonSerializable(genericArgumentFactories: true)
class DataListRecordPagingResponse<T> {
  @JsonKey(name: 'result')
  final Meta<T>? meta;
  @JsonKey(name: 'statusCode')
  final int? statusCode;

  const DataListRecordPagingResponse({
    this.meta,
    this.statusCode,
  });

  factory DataListRecordPagingResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$DataListRecordPagingResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(
    Object? Function(T value) toJsonT,
  ) =>
      _$DataListRecordPagingResponseToJson(this, toJsonT);
}

@JsonSerializable(genericArgumentFactories: true)
class Meta<T> {
  @JsonKey(name: 'items')
  final List<T>? items;

  @JsonKey(name: 'pagingInfo')
  final PageInfo? pageInfo;

  const Meta({this.items, this.pageInfo});

  factory Meta.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$MetaFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(
    Object? Function(T value) toJsonT,
  ) =>
      _$MetaToJson(this, toJsonT);
}

@JsonSerializable()
class PageInfo {
  @JsonKey(name: 'pageSize')
  final int? pageSize;
  @JsonKey(name: 'page')
  final int? page;
  @JsonKey(name: 'totalItems')
  final int? totalItems;

  const PageInfo({this.pageSize, this.page, this.totalItems});

  factory PageInfo.fromJson(Map<String, dynamic> json) => _$PageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PageInfoToJson(this);
}
