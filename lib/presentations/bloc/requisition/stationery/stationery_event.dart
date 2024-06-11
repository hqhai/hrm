
import 'package:equatable/equatable.dart';

sealed class StationeryEvent extends Equatable {
  const StationeryEvent();

  @override
  List<Object?> get props => [];

}

class GetStationeriesEvent extends StationeryEvent {
  final String name;
  final int page;
  const GetStationeriesEvent({this.name = '', this.page = 1});

  @override
  List<Object?> get props => [name, page];
}
