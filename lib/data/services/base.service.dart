import 'dart:convert';
import 'dart:typed_data';

import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/constants/key_constance.dart';
import 'package:base_app/common/log/logger.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/data/models/device_info_model.dart';
import 'package:base_app/data/models/response.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

abstract class BaseService {
  static final CustomClient defaultClient = CustomClient();
  static GetErrorMessage? _getErrorMessage;

  static GetErrorMessage get getErrorMessage =>
      _getErrorMessage ?? (err) => '$err';

  static set getErrorMessage(GetErrorMessage value) => _getErrorMessage = value;

  late final CustomClient client;

  BaseService({CustomClient? client}) {
    this.client = client ?? defaultClient;
  }

  Map<String, String> getHeadersWithToken(String token,
      {Map<String, String> extraParams = const {}}) {
    return {'Authorization': 'Bearer $token', ...mobileChannel, ...extraParams};
  }
}

Map<String, String> _defaultHeaders = {
  'Content-Type': 'application/json',
  'Accept-Language':
      Localizations.localeOf(dI<AppNavigation>().navigatorKey.currentContext!)
          .toString()
};
const mobileChannel = {'x-channel': 'E'};
const jwtPrefixToken = 'Bearer ';
final tokenExpiredError = ResponseBase(
    errorMessages: [ErrorMessages(errorCode: KeyConst.tokenExpired)],
    statusCode: 401,
    result: null);

Future _validateToken(Map<String, String> headers) async {
  final authorization = headers['Authorization'];
  if (authorization == null) return;
  if (!authorization.startsWith(jwtPrefixToken)) return;
  final token = authorization.replaceFirst(jwtPrefixToken, '');
  try {
    if (JwtDecoder.isExpired(token)) {
      throw tokenExpiredError;
    }
  } catch (e) {
    throw tokenExpiredError;
  }
}

void setDefaultHeaders(String userAgent, DeviceInfoModel deviceInfo) {
  _defaultHeaders = {
    ..._defaultHeaders,
    'User-Agent': userAgent,
    'Device-Id': deviceInfo.deviceId,
    'Brand': deviceInfo.brand,
    'Model': deviceInfo.model,
  };
}

Future<Response> catchError(Future<Response> request, Uri url,
    {bool isCached = false}) async {
  final startTime = DateTime.now().millisecondsSinceEpoch;
  try {
    Response response;
    // if (cacheManager != null && isCached) {
    //   response = await _cacheFetchData(
    //       cacheKey: url.toString(),
    //       service: request,
    //       cacheManager: cacheManager);
    // } else {
    response = await request;
    // }
    if (response.headers['content-type'] == 'application/json') {
      response.headers['content-type'] = 'application/json; charset=utf-8';
    }
    if (response.statusCode < 400) return response;
    final responseDecoded = ResponseBase.fromJson(json.decode(response.body));
    final req = response.request;
    _trackingError(req, response, responseDecoded);
    throw responseDecoded;
  } finally {
    final endTime = DateTime.now().millisecondsSinceEpoch;
    final timing = endTime - startTime;
    if (timing > 3000) {
      logger.w('request ${url.toString()} timeOut $timing');
    }
  }
}

// bool _isDataStale(CachedData data) {
//   DateTime currentTime = DateTime.now();
//   DateTime dataTime = data.updatedAt;
//   Duration difference = currentTime.difference(dataTime);
//   return difference.inMinutes > 10;
// }

// Future<Response> _cacheFetchData(
//     {required String cacheKey,
//     required Future<Response> service,
//     required DataCacheManager cacheManager}) async {
//   CachedData? cachedData = await cacheManager.get(cacheKey);

//   if (cachedData != null && _isDataStale(cachedData)) {
//     final cachedDataValue = cachedData.value as String;
//     final response = Response(cachedDataValue, 200);
//     return response;
//   }

//   Response newData = await service;
//   if (newData.statusCode < 400) {
//     final String body = newData.body;
//     await cacheManager.add(cacheKey, body);
//     return Response(newData.body, 200);
//   }
//   return newData;
// }

_trackingError(
    BaseRequest? request, Response response, ResponseBase error) async {
  final req = response.request;
  logger.e(response.request?.headers.toString());
  if (response.statusCode == 401) return;
  logger.e(
      ' error: ${jsonEncode(error)}\n  statusCode: ${response.statusCode.toString()}\n method: ${req?.method}\n url: ${req?.url}\n headers: ${req?.headers} ');
}

@lazySingleton
class CustomClient {
  final Client client = Client();

  // final _cacheManager = DefaultDataCacheManager.instance;
  Map<String, String> _addDefaultPropertiesToHeader(
      Map<String, String>? currentHeaders) {
    final headers = currentHeaders ?? {};
    return {
      ..._defaultHeaders,
      ...headers,
      if (AppConfig.getToken.isNotEmpty)
        'Authorization': '$jwtPrefixToken${AppConfig.getToken}'
    };
  }

  Uri getUrlWithParams(String url, Map<String, dynamic>? params) {
    final uri = Uri.parse(url);
    if (params == null || params.isEmpty) return uri;
    final params0 = <String, dynamic>{};
    params0.addAll(uri.queryParameters);
    params0.addAll(params.map((key, value) {
      if (value is List) {
        return MapEntry(key, value);
      }
      return MapEntry(key, value.toString());
    }));
    if (uri.scheme == 'https') {
      return Uri.https(uri.authority, uri.path, params0);
    }
    final result = Uri.http(uri.authority, uri.path, params0);
    return result;
  }

  Future<Response> get(String url,
      {Map<String, String>? customHeaders,
      Map<String, dynamic>? params,
      bool isCached = false}) async {
    final headers = _addDefaultPropertiesToHeader(customHeaders);
    await _validateToken(headers);
    final urlWithParams = getUrlWithParams(url, params);
    return catchError(
        client.get(urlWithParams, headers: headers),
        // cacheManager: _cacheManager,
        isCached: isCached,
        urlWithParams);
  }

  Future<Response> post(String url,
      {Map<String, String>? customHeaders,
      Map<String, String>? params,
      body,
      Encoding? encoding}) async {
    final headers = _addDefaultPropertiesToHeader(customHeaders);
    await _validateToken(headers);
    final urlWithParams = getUrlWithParams(url, params);
    return catchError(
        client.post(urlWithParams,
            headers: headers, body: body, encoding: encoding),
        urlWithParams);
  }

  Future<Response> patch(String url,
      {Map<String, String>? customHeaders,
      Map<String, String>? params,
      body,
      Encoding? encoding}) async {
    final headers = _addDefaultPropertiesToHeader(customHeaders);
    await _validateToken(headers);
    final urlWithParams = getUrlWithParams(url, params);
    return catchError(
        client.patch(urlWithParams,
            headers: headers, body: body, encoding: encoding),
        urlWithParams);
  }

  Future<Response> put(String url,
      {Map<String, String>? customHeaders,
      Map<String, String>? params,
      body,
      Encoding? encoding}) async {
    final headers = _addDefaultPropertiesToHeader(customHeaders);
    await _validateToken(headers);
    final urlWithParams = getUrlWithParams(url, params);
    return catchError(
        client.put(urlWithParams,
            headers: headers, body: body, encoding: encoding),
        urlWithParams);
  }

  Future<Response> delete(String url,
      {Map<String, String>? customHeaders,
      Map<String, String>? params,
      body,
      Encoding? encoding}) async {
    final headers = _addDefaultPropertiesToHeader(customHeaders);
    await _validateToken(headers);
    final urlWithParams = getUrlWithParams(url, params);
    return catchError(
        client.delete(urlWithParams, headers: headers), urlWithParams);
  }

  Future<String> postUploadFile(
    String url, {
    required String fileType,
    required Uint8List uploadFileBytes,
    required String fileName,
    Map<String, String>? customHeaders,
  }) async {
    final headers = _addDefaultPropertiesToHeader(customHeaders);

    final request = MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    request.fields.addAll({UploadFileBody.fileType: fileType});

    request.files.add(
      MultipartFile.fromBytes(
        UploadFileBody.file,
        uploadFileBytes,
        filename: '${fileType}_$fileName',
        contentType: MediaType('image', 'png'),
      ),
    );
    final response = await request.send();
    final body = await response.stream.bytesToString();
    if (response.statusCode < 400) {
      return body;
    } else {
      final error = ResponseBase.fromJson(json.decode(body));
      throw error;
    }
  }

  Future<String> postUploadFiles(
    String url, {
    required List<String> fileTypes,
    required List<Uint8List> uploadFileBytes,
    required List<String> fileNames,
    Map<String, String>? customHeaders,
  }) async {
    final headers = _addDefaultPropertiesToHeader(customHeaders);
    final request = MultipartRequest('POST', Uri.parse(url));

    uploadFileBytes.forEachIndexed((index, element) {
      request.fields
          .addAll({'${UploadFileBody.fileType}$index': fileTypes[index]});
      request.files.add(
        MultipartFile.fromBytes(
          '${UploadFileBody.fileType}$index',
          uploadFileBytes[index],
          filename: '${fileTypes[index]}_${fileNames[index]}',
          contentType: MediaType('image', fileTypes[index].replaceAll('/', '')),
        ),
      );
    });
    request.headers.addAll(headers);

    final response = await request.send();
    final body = await response.stream.bytesToString();
    if (response.statusCode < 400) {
      return body;
    } else {
      final error = ResponseBase.fromJson(json.decode(body));
      throw error;
    }
  }

  Future<String> postUploadFileByWeb(
    String url, {
    required String fileType,
    required String uploadFileBytes,
    required String fileName,
    Map<String, String>? customHeaders,
  }) async {
    final headers = _addDefaultPropertiesToHeader(customHeaders);

    final request = MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    request.fields.addAll({UploadFileBody.fileType: fileType});

    request.files.add(
      MultipartFile.fromString(UploadFileBody.file, uploadFileBytes,
          filename: '${fileType}_$fileName',
          contentType: MediaType(
            'image',
            'png',
          )),
    );
    final response = await request.send();
    final body = await response.stream.bytesToString();
    if (response.statusCode < 400) {
      return body;
    } else {
      final error = ResponseBase.fromJson(json.decode(body));
      throw error;
    }
  }
}

typedef GetErrorMessage = String Function(Exception err);

class UploadFileBody {
  static const file = 'file';
  static const fileType = 'fileType';
}

class UploadFileType {
  static const id1 = 'id1';
  static const id2 = 'id2';
  static const portrait = 'portrait';
  static const signature = 'signature';
}
