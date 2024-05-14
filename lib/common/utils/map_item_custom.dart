import 'dart:core';

import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

List<double> values = [0, 0.25, 0.5, 0.75, 1];

List<Color> colors = [
  Colors.red,
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
];

Color colorDropdownManager(String value) {
  if (value == StatusRequestStatus.pending.name) {
    return Colors.white;
  } else if (value == StatusRequestStatus.done.name) {
    return Colors.green;
  } else {
    return Colors.red;
  }
}

Color colorDropdownGeneralManager(String value) {
  if (value == StatusRequestStatus.pending.name) {
    return Colors.white;
  } else if (value == StatusRequestStatus.done.name) {
    return Colors.green;
  } else if (value == StatusRequestStatus.subsequentApproval.name) {
    return Colors.amber;
  } else {
    return Colors.red;
  }
}

List<String> levels(BuildContext context) {
  final appLocalizations = AppLocalizations.of(context)!;
  return [
    appLocalizations.weak,
    appLocalizations.weak,
    appLocalizations.medium,
    appLocalizations.good,
    appLocalizations.strong
  ];
}

