import 'dart:io';

import 'package:flutter/foundation.dart';

class UploadFileRequest {
  final File? originFile;
  final Uint8List? imageData;

  const UploadFileRequest({required this.originFile, required this.imageData});
}