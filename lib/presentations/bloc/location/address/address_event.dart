
import 'package:equatable/equatable.dart';

sealed class AddressEvent extends Equatable {

  const AddressEvent();

  @override
  List<Object?> get props => [];
}

class GetProvincesEvent extends AddressEvent {
  const GetProvincesEvent();

  @override
  List<Object?> get props => [];
}

class GetDistrictsEvent extends AddressEvent {
  const GetDistrictsEvent({required this.parentId});
  final String parentId;

  @override
  List<Object?> get props => [parentId];
}

class GetWardsEvent extends AddressEvent {
  const GetWardsEvent({required this.parentId});
  final String parentId;

  @override
  List<Object?> get props => [parentId];
}

class GetDistrictsByKeyEvent extends AddressEvent {
  const GetDistrictsByKeyEvent({required this.keyWord});
  final String keyWord;

  @override
  List<Object?> get props => [keyWord];
}

class GetWardsByKeyEvent extends AddressEvent {
  const GetWardsByKeyEvent({required this.keyWord});
  final String keyWord;

  @override
  List<Object?> get props => [keyWord];
}
