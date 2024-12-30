import 'package:base_app/common/exception/remote/remote_exception.dart';
import 'package:base_app/data/source/api/mapper/success/data_json_array_response_mapper.dart';
import 'package:base_app/data/source/api/mapper/success/data_json_object_reponse_mapper.dart';
import 'package:base_app/data/source/api/mapper/success/data_json_record_paging_mapper.dart';
import 'package:base_app/data/source/api/mapper/success/plain_response_mapper.dart';

import '../client/base/rest_client_base.dart';

enum SuccessResponseMapperType {
  dataJsonObject,
  dataJsonArray,
  dataRecordPaging,
  plain,
}

abstract class BaseSuccessResponseMapper<I extends Object, O extends Object> {
  const BaseSuccessResponseMapper();

  factory BaseSuccessResponseMapper.fromType(SuccessResponseMapperType type) {
    return switch (type) {
      SuccessResponseMapperType.dataJsonObject => DataJsonObjectResponseMapper<I>() as BaseSuccessResponseMapper<I, O>,
      SuccessResponseMapperType.dataJsonArray => DataJsonArrayResponseMapper<I>() as BaseSuccessResponseMapper<I, O>,
      SuccessResponseMapperType.plain => PlainResponseMapper<I>() as BaseSuccessResponseMapper<I, O>,
      SuccessResponseMapperType.dataRecordPaging => DataJsonRecordPagingMapper<I>() as BaseSuccessResponseMapper<I, O>,
    };
  }

  O? map({
    required dynamic response,
    Decoder<I>? decoder,
  }) {
    assert(response != null);
    try {
      return mapToDataModel(response: response, decoder: decoder);
    } on RemoteException catch (_) {
      rethrow;
    } catch (e) {
      throw RemoteException(kind: RemoteExceptionKind.decodeError, rootException: e);
    }
  }

  // ignore: avoid-dynamic
  O? mapToDataModel({
    required dynamic response,
    Decoder<I>? decoder,
  });
}
