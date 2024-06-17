import 'package:flutter/material.dart';

popDialog(BuildContext context) {
  Navigator.of(context).pop();
}

onClickOK(BuildContext context, VoidCallback callback) {
  callback.call();
  Navigator.of(context).pop();
}
