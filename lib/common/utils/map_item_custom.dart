import 'dart:core';
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

