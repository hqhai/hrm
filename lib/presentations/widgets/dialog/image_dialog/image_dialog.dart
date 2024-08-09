import 'dart:io';

import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  const ImageDialog({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SpacingUnit.x50,
      width: SpacingUnit.x50,
      child: Image.network(
        url,
        fit: BoxFit.fill,
      ),
    );
  }
}

class ImageLocalDialog extends StatelessWidget {
  const ImageLocalDialog({super.key, required this.file});

  final File file;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SpacingUnit.x50,
      width: SpacingUnit.x50,
      child: Image.file(
        file,
        fit: BoxFit.fill,
        errorBuilder: (context, error, stackTrace) => Image.network(
          file.path,
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) => Image.asset(
            Assets.images.error.imageError.path,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
