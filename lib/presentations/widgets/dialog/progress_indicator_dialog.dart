import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

progressIndicatorDialog(BuildContext context) async {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        content: SizedBox(
          height: SpacingUnit.x50,
          width: SpacingUnit.x50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: SizedBox(
                  height: SpacingUnit.x50,
                  width: SpacingUnit.x50,
                  child: Lottie.asset(Assets.images.icon.loading,
                      width: SpacingUnit.x50, height: SpacingUnit.x50, fit: BoxFit.fill),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}