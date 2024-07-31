import 'package:base_app/data/services/base.service.dart';
import 'package:flutter/foundation.dart';
import 'package:test/test.dart';

void main() {
  group(
    BaseService,
    () {
      test(
        '',
        () async {
          final params = CustomClient().getUrlWithParams('baseUrl', {
            'UR': ['type1', 'type1']
          });
          debugPrint('🔎 : $params ❗️');
        },
      );
    },
  );
}
