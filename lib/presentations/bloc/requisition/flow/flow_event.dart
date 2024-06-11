import 'package:equatable/equatable.dart';

sealed class FlowEvent extends Equatable {
  const FlowEvent();

  @override
  List<Object?> get props => [];
}

class GetFlowsEvent extends FlowEvent {
  const GetFlowsEvent();

  @override
  List<Object?> get props => [];
}

class GetFlowEvent extends FlowEvent {
  const GetFlowEvent({this.id = ''});

  final String id;

  @override
  List<Object?> get props => [id];
}
