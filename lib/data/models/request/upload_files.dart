import 'dart:io';

import 'package:flutter/foundation.dart';

class UploadFilesRequest {
  final List<File>? originFiles;
  final List<Uint8List>? imageDatas;

  const UploadFilesRequest({required this.originFiles, required this.imageDatas});
}