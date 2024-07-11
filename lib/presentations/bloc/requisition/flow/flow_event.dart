import 'dart:async';

import 'package:equatable/equatable.dart';

sealed class FlowEvent extends Equatable {
  const FlowEvent();

  @override
  List<Object?> get props => [];
}

class GetFlowsEvent extends FlowEvent {
  final int page;

  const GetFlowsEvent({this.page = 1});

  @override
  List<Object?> get props => [page];
}

class GetFlowEvent extends FlowEvent {
  const GetFlowEvent({
    this.id = '',
    this.completer,
  });

  final String id;
  final Completer? completer;

  @override
  List<Object?> get props => [id, completer];
}
