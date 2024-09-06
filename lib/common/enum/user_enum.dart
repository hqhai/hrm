import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:json_annotation/json_annotation.dart';

enum GenderEnum {
  @JsonValue('Male')
  male('Male'),
  @JsonValue('Female')
  female('Female'),
  @JsonValue('Other')
  other('Other'),
  @JsonValue('')
  unknown('');

  final String name;

  const GenderEnum(this.name);
}

extension ConfigGenderExtension on GenderEnum {
  String get configGenderName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case GenderEnum.male:
        return appLocalizations.male;
      case GenderEnum.female:
        return appLocalizations.female;
      case GenderEnum.other:
        return appLocalizations.other;
      default:
        return '';
    }
  }
}

enum EducationLevelEnum {
  @JsonValue('PrimarySchool')
  primarySchool('PrimarySchool'),
  @JsonValue('SecondarySchool')
  secondarySchool('SecondarySchool'),
  @JsonValue('HighSchool')
  highSchool('HighSchool'),
  @JsonValue('VocationalSchool')
  vocationalSchool('VocationalSchool'),
  @JsonValue('College')
  college('College'),
  @JsonValue('University')
  university('University'),
  @JsonValue('MasterDegree')
  masterDegree('MasterDegree'),
  @JsonValue('Doctorate')
  doctorate('Doctorate'),
  @JsonValue('Other')
  other('Other'),
  @JsonValue('')
  unknown('');

  final String name;

  const EducationLevelEnum(this.name);
}

extension ConfigEducationLevelExtension on EducationLevelEnum {
  String get configEducationLevelName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case EducationLevelEnum.primarySchool:
        return appLocalizations.primarySchool;
      case EducationLevelEnum.secondarySchool:
        return appLocalizations.secondarySchool;
      case EducationLevelEnum.highSchool:
        return appLocalizations.highSchool;
      case EducationLevelEnum.vocationalSchool:
        return appLocalizations.vocationalSchool;
      case EducationLevelEnum.college:
        return appLocalizations.college;
      case EducationLevelEnum.university:
        return appLocalizations.university;
      case EducationLevelEnum.masterDegree:
        return appLocalizations.masterDegree;
      case EducationLevelEnum.doctorate:
        return appLocalizations.doctorate;
      case EducationLevelEnum.other:
        return appLocalizations.other;
      default:
        return '';
    }
  }
}

enum WorkingStatusEnum {
  @JsonValue('Working')
  working('Working'),
  @JsonValue('Resignation')
  resignation('Resignation'),
  @JsonValue('MaternityLeave')
  maternityLeave('MaternityLeave'),
  @JsonValue('AboutToStart')
  aboutToStart('AboutToStart'),
  @JsonValue('LongTermUnpaidLeave')
  longTermUnpaidLeave('LongTermUnpaidLeave'),
  @JsonValue('')
  unknown('');

  final String name;

  const WorkingStatusEnum(this.name);
}

extension ConfigWorkingStatusExtension on WorkingStatusEnum {
  String get configWorkingStatusName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case WorkingStatusEnum.working:
        return appLocalizations.working;
      case WorkingStatusEnum.resignation:
        return appLocalizations.resignation;
      case WorkingStatusEnum.maternityLeave:
        return appLocalizations.maternityLeave;
      case WorkingStatusEnum.aboutToStart:
        return appLocalizations.aboutToStart;
      case WorkingStatusEnum.longTermUnpaidLeave:
        return appLocalizations.longTermUnpaidLeave;
      default:
        return '';
    }
  }
}

enum ConfigRoleStringValues {
  generalManager('GeneralManager'),
  manager('Manager'),
  user('User'),
  userSystem('UserSystem'),
  @JsonValue('')
  unknown('');

  final String name;

  const ConfigRoleStringValues(this.name);
}

enum VehicleTypeEnum {
  @JsonValue('Car')
  car('Car'),
  @JsonValue('Bike')
  bike('Bike'),
  @JsonValue('Motorbike')
  motorbike('Motorbike'),
  @JsonValue('Tram')
  tram('Tram'),
  @JsonValue('')
  unknown('');

  final String name;

  const VehicleTypeEnum(this.name);
}

extension ConfigVehicleTypeExtension on VehicleTypeEnum {
  String get configVehicleTypeName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case VehicleTypeEnum.car:
        return appLocalizations.car;
      case VehicleTypeEnum.bike:
        return appLocalizations.bike;
      case VehicleTypeEnum.motorbike:
        return appLocalizations.motorbike;
      case VehicleTypeEnum.tram:
        return appLocalizations.tram;
      default:
        return '';
    }
  }
}
