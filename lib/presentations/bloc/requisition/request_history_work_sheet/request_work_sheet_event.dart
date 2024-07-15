import 'dart:async';

import 'package:equatable/equatable.dart';

sealed class RequestWorkSheetEvent extends Equatable {
  const RequestWorkSheetEvent();

  @override
  List<Object?> get props => [];
}

class GetRequestsByIdsEvent extends RequestWorkSheetEvent {
  final List<String> ids;
  final Completer? completer;

  const GetRequestsByIdsEvent({
    this.ids = const [],
    this.completer,
  });

  @override
  List<Object?> get props => [ids, completer];
}
