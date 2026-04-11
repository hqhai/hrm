import 'package:flutter/material.dart';
import 'package:base_app/presentations/widgets/custom/app_loading_indicator.dart';

progressIndicatorDialog(BuildContext context) async {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return const AlertDialog(
        backgroundColor: Colors.white,
        content: SizedBox(
          height: 140,
          width: 140,
          child: Center(child: AppLoadingIndicator(size: 100)),
        ),
      );
    },
  );
}

class ProgressIndicatorDialog extends StatelessWidget {
  const ProgressIndicatorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppLoadingIndicator(size: 80),
      ],
    );
  }
}

dialogIndicator({required BuildContext context}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return const Dialog(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        child: Center(child: AppLoadingIndicator(size: 100)),
      );
    },
  );
}
