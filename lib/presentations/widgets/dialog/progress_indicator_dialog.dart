import 'package:flutter/material.dart';

progressIndicatorDialog(BuildContext context) async {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return const AlertDialog(
        content: SizedBox(
          height: 100,
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      );
    },
  );
}