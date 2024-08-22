import 'package:flutter/material.dart';

class ErrorUtils {
  static String getErrorMessage(String errorCode,
      {required BuildContext context}) {
    final appLocalizations = Localizations.localeOf(context).toString();
    if (appLocalizations == 'vi') {
      return errorVi[errorCode] ?? 'Đã có lỗi xảy ra , vui lòng thử lại sau!';
    }
    return errorEn[errorCode] ?? 'An error occurred, please try again later!';
  }
}

const errorVi = {
  "NameNotNullOrEmpty": " Tên không được để trống",
  "StatusOtherActiveOrInActive":
      " Trạng thái khác hoạt động hoặc không hoạt động",
  "StepFlowNotNull": " Bước duyệt không được bỏ trống",
  "NameNull": " Tên trống",
  "NameAlreadyExist": " Tên đã tồn tại",
  "ThisDepartmentAlreadyExistFlow":
      " Phòng ban đã tồn tại luồng của loại đơn từ này",
  "ThisPositionAlreadyExistFlow":
      " Chức vụ đã tồn tại luồng của loại đơn từ này",
  "ThisDepartmentPositionAlreadyExistFlow":
      " Phòng ban và chức vụ đã tồn luồng của loại tại đơn từ này",
  "ThisUserAlreadyExistFlow": " Nhân viên đã tồn tại luồng của loại đơn từ này",
  "TypeAlreadyHasStepFlow": " Đơn từ này đã tồn tại luồng duyệt",
  "ThisFlowAlreadyExistsRequest": " Luồng này đã có đơn từ",
  "FlowNotExist": " Luồng không tồn tại",
  "FlowIsNotCoreType": " Luồng không phải loại luồng duyệt luồng",
  "StatusInActiveUnableUpdate":
      " Trạng thái không hoạt động không thể cập nhật",
  "UserIdNotNull": " Người áp dụng không được bỏ trống",
  "DepartmentIdOrPositionIdMustNotExist":
      " Phòng ban hoặc chức vụ không được tồn tại khi loại là nhân viên",
  "DepartmentIdAndPositionIdNotNull":
      " Phòng ban hoặc chức vụ không được bỏ trống",
  "UserIdMustNotExist":
      " Nhân viên không được tồn tại khi loại là phòng ban chức vụ",
  "PositionIdNotNull": " Chức vụ không được bỏ trống",
  "DepartmentIdOrUserIdMustNotExist":
      " Phòng ban và nhân viên không được tồn tại khi loại là chức vụ",
  "DepartmentIdNotNull": " Phòng ban không được bỏ trống",
  "PositionIdOrUserIdMustNotExist":
      " Chức vụ và nhân viên không được tồn tại khi loại là phòng ban",
  "InValidFormat": " Sai định dạng",
  "ConfigNotNull": " Dữ liệu đơn từ không được để trống",
  "ExceededTheRequestedCreateTimeframe":
      " Đã vượt quá thời gian được tạo yêu cầu",
  "CurrentStatusIsNotEdit": " Trạng thái hiện tại không phải là chỉnh sửa",
  "CurrentStatusIsNotProcessOrEdit":
      " Trạng thái hiện tại không phải là trong tiến trình hoặc chỉnh sửa",
  "TheNumberOfFormsCreatedHasExceededTheLimit":
      " Số lượng đơn tư được tạo đã vượt quá giới hạn",
  "EndDateGreaterThanStartDate": " Ngày kết thúc đang lớn hơn ngày bắt đầu",
  "EmployeeNotFullTimeOrPartTime":
      " Nhân viên không phải là chính thức hoặc nhân viên bán thời gian",
  "UserIdAndPositionIdCannotExistSameTime":
      " Nhân viên và chức vụ không tồn tại cùng lúc",
  "UserIdOrPositionIdCanNotNull": " Người dùng hoặc chức vụ không thể bỏ trống",
  "FlowDoesNotHaveEnoughComponents":
      " Luồng phải đủ các thành phần bắt đầu, các bước, kết thúc",
  "IfStepTypeStartOrEndNoUserIdPositionIdDepartmentId":
      " Nếu là loạ bắt đầu hoặc kết thúc thì không có nhân viên, chức vụ và phòng ban",
  "CurrentStatusNotNew": " Trạng thái hiện tại không phải là mới",
  "NameStepFlowNotNull": " Tên bước duyệt không được để trống",
  "DataNotNull": " Dữ liệu không được bỏ trống",
  "TimeSlotAlreadyPleaseChooseAnother":
      " Đã tồn tại đơn có cùng thời gian, vui lòng chọn lại thời gian",
  "MustCreateMinimumTimeInAdvance": " Phải tạo trước thời gian tối thiểu",
  "PastTheDateOfExplanation": " Quá ngày giải trình",
};

const errorEn = {
  "NameNotNullOrEmpty": " Name must not be empty",
  "StatusOtherActiveOrInActive": " Status must be either Active or Inactive",
  "StepFlowNotNull": " Approval step must not be empty",
  "NameNull": " Name is empty",
  "NameAlreadyExist": " Name already exists",
  "ThisDepartmentAlreadyExistFlow":
      " Department already has a flow for this type of request",
  "ThisPositionAlreadyExistFlow":
      " Position already has a flow for this type of request",
  "ThisDepartmentPositionAlreadyExistFlow":
      " Department and position already have a flow for this type of request",
  "ThisUserAlreadyExistFlow":
      " Employee already has a flow for this type of request",
  "TypeAlreadyHasStepFlow": " This request already has an approval flow",
  "ThisFlowAlreadyExistsRequest": " This flow already has a request",
  "FlowNotExist": " Flow does not exist",
  "FlowIsNotCoreType": " Flow type is not an approval flow",
  "StatusInActiveUnableUpdate": " Inactive status cannot be updated",
  "UserIdNotNull": " Applier must not be empty",
  "DepartmentIdOrPositionIdMustNotExist":
      " Department or position must not exist when the type is employee",
  "DepartmentIdAndPositionIdNotNull":
      " Department or position must not be empty",
  "UserIdMustNotExist":
      " Employee must not exist when the type is department or position",
  "PositionIdNotNull": " Position must not be empty",
  "DepartmentIdOrUserIdMustNotExist":
      " Department and employee must not exist when the type is position",
  "DepartmentIdNotNull": " Department must not be empty",
  "PositionIdOrUserIdMustNotExist":
      " Position and employee must not exist when the type is department",
  "InValidFormat": " Invalid format",
  "ConfigNotNull": " Request data must not be empty",
  "ExceededTheRequestedCreateTimeframe":
      " Request creation time has exceeded the allowed limit",
  "CurrentStatusIsNotEdit": " Current status is not editable",
  "CurrentStatusIsNotProcessOrEdit":
      " Current status is neither in progress nor editable",
  "TheNumberOfFormsCreatedHasExceededTheLimit":
      " The number of requests created has exceeded the limit",
  "EndDateGreaterThanStartDate": " End date is greater than the start date",
  "EmployeeNotFullTimeOrPartTime":
      " Employee is neither full-time nor part-time",
  "UserIdAndPositionIdCannotExistSameTime":
      " Employee and position cannot coexist simultaneously",
  "UserIdOrPositionIdCanNotNull": " User or position must not be empty",
  "FlowDoesNotHaveEnoughComponents":
      " Flow must have start, steps, and end components",
  "IfStepTypeStartOrEndNoUserIdPositionIdDepartmentId":
      " If it is a start or end type, there should be no employee, position, or department",
  "CurrentStatusNotNew": " Current status is not new",
  "NameStepFlowNotNull": " Approval step name must not be empty",
  "DataNotNull": " Data must not be empty",
  "TimeSlotAlreadyPleaseChooseAnother":
      " A request already exists with the same time frame, please select a different time",
  "MustCreateMinimumTimeInAdvance": " Must be created before the minimum time",
  "PastTheDateOfExplanation": " Past the explanation date"
};
