import 'package:flutter/material.dart';

popDialog(BuildContext context, {Function? onPress}) {
  Navigator.of(context).pop();
  if (onPress != null) {
    onPress.call();
  }
}

onClickOK(BuildContext context, VoidCallback callback) {
  callback.call();
  Navigator.of(context).pop();
}
