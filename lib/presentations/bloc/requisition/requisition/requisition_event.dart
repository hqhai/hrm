import 'package:equatable/equatable.dart';

sealed class RequisitionEvent extends Equatable {
  const RequisitionEvent();

  @override
  List<Object?> get props => [];
}

class GetRequisitionsEvent extends RequisitionEvent {
  const GetRequisitionsEvent();

  @override
  List<Object?> get props => [];
}
