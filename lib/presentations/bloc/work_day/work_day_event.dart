import 'dart:async';

import 'package:base_app/data/models/request/cancel_work_day_request.dart';
import 'package:base_app/data/models/request/work_day_request.dart';
import 'package:equatable/equatable.dart';

sealed class WorkDayEvent extends Equatable {
  const WorkDayEvent();

  @override
  List<Object?> get props => [];
}

class GetWorkDaysEvent extends WorkDayEvent {
  final DateTime startDate;
  final DateTime endDate;
  final Completer? completer;

  const GetWorkDaysEvent({
    this.completer,
    required this.endDate,
    required this.startDate,
  });

  @override
  List<Object?> get props => [
        completer,
        endDate,
        startDate,
      ];
}

class ChangeSelectDate extends WorkDayEvent {
  final DateTime date;
  const ChangeSelectDate({
    required this.date,
  });

  @override
  List<Object?> get props => [
        date,
      ];
}

class ChangeLoading extends WorkDayEvent {
  final bool status;
  const ChangeLoading({
    required this.status,
  });

  @override
  List<Object?> get props => [
        status,
      ];
}

class RegisterWorkDay extends WorkDayEvent {
  final Completer completer;
  final Map<String, WorkDayRequest> request;
  const RegisterWorkDay({
    required this.request,
    required this.completer,
  });

  @override
  List<Object?> get props => [
        request,
        completer,
      ];
}

class CancelRegisterWorkDay extends WorkDayEvent {
  final CancelWorkDayRequest data;
  const CancelRegisterWorkDay({
    required this.data,
  });

  @override
  List<Object?> get props => [
        data,
      ];
}

class AddApprove extends WorkDayEvent {
  final ApproveRequest request;
  const AddApprove({
    required this.request,
  });

  @override
  List<Object?> get props => [
        request,
      ];
}

class GetWorkDayAdmin extends WorkDayEvent {
  final WorkDayAdminRequest data;
  const GetWorkDayAdmin({
    required this.data,
  });

  @override
  List<Object?> get props => [
        data,
      ];
}

class GetElectiveShift extends WorkDayEvent {
  final WorkDayGetElectiveShiftRequest data;
  const GetElectiveShift({
    required this.data,
  });

  @override
  List<Object?> get props => [
        data,
      ];
}

class GetElectiveShiftDetail extends WorkDayEvent {
  final GetElectiveShiftDetailRequest data;
  const GetElectiveShiftDetail({
    required this.data,
  });

  @override
  List<Object?> get props => [
        data,
      ];
}

class RegisterWorkDayAdmin extends WorkDayEvent {
  final ApproveRequest request;
  const RegisterWorkDayAdmin({
    required this.request,
  });

  @override
  List<Object?> get props => [
        request,
      ];
}

class CancelRegisterWorkDayAdmin extends WorkDayEvent {
  final CancelWorkDayAdminRequest data;
  const CancelRegisterWorkDayAdmin({
    required this.data,
  });

  @override
  List<Object?> get props => [
        data,
      ];
}
