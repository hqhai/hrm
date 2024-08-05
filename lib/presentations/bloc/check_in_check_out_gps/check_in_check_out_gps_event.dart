import 'dart:async';

import 'package:equatable/equatable.dart';

sealed class CheckInCheckOutGpsEvent extends Equatable {
  const CheckInCheckOutGpsEvent();

  @override
  List<Object?> get props => [];
}

class PostTimekeepingGPSRequestEvent extends CheckInCheckOutGpsEvent {
  final double longitude;
  final double latitude;
  final String scheduleSchoolId;
  final Completer completer;

  const PostTimekeepingGPSRequestEvent({
    this.longitude = 0,
    this.latitude = 0,
    required this.scheduleSchoolId,
    required this.completer
  });

  @override
  List<Object?> get props => [longitude, latitude, scheduleSchoolId, completer];
}
