import 'dart:async';

import 'package:equatable/equatable.dart';

sealed class FlowEvent extends Equatable {
  const FlowEvent();

  @override
  List<Object?> get props => [];
}

class GetFlowsEvent extends FlowEvent {
  final int page;
  final Completer? completer;

  const GetFlowsEvent({this.page = 1, this.completer});

  @override
  List<Object?> get props => [page, completer];
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
