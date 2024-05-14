// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RequestStateCWProxy {
  RequestState request(Request request);

  RequestState requests(List<Request> requests);

  RequestState requestsByUser(List<Request> requestsByUser);

  RequestState status(RequestStatus status);

  RequestState totalItems(int totalItems);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RequestState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RequestState(...).copyWith(id: 12, name: "My name")
  /// ````
  RequestState call({
    Request? request,
    List<Request>? requests,
    List<Request>? requestsByUser,
    RequestStatus? status,
    int? totalItems,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRequestState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRequestState.copyWith.fieldName(...)`
class _$RequestStateCWProxyImpl implements _$RequestStateCWProxy {
  final RequestState _value;

  const _$RequestStateCWProxyImpl(this._value);

  @override
  RequestState request(Request request) => this(request: request);

  @override
  RequestState requests(List<Request> requests) => this(requests: requests);

  @override
  RequestState requestsByUser(List<Request> requestsByUser) =>
      this(requestsByUser: requestsByUser);

  @override
  RequestState status(RequestStatus status) => this(status: status);

  @override
  RequestState totalItems(int totalItems) => this(totalItems: totalItems);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RequestState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RequestState(...).copyWith(id: 12, name: "My name")
  /// ````
  RequestState call({
    Object? request = const $CopyWithPlaceholder(),
    Object? requests = const $CopyWithPlaceholder(),
    Object? requestsByUser = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? totalItems = const $CopyWithPlaceholder(),
  }) {
    return RequestState(
      request: request == const $CopyWithPlaceholder() || request == null
          ? _value.request
          // ignore: cast_nullable_to_non_nullable
          : request as Request,
      requests: requests == const $CopyWithPlaceholder() || requests == null
          ? _value.requests
          // ignore: cast_nullable_to_non_nullable
          : requests as List<Request>,
      requestsByUser: requestsByUser == const $CopyWithPlaceholder() ||
              requestsByUser == null
          ? _value.requestsByUser
          // ignore: cast_nullable_to_non_nullable
          : requestsByUser as List<Request>,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as RequestStatus,
      totalItems:
          totalItems == const $CopyWithPlaceholder() || totalItems == null
              ? _value.totalItems
              // ignore: cast_nullable_to_non_nullable
              : totalItems as int,
    );
  }
}

extension $RequestStateCopyWith on RequestState {
  /// Returns a callable class that can be used as follows: `instanceOfRequestState.copyWith(...)` or like so:`instanceOfRequestState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RequestStateCWProxy get copyWith => _$RequestStateCWProxyImpl(this);
}
