import 'package:equatable/equatable.dart';

sealed class PositionEvent extends Equatable {
  const PositionEvent();

  @override
  List<Object?> get props => [];
}

class CreatePositionEvent extends PositionEvent {
  final String name;
  final String? description;

  const CreatePositionEvent({
    required this.name,
    this.description,
  });

  @override
  List<Object?> get props => [name, description];
}

class GetPositionsEvent extends PositionEvent {
  const GetPositionsEvent();

  @override
  List<Object?> get props => [];
}

class GetPositionByIdEvent extends PositionEvent {
  final String id;

  const GetPositionByIdEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class DeletePositionsEvent extends PositionEvent {
  final String id;

  const DeletePositionsEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class UpdatePositionEvent extends PositionEvent {
  final String id;
  final String name;
  final String? description;

  const UpdatePositionEvent({
    required this.id,
    required this.name,
    this.description,
  });

  @override
  List<Object?> get props => [id, name, description,];
}

class ResetPositionEvent extends PositionEvent {
  const ResetPositionEvent();

  @override
  List<Object> get props => [];
}
