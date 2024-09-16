
import 'package:equatable/equatable.dart';

sealed class AddressEvent extends Equatable {

  const AddressEvent();

  @override
  List<Object?> get props => [];
}

class GetProvincesEvent extends AddressEvent {
  const GetProvincesEvent({this.page = 1});
  final int page;

  @override
  List<Object?> get props => [page];
}

class GetDistrictsEvent extends AddressEvent {
  const GetDistrictsEvent({required this.parentId, required this.page});
  final String parentId;
  final int page;

  @override
  List<Object?> get props => [parentId, page];
}

class GetWardsEvent extends AddressEvent {
  const GetWardsEvent({required this.parentId, required this.page});
  final String parentId;
  final int page;

  @override
  List<Object?> get props => [parentId, page];
}
class GetProvinceByKeyEvent extends AddressEvent {
  const GetProvinceByKeyEvent({required this.keyWord});
  final String keyWord;

  @override
  List<Object?> get props => [keyWord];
}


class GetDistrictsByKeyEvent extends AddressEvent {
  const GetDistrictsByKeyEvent({required this.keyWord, this.parentId = ''});
  final String keyWord;
  final String parentId;

  @override
  List<Object?> get props => [keyWord, parentId];
}

class GetWardsByKeyEvent extends AddressEvent {
  const GetWardsByKeyEvent({required this.keyWord, this.parentId = ''});
  final String keyWord;
  final String parentId;

  @override
  List<Object?> get props => [keyWord, parentId];
}

class ResetAddressEvent extends AddressEvent {
  const ResetAddressEvent();

  @override
  List<Object> get props => [];
}
