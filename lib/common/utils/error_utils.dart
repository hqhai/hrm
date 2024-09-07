import 'package:flutter/material.dart';

class ErrorUtils {
  static String getErrorMessage(String errorCode, {required BuildContext context}) {
    final appLocalizations = Localizations.localeOf(context).toString();
    if (appLocalizations == 'vi') {
      return errorVi[errorCode] ?? 'Đã có lỗi xảy ra , vui lòng thử lại sau!';
    }
    return errorEn[errorCode] ?? 'An error occurred, please try again later!';
  }
}

const errorVi = {
  "NameNotNullOrEmpty": " Tên không được để trống",
  "StatusOtherActiveOrInActive": " Trạng thái khác hoạt động hoặc không hoạt động",
  "StepFlowNotNull": " Bước duyệt không được bỏ trống",
  "NameNull": " Tên trống",
  "NameAlreadyExist": " Tên đã tồn tại",
  "ThisDepartmentAlreadyExistFlow": " Phòng ban đã tồn tại luồng của loại đơn từ này",
  "ThisPositionAlreadyExistFlow": " Chức vụ đã tồn tại luồng của loại đơn từ này",
  "ThisDepartmentPositionAlreadyExistFlow":
      " Phòng ban và chức vụ đã tồn luồng của loại tại đơn từ này",
  "ThisUserAlreadyExistFlow": " Nhân viên đã tồn tại luồng của loại đơn từ này",
  "TypeAlreadyHasStepFlow": " Đơn từ này đã tồn tại luồng duyệt",
  "ThisFlowAlreadyExistsRequest": " Luồng này đã có đơn từ",
  "FlowNotExist": " Luồng không tồn tại",
  "FlowIsNotCoreType": " Luồng không phải loại luồng duyệt luồng",
  "StatusInActiveUnableUpdate": " Trạng thái không hoạt động không thể cập nhật",
  "UserIdNotNull": " Người áp dụng không được bỏ trống",
  "DepartmentIdOrPositionIdMustNotExist":
      " Phòng ban hoặc chức vụ không được tồn tại khi loại là nhân viên",
  "DepartmentIdAndPositionIdNotNull": " Phòng ban hoặc chức vụ không được bỏ trống",
  "UserIdMustNotExist": " Nhân viên không được tồn tại khi loại là phòng ban chức vụ",
  "PositionIdNotNull": " Chức vụ không được bỏ trống",
  "DepartmentIdOrUserIdMustNotExist":
      " Phòng ban và nhân viên không được tồn tại khi loại là chức vụ",
  "DepartmentIdNotNull": " Phòng ban không được bỏ trống",
  "PositionIdOrUserIdMustNotExist":
      " Chức vụ và nhân viên không được tồn tại khi loại là phòng ban",
  "InValidFormat": " Sai định dạng",
  "ConfigNotNull": " Dữ liệu đơn từ không được để trống",
  "ExceededTheRequestedCreateTimeframe": " Đã vượt quá thời gian được tạo yêu cầu",
  "CurrentStatusIsNotEdit": " Trạng thái hiện tại không phải là chỉnh sửa",
  "CurrentStatusIsNotProcessOrEdit":
      " Trạng thái hiện tại không phải là trong tiến trình hoặc chỉnh sửa",
  "TheNumberOfFormsCreatedHasExceededTheLimit": " Số lượng đơn tư được tạo đã vượt quá giới hạn",
  "EndDateGreaterThanStartDate": " Ngày kết thúc đang lớn hơn ngày bắt đầu",
  "EmployeeNotFullTimeOrPartTime":
      " Nhân viên không phải là chính thức hoặc nhân viên bán thời gian",
  "UserIdAndPositionIdCannotExistSameTime": " Nhân viên và chức vụ không tồn tại cùng lúc",
  "UserIdOrPositionIdCanNotNull": " Người dùng hoặc chức vụ không thể bỏ trống",
  "FlowDoesNotHaveEnoughComponents": " Luồng phải đủ các thành phần bắt đầu, các bước, kết thúc",
  "IfStepTypeStartOrEndNoUserIdPositionIdDepartmentId":
      " Nếu là loạ bắt đầu hoặc kết thúc thì không có nhân viên, chức vụ và phòng ban",
  "CurrentStatusNotNew": " Trạng thái hiện tại không phải là mới",
  "NameStepFlowNotNull": " Tên bước duyệt không được để trống",
  "DataNotNull": " Dữ liệu không được bỏ trống",
  "TimeSlotAlreadyPleaseChooseAnother":
      " Đã tồn tại đơn có cùng thời gian, vui lòng chọn lại thời gian",
  "MustCreateMinimumTimeInAdvance": " Phải tạo trước thời gian tối thiểu",
  "PastTheDateOfExplanation": " Quá ngày giải trình",
  //28/8/2024----------------------------
  "NameStepRequestNotNull": "Tên của bước duyệt không được để trống",
  "NoteNotNull": "Lý do không được bỏ trống",
  "TheApplicableObjectMustNotBeEmpty": "Đối tượng áp dung không được để trống",
  "StartDateGreaterThanEndDate": "Ngày bắt đầu đang lớn hơn ngày kết thúc",
  "MustCreateMaximumTimeInAdvance": "Phải tạo trước thời gian tối đa",
  "RequestStatusNotApprove": "Trạng thái của đơn từ không phải đã phê duyệt",
  "TheUserDoesNotExistInStepOne": "Bạn không phải là bước duyệt đầu tiên",
  "YouHaveCanceledThisRequest": "Đơn từ này đã được bạn huỷ",
  "TheTotalNumberOfLeaveIsNotEnough": "Số ngày phép không đủ",
  "StartTimeGreaterThanEndTime": "Thời gian bắt đầu lớn hơn thời gian kết thúc",
  "RegisteredMakeupOrOvertime": "Khoảng thời gian này đã có đăng ký làm bù hoặc tăng ca",
  "ThisPeriodOverlapsWithTheWorkShift": "Khoảng thời gian này đang có ca làm việc",
  "MakeupDayCanNotRecedeRequestDate": "Ngày làm bù không nhỏ hơn ngày nghỉ",
  "OnlyAllowedToEditWorkThisMonthOrLastMonth": "Chỉ giải trình công tháng này hoặc tháng trước",
  "ReportLastMonthIsWorkOnlyOnThe1stAnd2nd":
      "Giải trình công của tháng trước đã hết hạn vào ngày 2 tháng này",
//-------------------------
  "DuplicateName": "Tên bị trùng ",
  "ParentIdCannotBeHimself": "Đối tượng trực thuộc không được là chính mình ",
  "ParentIdNotExits": "Đối tượng trực thuộc không tồn tại ",
  "DataHasBeenUsed": "Dữ liệu đã được sử dụng ",
  "CodeAlreadyExist": "Mã tồn tại ",
  "StartDateThanEndDate": "Ngày bắt đầu lớn hơn hơn ngày kết thúc ",
  "IdsNull": "Ids trống ",
  "UserNotExist": "Người dùng không tồn tại ",
  "EmailAlreadyExist": "Email đã tồn tại ",
  "CompanyEmailAlreadyExist": "Email công ty đã tồn tại ",
  "PhoneNumberAlreadyExist": "Số điện thoại đã tồn tại ",
  "UserFailToCreate": "Tạo mới người dùng thất bại ",
  "OtherRoleUserSystem": "Khác role user system ",
  "UserNameAlreadyExist": "Tên đăng nhập đã tồn tại ",
  "UserNameNotNull": "Tên đăng nhập không được để trống ",
  "UserNameNotExist": "Tên người dùng không tồn tại ",
  "EmailAndCompanyEmailNull": "Không có email cá nhân và email công ty ",
  "PassPortNumberAlreadyExist": "Số hộ chiếu đã tồn tại ",
  "CitizenIdentificationCardNumberAlreadyExist": "Số CCCD đã tồn tại ",
  "EmailNotNull ": "Email không được rỗng ",
  "OnlyFulltimeInOneDepartmentAndPosition ":
      "Chỉ được phép tồn tại 1 fulltime trong 1 chức vụ và phòng ban ",
  "ParttimeOnlyUpdateToFullTimeCantAdd ":
      "Người này chỉ có thể update thêm fulltime không thể thêm fulltime ",
  "LisencePlateAlreadyExist ": "Biển số xe đã tồn tại ",
  "TaxAlreadyExist ": "Mã số thuế đã tồn tại ",
  "BankAccountNumberAlreadyExist": "Số tài khoản ngân hàng đã tồn tại",
  //---------------------
  "ServerError": "Server bị lỗi",
  "ExportFaile ": "Lỗi xuất file ",
  "Required ": "Có trường bắt buộc ",
  "MaxLength ": "Trường có độ dài quá mức cho phép ",
  "Min ": "Trường có độ dài quá ngắn ",
  "DataNotExist ": "Dữ liệu không tồn tại ",
  "DataAlreadyExist ": "Dữ liệu đã tồn tại ",
  "ImportFileRequired ": "Yêu cầu phải truyền tệp vào ",
  //----------------------------------9/6/2024
  "WorkShiftTimeThanTimeMakeUpWorkTime": "Thời gian làm bù nhỏ hơn thời gian ca",
  "CheckInGreaterThanCheckOut": "Check In lớn hơn Check Out",

  "TypeOvertimeDayIsNotInCorrectFormat": "Ngày tăng ca không đúng định dạng ",
  "SaturdayOverlappingTime": "Thời gian trùng lặp vào thứ Bảy ",
  "MaxPaidHoursNotNull": "Số giờ trả lương tối đa không được để trống ",
  "MaxPaidHoursNotThanMaxHours": "Số giờ trả lương tối đa không được quá số giờ tối đa ",
  "NameNotNull": "Tên không được bỏ trống ",
  "DataHasBeenGenerated": "Dữ liệu đã được tạo ",
  "TheTimeCannotBeLessThanTheCurrentTime": "Thời gian đang nhỏ hơn thời gian hiện tại ",
  "StatusWorkShiftApproveNotPending": "Trạng thái cần phê duyệt không phải đang chờ xử lý ",
  "WorkDateIsPastTheCurrentDate": "Ngày làm việc đã qua ngày hiện tại ",
  "StartTimeValidGreaterThanEndTimeValid":
      "Thời gian bắt đầu hợp lệ lớn hơn thời gian kết thúc hợp lệ ",
  "CheckInTimeValidGreaterThanCheckOutTimeValid":
      "Thời gian checkin hợp lệ lớn hơn thời gian checkout tính hợp lệ ",
  "TheNumberOfWorkMustNotBeLessThanOrEqualToZero":
      "Số lượng công việc không được nhỏ hơn hoặc bằng 0 ",
  "OnlyOneOfTwoWorkDayOrWorkDateExists":
      "Chỉ một trong hai trường 'Ngày làm việc' hoặc Lịch làm việc tồn tại. ",
  "WorkDateAlreadyExist": "Ngày đã tồn tại ",
  "InOneWorkDayThereIsOnlyOneWorkShiftId": "Trong một ngày làm việc, chỉ có một mã ca làm việc. ",
  "ThereAreWorkShiftsThatOverlapInTimeWithinTheSameWorkday":
      "Có những ca làm việc trùng lặp về thời gian trong cùng một ngày làm việc ",
  "ShiftsThatHaveBeenAppliedCannotBeEditTheWorkDate":
      "Các ca làm việc đã được áp dụng không thể chỉnh sửa ngày làm việc.",
  "ShiftThatHasBeenAppliedCannotEditTheStartdate":
      "Ca làm việc đã được áp dụng không thể chỉnh sửa ngày bắt đầu. ",
  "ThereAreWorkShiftsThatOverlapInTimeWithinTheSameWorkShift":
      "Có các ca làm việc trùng lặp về thời gian trong cùng một ca làm việc. ",
  "CheckingStartTimeValidGreaterThanChecking":
      "Thời gian bắt đầu kiểm tra phải lớn hơn thời gian kiểm tra. ",
  "CheckingGreaterThanCheckingEndTimeValid":
      "Thời gian kiểm tra phải lớn hơn thời gian kết thúc kiểm tra. ",
  "ValidRegistTimeAndValidRegistTimeTypeMustBothBeSet":
      "Thời gian đăng ký hợp lệ và loại thời gian đăng ký hợp lệ phải được đặt cả hai. ",
  "ValidCancelTimeAndValidCancelTimeTypeMustBothBeSet":
      "Thời gian hủy hợp lệ và loại thời gian hủy hợp lệ phải được đặt cả hai. ",
  "SingleCaseCanNotHaveMoreThanOneDetailCase":
      "Một trường hợp không thể có nhiều hơn một trường hợp chi tiết. ",
  "RegistedNotRequiredCantRegist": "Đã đăng ký không yêu cầu nên không thể đăng ký. ",
  "InvalidTimeToRegist": "Thời gian để đăng ký không hợp lệ. ",
  "InvalidTimeToCancel": "Thời gian để hủy không hợp lệ. ",
  "NoHaveWorkShiftToRegist": "Không có ca làm việc để đăng ký. ",
  "WorkShiftSettingDetailInvalid": "Chi tiết cài đặt ca làm việc không hợp lệ. ",
};

const errorEn = {
  "NameNotNullOrEmpty": " Name must not be empty",
  "StatusOtherActiveOrInActive": " Status must be either Active or Inactive",
  "StepFlowNotNull": " Approval step must not be empty",
  "NameNull": " Name is empty",
  "NameAlreadyExist": " Name already exists",
  "ThisDepartmentAlreadyExistFlow": " Department already has a flow for this type of request",
  "ThisPositionAlreadyExistFlow": " Position already has a flow for this type of request",
  "ThisDepartmentPositionAlreadyExistFlow":
      " Department and position already have a flow for this type of request",
  "ThisUserAlreadyExistFlow": " Employee already has a flow for this type of request",
  "TypeAlreadyHasStepFlow": " This request already has an approval flow",
  "ThisFlowAlreadyExistsRequest": " This flow already has a request",
  "FlowNotExist": " Flow does not exist",
  "FlowIsNotCoreType": " Flow type is not an approval flow",
  "StatusInActiveUnableUpdate": " Inactive status cannot be updated",
  "UserIdNotNull": " Applier must not be empty",
  "DepartmentIdOrPositionIdMustNotExist":
      " Department or position must not exist when the type is employee",
  "DepartmentIdAndPositionIdNotNull": " Department or position must not be empty",
  "UserIdMustNotExist": " Employee must not exist when the type is department or position",
  "PositionIdNotNull": " Position must not be empty",
  "DepartmentIdOrUserIdMustNotExist":
      " Department and employee must not exist when the type is position",
  "DepartmentIdNotNull": " Department must not be empty",
  "PositionIdOrUserIdMustNotExist":
      " Position and employee must not exist when the type is department",
  "InValidFormat": " Invalid format",
  "ConfigNotNull": " Request data must not be empty",
  "ExceededTheRequestedCreateTimeframe": " Request creation time has exceeded the allowed limit",
  "CurrentStatusIsNotEdit": " Current status is not editable",
  "CurrentStatusIsNotProcessOrEdit": " Current status is neither in progress nor editable",
  "TheNumberOfFormsCreatedHasExceededTheLimit":
      " The number of requests created has exceeded the limit",
  "EndDateGreaterThanStartDate": " End date is greater than the start date",
  "EmployeeNotFullTimeOrPartTime": " Employee is neither full-time nor part-time",
  "UserIdAndPositionIdCannotExistSameTime": " Employee and position cannot coexist simultaneously",
  "UserIdOrPositionIdCanNotNull": " User or position must not be empty",
  "FlowDoesNotHaveEnoughComponents": " Flow must have start, steps, and end components",
  "IfStepTypeStartOrEndNoUserIdPositionIdDepartmentId":
      " If it is a start or end type, there should be no employee, position, or department",
  "CurrentStatusNotNew": " Current status is not new",
  "NameStepFlowNotNull": " Approval step name must not be empty",
  "DataNotNull": " Data must not be empty",
  "TimeSlotAlreadyPleaseChooseAnother":
      " A request already exists with the same time frame, please select a different time",
  "MustCreateMinimumTimeInAdvance": " Must be created before the minimum time",
  //28/8/2024-----------------------
  "PastTheDateOfExplanation": " Past the explanation date",
  "NameStepRequestNotNull": "Approval step name cannot be empty.",
  "NoteNotNull": "Reason cannot be empty.",
  "TheApplicableObjectMustNotBeEmpty": "Applicable object cannot be empty.",
  "StartDateGreaterThanEndDate": "Start date is later than the end date.",
  "MustCreateMaximumTimeInAdvance": "Must be created before the maximum time.",
  "RequestStatusNotApprove": "The request status is not approved.",
  "TheUserDoesNotExistInStepOne": "You are not the first approval step.",
  "YouHaveCanceledThisRequest": "This request has been canceled by you.",
  "TheTotalNumberOfLeaveIsNotEnough": "Insufficient leave days.",
  "StartTimeGreaterThanEndTime": "Start time is later than the end time.",
  "RegisteredMakeupOrOvertime":
      "This time period already has compensatory work or overtime registered.",
  "ThisPeriodOverlapsWithTheWorkShift": "There is a work shift during this time period.",
  "MakeupDayCanNotRecedeRequestDate": "Make-up work day cannot be earlier than the day off.",
  "OnlyAllowedToEditWorkThisMonthOrLastMonth":
      "Only attendance explanations for this month or last month are allowed.",
  "ReportLastMonthIsWorkOnlyOnThe1stAnd2nd":
      "The attendance explanation for last month expired on the 2nd of this month.",
  //-----------------------------
  "DuplicateName": "Name is duplicated ",
  "ParentIdCannotBeHimself": "Dependent entity cannot be itself ",
  "ParentIdNotExits": "Dependent entity does not exist ",
  "DataHasBeenUsed": "Data has been used ",
  "CodeAlreadyExist": "Code exists ",
  "StartDateThanEndDate": "Start date is greater than end date ",
  "IdsNull": "IDs are empty ",
  "UserNotExist": "User does not exist ",
  "EmailAlreadyExist": "Email already exists ",
  "CompanyEmailAlreadyExist": "Company email already exists ",
  "PhoneNumberAlreadyExist": "Phone number already exists ",
  "UserFailToCreate": "Failed to create new user ",
  "OtherRoleUserSystem": "Different system user role ",
  "UserNameAlreadyExist": "Username already exists ",
  "UserNameNotNull": "Username must not be empty ",
  "UserNameNotExist": "Username does not exist ",
  "EmailAndCompanyEmailNull": "No personal email and company email provided ",
  "PassPortNumberAlreadyExist": "Passport number already exists ",
  "CitizenIdentificationCardNumberAlreadyExist": "Citizen ID number already exists ",
  "EmailNotNull ": "Email must not be empty ",
  "OnlyFulltimeInOneDepartmentAndPosition ":
      "Only one full-time employee is allowed in one position and department ",
  "ParttimeOnlyUpdateToFullTimeCantAdd ":
      "This person can only update existing full-time, cannot add new full-time ",
  "LisencePlateAlreadyExist ": "License plate already exists ",
  "TaxAlreadyExist ": "Tax code already exists ",
  "BankAccountNumberAlreadyExist": "Bank account number already exists",
  //-----------------------------------
  "ServerError": "ServerError",
  "ExportFaile ": "File export error ",
  "Required ": "There is a required field ",
  "MaxLength ": "Field length exceeds the allowed limit ",
  "Min ": "Field length is too short ",
  "DataNotExist ": "Data does not exist ",
  "DataAlreadyExist ": "Data already exists ",
  "ImportFileRequired ": "File is required to be uploaded ",
  //-------------------------------9/6/2024
  "WorkShiftTimeThanTimeMakeUpWorkTime": "Work Shift Time Less Than Time Make Up Work Time",
  "CheckInGreaterThanCheckOut": "Check In Greater Than Check Out",

  "TypeOvertimeDayIsNotInCorrectFormat": "Type Overtime Day Is Not In Correct Format ",
  "SaturdayOverlappingTime": "Saturday Overlapping Time ",
  "MaxPaidHoursNotNull": "Max Paid Hours Not Null ",
  "MaxPaidHoursNotThanMaxHours": "Max Paid Hours Not Than Max Hours ",
  "NameNotNull": "Name Not Null ",
  "DataHasBeenGenerated": "Data Has Been Generated ",
  "TheTimeCannotBeLessThanTheCurrentTime": "The Time Cannot Be Less Than The Current Time ",
  "StatusWorkShiftApproveNotPending": "Status Work Shift Approve Not Pending ",
  "WorkDateIsPastTheCurrentDate": "Work Date Is Past The Current Date ",
  "StartTimeValidGreaterThanEndTimeValid": "Start Time Valid Greater Than End Time Valid ",
  "CheckInTimeValidGreaterThanCheckOutTimeValid":
      "Check In Time Valid Greater Than Check Out Time Valid ",
  "TheNumberOfWorkMustNotBeLessThanOrEqualToZero":
      "The Number Of Work Must Not Be Less Than Or Equal To Zero ",
  "OnlyOneOfTwoWorkDayOrWorkDateExists": "Only One Of Two Work Day Or Work Date Exists ",
  "WorkDateAlreadyExist": "Work Date Already Exist ",
  "InOneWorkDayThereIsOnlyOneWorkShiftId": "In One Work Day There Is Only One Work Shift Id ",
  "ThereAreWorkShiftsThatOverlapInTimeWithinTheSameWorkday":
      "There Are Work Shifts That Overlap In Time Within The Same Workday ",
  "ShiftsThatHaveBeenAppliedCannotBeEditTheWorkDate":
      "Shifts That Have Been Applied Cannot Be Edit The Work Date",
  "ShiftThatHasBeenAppliedCannotEditTheStartdate":
      "Shift That Has Been Applied Cannot Edit The Start Date ",
  "ThereAreWorkShiftsThatOverlapInTimeWithinTheSameWorkShift":
      "There Are Work Shifts That Overlap In Time Within The Same Work Shift ",
  "CheckingStartTimeValidGreaterThanChecking": "Checking Start Time Valid Greater Than Checking ",
  "CheckingGreaterThanCheckingEndTimeValid": "Checking Greater Than Checking End Time Valid ",
  "ValidRegistTimeAndValidRegistTimeTypeMustBothBeSet":
      "Valid Regist Time And Valid Regist Time Type Must Both Be Set ",
  "ValidCancelTimeAndValidCancelTimeTypeMustBothBeSet":
      "Valid Cancel Time And Valid Cancel Time Type Must Both Be Set ",
  "SingleCaseCanNotHaveMoreThanOneDetailCase":
      "Single Case Can Not Have More Than One Detail Case ",
  "RegistedNotRequiredCantRegist": "Registed Not Required Cant Regist ",
  "InvalidTimeToRegist": "Invalid Time To Regist ",
  "InvalidTimeToCancel": "Invalid Time To Cancel ",
  "NoHaveWorkShiftToRegist": "No Have Work Shift To Regist ",
  "WorkShiftSettingDetailInvalid": "Work Shift Setting Detail Invalid ",
};
