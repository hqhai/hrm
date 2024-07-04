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
  final DateTime time;
  final Completer completer;

  const PostTimekeepingGPSRequestEvent({
    this.longitude = 0,
    this.latitude = 0,
    required this.time,
    required this.completer
  });

  @override
  List<Object?> get props => [longitude, latitude, time, completer];
}
