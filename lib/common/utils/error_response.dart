import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';

Map errorResponse() {
  final context = dI<AppNavigation>().navigatorKey.currentContext!;
  final appLocalizations = AppLocalizations.of(context)!;
  return {
    "NameNotNullOrEmpty": appLocalizations.nameNotNullOrEmpty,
    "StatusOtherActiveOrInActive": appLocalizations.statusOtherActiveOrInActive,
    "StepFlowNotNull": appLocalizations.stepFlowNotNull,
    "NameNull": appLocalizations.nameNull,
    "NameAlreadyExist": appLocalizations.nameAlreadyExist,
    "ThisDepartmentAlreadyExistFlow": appLocalizations.thisDepartmentAlreadyExistFlow,
    "ThisPositionAlreadyExistFlow": appLocalizations.thisPositionAlreadyExistFlow,
    "ThisDepartmentPositionAlreadyExistFlow":
        appLocalizations.thisDepartmentPositionAlreadyExistFlow,
    "ThisUserAlreadyExistFlow": appLocalizations.thisUserAlreadyExistFlow,
    "TypeAlreadyHasStepFlow": appLocalizations.typeAlreadyHasStepFlow,
    "ThisFlowAlreadyExistsRequest": appLocalizations.thisFlowAlreadyExistsRequest,
    "FlowNotExist": appLocalizations.flowNotExist,
    "FlowIsNotCoreType": appLocalizations.flowIsNotCoreType,
    "StatusInActiveUnableUpdate": appLocalizations.statusInActiveUnableUpdate,
    "UserIdNotNull": appLocalizations.userIdNotNull,
    "DepartmentIdOrPositionIdMustNotExist": appLocalizations.departmentIdOrPositionIdMustNotExist,
    "DepartmentIdAndPositionIdNotNull": appLocalizations.departmentIdAndPositionIdNotNull,
    "UserIdMustNotExist": appLocalizations.userIdMustNotExist,
    "PositionIdNotNull": appLocalizations.positionIdNotNull,
    "DepartmentIdOrUserIdMustNotExist": appLocalizations.departmentIdOrUserIdMustNotExist,
    "DepartmentIdNotNull": appLocalizations.departmentIdNotNull,
    "PositionIdOrUserIdMustNotExist": appLocalizations.positionIdOrUserIdMustNotExist,
    "InValidFormat": appLocalizations.inValidFormat,
    "ConfigNotNull": appLocalizations.configNotNull,
    "ExceededTheRequestedCreateTimeframe": appLocalizations.exceededTheRequestedCreateTimeframe,
    "CurrentStatusIsNotEdit": appLocalizations.currentStatusIsNotEdit,
    "CurrentStatusIsNotProcessOrEdit": appLocalizations.currentStatusIsNotProcessOrEdit,
    "EndDateGreaterThanStartDate": appLocalizations.endDateGreaterThanStartDate,
    "EmployeeNotFullTimeOrPartTime": appLocalizations.employeeNotFullTimeOrPartTime,
    "UserIdAndPositionIdCannotExistSameTime":
        appLocalizations.userIdAndPositionIdCannotExistSameTime,
    "UserIdOrPositionIdCanNotNull": appLocalizations.userIdOrPositionIdCanNotNull,
    "FlowDoesNotHaveEnoughComponents": appLocalizations.flowDoesNotHaveEnoughComponents,
    "IfStepTypeStartOrEndNoUserIdPositionIdDepartmentId":
        appLocalizations.ifStepTypeStartOrEndNoUserIdPositionIdDepartmentId,
    "CurrentStatusNotNew": appLocalizations.currentStatusNotNew,
    "NameStepFlowNotNull": appLocalizations.nameStepFlowNotNull,
    "DataNotNull": appLocalizations.dataNotNull,
    "MustCreateMinimumTimeInAdvance": appLocalizations.mustCreateMinimumTimeInAdvance,
    "pastTheDateOfExplanation": appLocalizations.pastTheDateOfExplanation,
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
    "TimeSlotAlreadyPleaseChooseAnother": appLocalizations.timeSlotAlreadyPleaseChooseAnother,
    "TheNumberOfFormsCreatedHasExceededTheLimit":
        appLocalizations.theNumberOfFormsCreatedHasExceededTheLimit,
    "DistanceNotEnough": "DistanceNotEnough",
    "UserNameNotExist": appLocalizations.userDoesNotExist,
    "TheTotalNumberOfLeaveIsNotEnough": appLocalizations.theTotalNumberOfLeaveIsNotEnough
  };
}

String? setErrorValue(String value, BuildContext context) {
  final appLocalizations = AppLocalizations.of(context)!;
  if (value.isNotEmpty) {
    final String? errorCode = errorResponse()[value];
    if (errorCode == null) {
      return appLocalizations.errorPlease;
    }
    return errorCode;
  }
  return null;
}
