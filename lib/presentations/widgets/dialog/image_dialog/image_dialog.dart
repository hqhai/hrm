import 'package:base_app/common/utils/spacing_unit.dart';
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
