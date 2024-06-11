import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:json_annotation/json_annotation.dart';

enum StationeryStatus {
  init,
  getStationeryInit,
  getStationerySuccess,
  getStationeryError,
}