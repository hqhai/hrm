import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';

Map errorResponse(BuildContext context){
  final appLocalizations = AppLocalizations.of(context)!;
  return {
    "DuplicateEmail": appLocalizations.duplicateEmail,
    "InvalidParentId": appLocalizations.invalidParentId,
    "ItemNotExists": appLocalizations.itemNotExists,
    "DataInUse": appLocalizations.dataInUse,
    "DuplicateCode": appLocalizations.duplicateCode,
    "StartDateAfterEndDate": appLocalizations.startDateAfterEndDate,
    "IdsEmpty": appLocalizations.idsEmpty,
    "UserDoesNotExist": appLocalizations.userDoesNotExist,
    "EmailInUse": appLocalizations.emailInUse,
    "CompanyEmailInUse": appLocalizations.companyEmailInUse,
    "PhoneNumberInUse": appLocalizations.phoneNumberInUse,
    "UserCreationFailed": appLocalizations.userCreationFailed,
    "DifferentRoleUserSystem": appLocalizations.differentRoleUserSystem,
    "UserNameInUse": appLocalizations.userNameInUse,
    "UserNameCannotBeEmpty": appLocalizations.userNameCannotBeEmpty,
    "UserNameNotFound": appLocalizations.userNameNotFound,
    "BothEmailsEmpty": appLocalizations.bothEmailsEmpty,
    "DuplicatePassportNumber": appLocalizations.duplicatePassportNumber,
    "DuplicateCitizenID": appLocalizations.duplicateCitizenID,
    "EmailCannotBeEmpty": appLocalizations.emailCannotBeEmpty,
    "OnlyOneFulltimeInDepartment": appLocalizations.onlyOneFulltimeInDepartment,
    "ParttimeToFulltimeOnly": appLocalizations.parttimeToFulltimeOnly,
    "DuplicateLicensePlate": appLocalizations.duplicateLicensePlate,
    "DuplicateTaxNumber": appLocalizations.duplicateTaxNumber,
    "DuplicateBankAccountNumber": appLocalizations.duplicateBankAccountNumber,
    "TimeSlotAlreadyPleaseChooseAnother": appLocalizations.timeSlotAlreadyPleaseChooseAnother
  };
}

String? setErrorValue(String value, BuildContext context) {
  if (value != '') {
    final String? errorCode = errorResponse(context)[value];
    if(errorCode == null){
      return null;
    }
    return errorCode;
  }
  return null;
}