import 'package:base_app/domain/entities/address.dart';

abstract class LocationUseCase {
  Future<List<Address>> getAddress(
      {required int pageSize, required int page, required String locationType, String? parentId});
}
