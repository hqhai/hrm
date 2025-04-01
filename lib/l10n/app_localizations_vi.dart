import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get username => 'Tên đăng nhập';

  @override
  String get password => 'Mật khẩu';

  @override
  String get staySignedIn => 'Lưu đăng nhập';

  @override
  String get forgotPassword => 'Quên mật khẩu';

  @override
  String get login => 'Đăng nhập';

  @override
  String get notAMember => 'Chưa có tài khoản?  ';

  @override
  String get alreadyAMember => 'Đã có tài khoản?  ';

  @override
  String get signUpNow => 'Đăng ký ngay';

  @override
  String get logInNow => 'Đăng nhập ngay';

  @override
  String get whatIsYourEmail => 'Email của bạn';

  @override
  String get chooseAUsername => 'Chọn tên người dùng';

  @override
  String get chooseAPassword => 'Chọn mật khẩu';

  @override
  String get confirmPassword => 'Nhập lại mật khẩu';

  @override
  String get weak => 'Yếu';

  @override
  String get medium => 'Trung bình';

  @override
  String get good => 'Tốt';

  @override
  String get strong => 'Mạnh';

  @override
  String get statusRequest => 'Trạng thái';

  @override
  String get atLeastEightCharacters => 'Ít nhất 8 ký tự';

  @override
  String get containsANumber => 'Chứa chữ số';

  @override
  String get containsACapitalLetter => 'Chứa chữ in hoa';

  @override
  String get containsASymbol => 'Chứa ký tự đặc biệt';

  @override
  String get recentRequest => 'Yêu cầu gần đây';

  @override
  String get requestIsProcessing => 'Yêu cầu đang xử lý';

  @override
  String get requestProcessed => 'Yêu cầu đã xử lý';

  @override
  String get timeKeeping => 'Chấm công';

  @override
  String get changePassword => 'Đổi mật khẩu';

  @override
  String get managementRequests => 'Quản lý yêu cầu';

  @override
  String get managementRoom => 'Quản lý phòng họp';

  @override
  String get logout => 'Đăng xuất';

  @override
  String get title => 'Tiêu đề';

  @override
  String get content => 'Nội dung';

  @override
  String get selectFile => 'Thêm file';

  @override
  String get typeRequest => 'Kiểu yêu cầu';

  @override
  String get priority => 'Mức ưu tiên';

  @override
  String get approver => 'Duyệt';

  @override
  String get createOvertimeRequestIsSuccess => 'Tạo yêu cầu OT thành công';

  @override
  String get successfullyCreatedRequest => 'Yêu cầu được khởi tạo thành công';

  @override
  String get doYouWantToCreateARequest => 'Bạn có muốn khởi tạo yêu cầu?';

  @override
  String get doYouWantToDeleteTheRoom => 'Bạn có muốn xóa phòng không?';

  @override
  String get doYouWantToUpdateARequest => 'Bạn có muốn cập nhật yêu cầu?';

  @override
  String get doYouWantToUpdateANote => 'Bạn có muốn cập nhật ghi chú?';

  @override
  String get changePasswordSuccess => 'Đổi mật khẩu thành công!';

  @override
  String get doYouWantToChangeYourPassword => 'Bạn có muốn đổi mật khẩu?';

  @override
  String get leaveACommentHere => 'Viết nội dung tại đây';

  @override
  String get previouslyAvailableSchedules => 'Lịch trình có sẵn';

  @override
  String get thereAreCurrentlyNoMeetingsScheduled => 'Hiện tại chưa có cuộc họp nào được lên lịch';

  @override
  String get scheduleAMeeting => 'Lên lịch cho cuộc họp';

  @override
  String get update => 'Sửa';

  @override
  String get ok => 'Đồng ý';

  @override
  String get cancel => 'Hủy';

  @override
  String get create => 'Khởi tạo';

  @override
  String get startTime => 'Bắt đầu';

  @override
  String get endTime => 'Kết thúc';

  @override
  String startTimeH(Object a) {
    return 'Giờ bắt đầu$a';
  }

  @override
  String endTimeH(Object a) {
    return 'Giờ kết thúc$a';
  }

  @override
  String get startTimeD => 'Ngày bắt đầu';

  @override
  String get endTimeD => 'Ngày kết thúc';

  @override
  String get name => 'Tên';

  @override
  String get main => 'main';

  @override
  String get seats => 'Ghế';

  @override
  String get address => 'Địa chỉ';

  @override
  String get project => 'Project';

  @override
  String get task => 'Task';

  @override
  String get createTime => 'Thời gian tạo';

  @override
  String get type => 'Kiểu';

  @override
  String get creator => 'Người tạo';

  @override
  String get phoneNumber => 'Số điện thoại';

  @override
  String get note => 'Ghi chú';

  @override
  String get newPassword => 'Mật khẩu mới';

  @override
  String get currentPassword => 'Mật khẩu cũ';

  @override
  String get noteRoomLeader => 'Ghi chú của trưởng phòng';

  @override
  String get noteManager => 'Ghi chú của quản lý';

  @override
  String get explanation => 'Đơn xin sửa chấm công';

  @override
  String get startDay => 'Ngày bắt đầu';

  @override
  String get endDay => 'Ngày kết thúc';

  @override
  String get roomName => 'Tên phòng';

  @override
  String get numberOfSeats => 'Số chỗ ngồi';

  @override
  String get description => 'Thông tin thêm';

  @override
  String get isApproval => 'Cần phê duyệt';

  @override
  String get isNotApproval => 'Không cần phê duyệt';

  @override
  String get updateSuccessful => 'Cập nhật thông tin thành công!';

  @override
  String get save => 'Lưu';

  @override
  String get success => 'Thành công!';

  @override
  String get unsuccessful => 'Thất bại!';

  @override
  String get email => 'Email';

  @override
  String get search => 'Tìm kiếm';

  @override
  String get continues => 'Tiếp tục  ';

  @override
  String get add => 'Thêm';

  @override
  String get lateTime => 'Thời gian muộn';

  @override
  String get book => 'Đặt lịch';

  @override
  String get errorEmailOrPassword => 'Tên tài khoản hoặc mật khẩu không chính xác';

  @override
  String get endTimeMustBeAfterStartTime => 'Thời gian kết thúc phải sau thời gian bắt đầu!';

  @override
  String get bookingTimeMustBeAfterCurrentTime => 'Thời gian đặt phòng phải sau thời gian hiện tại!';

  @override
  String get today => 'Hôm nay';

  @override
  String get yesterday => 'Hôm qua';

  @override
  String get daysAgo => 'ngày trước';

  @override
  String get setRoom => 'Đặt phòng';

  @override
  String get projectAndTasksCannotBeLeftBlank => 'Project và task không thể để trống';

  @override
  String get noDataFound => 'Không tìm thấy dữ liệu!';

  @override
  String get oops => 'Ôi!';

  @override
  String get changeStatusRequestByManager => 'Bạn có muốn sửa đổi trạng thái các yêu cầu không?';

  @override
  String get doYouWantToCreateDepartment => 'Bạn có muốn tạo phòng ban mới không?';

  @override
  String get doYouWantToCreatePosition => 'Bạn có muốn tạo chức vụ mới không?';

  @override
  String get doYouWantToUpdateDepartment => 'Bạn có muốn chỉnh sửa thông tin phòng ban không?';

  @override
  String get doYouWantToUpdatePosition => 'Bạn có muốn chỉnh sửa thông tin chức vụ không?';

  @override
  String get code => 'Mã';

  @override
  String get createDepartment => 'khởi tạo phòng ban';

  @override
  String get createPosition => 'khởi tạo chức vụ';

  @override
  String get updateDepartment => 'Chỉnh sửa phòng ban';

  @override
  String get updatePosition => 'Chỉnh sửa chức vụ';

  @override
  String get parent => 'Công ty mẹ';

  @override
  String get department => 'Phòng ban';

  @override
  String get position => 'Chức vụ';

  @override
  String get personnel => 'Nhân sự';

  @override
  String get createPersonnel => 'Khởi tạo thông tin nhân sự';

  @override
  String get updatePersonnel => 'Chỉnh sửa thông tin nhân sự';

  @override
  String get createCheckInSetting => 'Khởi tạo thông tin giờ làm việc';

  @override
  String get updateCheckInSetting => 'Chỉnh sửa thông tin giờ làm việc';

  @override
  String get doYouWantToCreatePersonnel => 'Bạn có muốn tạo nhân sự mới không?';

  @override
  String get doYouWantToUpdatePersonnel => 'Bạn có muốn chỉnh sửa thông tin nhân sự không?';

  @override
  String get doYouWantToCreateCheckInSetting => 'Bạn có muốn tạo khung giờ làm việc mới không?';

  @override
  String get startDate => 'Ngày bắt đầu làm việc';

  @override
  String get attendanceId => 'Mã chấm công';

  @override
  String get morningStartTime => 'Giờ bắt đầu làm ca sáng';

  @override
  String get morningEndTime => 'Giờ kết thúc ca sáng';

  @override
  String get afternoonStartTime => 'Giờ bắt đầu ca chiều';

  @override
  String get afternoonEndTime => 'Giờ kết thúc ca chiều';

  @override
  String get firstName => 'Tên';

  @override
  String get lastName => 'Họ';

  @override
  String get addWorkTime => 'Thêm giờ làm việc';

  @override
  String get removeWorkTime => 'Hủy giờ làm việc';

  @override
  String get workingTime => 'Thời gian làm việc';

  @override
  String get pleaseEnterTheEmailYouWantToRetrieveYourPassword => 'Vui lòng nhập email bạn muốn lấy lại mật khẩu!';

  @override
  String get newPasswordHasJustBeenSentToEmail => 'Mật khẩu mới vừa được gửi tới email';

  @override
  String get pleaseCheckYourEmail => 'Vui lòng kiểm tra email của bạn.';

  @override
  String get calendar => 'Lịch';

  @override
  String get register => 'Đăng ký';

  @override
  String get activate => 'Hoạt Động';

  @override
  String get home => 'Trang chủ';

  @override
  String get profile => 'Hồ sơ';

  @override
  String get reviewDate => 'Ngày review';

  @override
  String get enterYourRegisteredUsernameAndPassword => 'Nhập tên đăng nhập và mật khẩu đã đăng ký tài khoản';

  @override
  String get supportContact => 'Liên hệ hỗ trợ';

  @override
  String get theContentAndTitleCannotBeLeftBlank => 'Nội dung và tiêu đề không được để trống';

  @override
  String get theNoteDateCannotBeBeforeThePresentTime => 'Ngày ghi chú không được trước thời điểm hiện tại';

  @override
  String get youMadeANoteOnTheDate => 'Bạn đã ghi chú vào ngày';

  @override
  String get requiredDataFields => 'Các trường dữ liệu là bắt buộc';

  @override
  String get delete => 'Xóa';

  @override
  String get doYouWantToDeleteTheNote => 'Bạn có muốn xóa ghi chú không?';

  @override
  String get doYouWantToDeleteYourAccount => 'Bạn có muốn xóa tài khoản này không?';

  @override
  String get deleteAccount => 'Xóa tài khoản';

  @override
  String get userInformation => 'Hồ sơ người dùng';

  @override
  String get employeeCode => 'Mã nhân viên';

  @override
  String get personalEmail => 'Email cá nhân';

  @override
  String get companyEmail => 'Email công ty';

  @override
  String get gender => 'Giới tính';

  @override
  String get dateOfBirth => 'Ngày sinh';

  @override
  String get branch => 'Chi nhánh';

  @override
  String get editPersonalInformation => 'Sửa thông tin cá nhân';

  @override
  String get setting => 'Cài đặt';

  @override
  String get account => 'Tài khoản';

  @override
  String get currentPasswordIsIncorrect => 'Mật khẩu hiện tại không đúng!';

  @override
  String get province => 'Tỉnh';

  @override
  String get district => 'Huyện';

  @override
  String get ward => 'Phường';

  @override
  String get doYouWantToUpdateProfile => 'Bạn có muốn chỉnh sửa thông tin cá nhân không?';

  @override
  String get checkInOut => 'Check-in/out';

  @override
  String get viewAttendanceHistory => 'Xem lịch sử chấm công';

  @override
  String get noData => 'Không có dữ liệu';

  @override
  String get administrativeTime => 'Giờ hành chính';

  @override
  String get formOfTimekeeping => 'Hình thức châm công';

  @override
  String get checkIn => 'Chấm công vào';

  @override
  String get checkOut => 'Chấm công ra';

  @override
  String get history => 'Lịch sử';

  @override
  String get timeWorking => 'Ca làm việc';

  @override
  String get date => 'Ngày';

  @override
  String get dialogWrongPasswordA => 'Bạn đã nhập sai thông tin đăng nhập 5 lần. Tài khoản của bạn đã bị tạm khóa. Vui lòng liên hệ HCNS';

  @override
  String get dialogWrongPasswordB => 'để đặt lại mật khẩu';

  @override
  String get newPasswordOtherConfirmPassword => 'Mật khẩu mới khác mật khẩu xác nhận!';

  @override
  String get notRegisteredForBiometrics => 'Vui lòng đăng nhập ứng dụng để kích hoạt đăng nhập bằng sinh trắc học';

  @override
  String get pleaseEnterYourUsernameAndPasswordHere => 'Nhập tên đăng nhập và mật khẩu tại đây';

  @override
  String get youWantToSaveTheAboveAccountForBiometrics => 'Bạn muôn lưu tài khoản này cho đăng nhập sinh trắc học?';

  @override
  String get yourBiometricAccountIsIncorrect => 'Tài khoản sinh trắc học của bạn không chính xác';

  @override
  String get youPressYourFingerHere => 'Ấn ngón tay của bạn vào đây';

  @override
  String get touchTheIconToTimeClock => 'Chạm tay vào icon để chấm công';

  @override
  String get timekeepingImmediately => 'Chấm công ngay';

  @override
  String get complete => 'Hoàn thành';

  @override
  String get locationServicesAreDisabled => 'Chức năng định vị bị vô hiệu hóa';

  @override
  String get locationPermissionsAreDenied => 'Quyền truy cập bị từ chối';

  @override
  String get locationPermissionsArePermanentlyDenied => 'Quyền truy cập bị từ chối, chúng tôi không thể yêu cầu được quyền truy cập định vị';

  @override
  String get validateToolLocation => 'Xác thực vị trí chấm công';

  @override
  String get step => 'Bước';

  @override
  String get singleWordList => 'Danh sách đơn từ';

  @override
  String get createANewSingleWord => 'Tạo mới đơn từ';

  @override
  String get deadline => 'Thời hạn';

  @override
  String get all => 'Tất cả';

  @override
  String get pending => 'Chờ duyệt đăng ký ca';

  @override
  String get reject => 'Từ chối';

  @override
  String get modification => 'Y/c sửa lại';

  @override
  String get done => 'Đã duyệt';

  @override
  String get filter => 'Bộ lọc';

  @override
  String get time => 'Thời gian';

  @override
  String get status => 'Trạng thái';

  @override
  String get apply => 'Áp dụng';

  @override
  String get expiredEdit => 'Quá hạn sửa';

  @override
  String get expired => 'Quá hạn';

  @override
  String get leave => 'Đơn xin nghỉ';

  @override
  String get overtime => 'Đơn xin làm thêm giờ';

  @override
  String get overtimeCreate => 'Tạo đơn xin làm thêm giờ';

  @override
  String get vehicleDispatch => 'Đơn đề nghị điều xe';

  @override
  String get vehicleDispatchCreate => 'Đơn đề nghị điều xe';

  @override
  String get postalDelivery => 'Đơn đề nghị chuyển phát bưu điện';

  @override
  String get releaseOfWarehouse => 'Đơn đề nghị xuất kho';

  @override
  String get releaseOfWarehouseCreate => 'Đơn đề nghị xuất kho';

  @override
  String get stationeryOrder => 'Đơn đặt văn phòng phẩm';

  @override
  String get stationeryOrderCreate => 'Tạo đơn đặt văn phòng phẩm';

  @override
  String get business => 'Đơn đề nghị công tác';

  @override
  String get businessCreate => 'Tạo đơn đề nghị công tác';

  @override
  String get male => 'Nam';

  @override
  String get female => 'Nữ';

  @override
  String get other => 'Khác';

  @override
  String get primarySchool => 'Tiểu học';

  @override
  String get secondarySchool => 'Trung học';

  @override
  String get highSchool => 'Cao trung';

  @override
  String get vocationalSchool => 'Trường nghề';

  @override
  String get college => 'Cao đẳng';

  @override
  String get university => 'Đại học';

  @override
  String get masterDegree => 'Thạc sĩ';

  @override
  String get doctorate => 'Tiến sĩ';

  @override
  String get working => 'Đang làm việc';

  @override
  String get resignation => 'Từ chức';

  @override
  String get aboutToStart => 'Sắp bắt đầu';

  @override
  String get longTermUnpaidLeave => 'Nghỉ phép dài hạn không lương';

  @override
  String get yourRequisition => 'Đơn từ của bạn';

  @override
  String get requisitionYouApproval => 'Đơn từ bạn phê duyệt';

  @override
  String get requisitionYouFollow => 'Đơn từ bạn theo dõi';

  @override
  String get applicationCode => 'Mã đơn';

  @override
  String get senderInformation => 'Thông tin người gửi';

  @override
  String get fullName => 'Họ và tên';

  @override
  String get generalInformation => 'Thông tin chung';

  @override
  String get contentOfApplication => 'Nội dung đơn';

  @override
  String get follower => 'Người theo dõi';

  @override
  String get totalDays => 'Tổng số ngày';

  @override
  String get accompanyingPerson => 'Người đi cùng';

  @override
  String get vehicle => 'Phương tiện';

  @override
  String get destination => 'Nơi đến';

  @override
  String get workingContent => 'Nội dung công tác';

  @override
  String get attach => 'Tệp đính kèm';

  @override
  String get workApplicationForm => 'Mẫu đơn từ';

  @override
  String get drivingTime => 'Thời gian điều xe';

  @override
  String get drive => 'Tài xế';

  @override
  String get carCaller => 'Người điều xe';

  @override
  String get walker => 'Người đi xe';

  @override
  String get schedule => 'Lịch trình';

  @override
  String get reasonForDriving => 'Lý do điều xe';

  @override
  String get shippingPurpose => 'Mục đích gửi';

  @override
  String get reason => 'Lý do';

  @override
  String get reasonCreate => 'Lý do tạo đơn';

  @override
  String get reasonForExplanation => 'Lý do giải trình';

  @override
  String get detailedDescription => 'Mô tả chi tiết';

  @override
  String get totalMinute => 'Số phút';

  @override
  String get leaveEarly => 'Xin về sớm';

  @override
  String get late => 'Xin đến muộn';

  @override
  String get leaveCorrection => 'Xin sửa đơn nghỉ';

  @override
  String get editTimekeeping => 'Xin sửa chấm công';

  @override
  String get replaceDay => 'Ngày làm bù';

  @override
  String get attachedFiles => 'Đính kèm';

  @override
  String get check => 'Kiểm tra';

  @override
  String get timeHasBeenRequestedInAdvance => 'Đã tồn tại đơn trùng thời gian đang chọn, vui lòng chọn lại';

  @override
  String get workDay => 'Ngày công';

  @override
  String get annualLeave => 'Phép năm';

  @override
  String get sickLeave => 'Nghỉ bệnh';

  @override
  String get intervalOnLeave => 'Thời gian nghỉ';

  @override
  String get substitute => 'Người giải quyết công việc thay trong thời gian nghỉ';

  @override
  String get pdf => 'PDF';

  @override
  String get detailedReason => 'Lý do chi tiết';

  @override
  String get otherPaidLeave => 'Nghỉ hưởng lương khác';

  @override
  String get leaveWithoutPay => 'Nghỉ không lương';

  @override
  String get permissionBiometric => 'Bạn chưa cấp quyền xác thực sinh trắc học cho ứng dụng, vui lòng cấp quyền!';

  @override
  String get transferType => 'Loại chuyển phát';

  @override
  String get often => 'Thường';

  @override
  String get superSpeed => 'Siêu tốc';

  @override
  String get sendingPurpose => 'Mục đích gửi';

  @override
  String get explain => 'Diễn giải';

  @override
  String get unitPrice => 'Đơn giá(chưa VAT)';

  @override
  String get numberOf => 'Số lượng';

  @override
  String get intoMoney => 'Thành tiền';

  @override
  String get moreOfficeProducts => 'Thêm văn phòng phẩm';

  @override
  String get unit => 'Đơn vị tính';

  @override
  String get pieces => 'Chiếc';

  @override
  String get rolls => 'Cuộn';

  @override
  String get boxes => 'Hộp';

  @override
  String get jars => 'Lọ';

  @override
  String get books => 'Quyển';

  @override
  String get reams => 'Ram';

  @override
  String get volumes => 'Tập';

  @override
  String get bags => 'Túi';

  @override
  String get blisters => 'Vỉ';

  @override
  String get pairs => 'Đôi';

  @override
  String get stationeryList => 'Danh sách sản phẩm';

  @override
  String get product => 'Sản phẩm';

  @override
  String get addProducts => 'Thêm sản phẩm';

  @override
  String get car => 'Ô tô';

  @override
  String get bike => 'Xe đạp';

  @override
  String get motorbike => 'Xe máy';

  @override
  String get tram => 'Xe điện';

  @override
  String get vehicleType => 'Loại phương tiện';

  @override
  String get licensePlate => 'Biển số xe';

  @override
  String get autoMaker => 'Hãng sản xuất';

  @override
  String get refuse => 'Từ chối';

  @override
  String get process => 'Chờ duyệt';

  @override
  String get edit => 'Yêu cầu chỉnh sửa';

  @override
  String get overdueEdit => 'Quá hạn chỉnh sửa';

  @override
  String get overdueApprove => 'Quá hạn phê duyệt';

  @override
  String get newStatus => 'Mới';

  @override
  String get standard => 'Giao hàng tiêu chuẩn';

  @override
  String get express => 'Giao hàng nhanh';

  @override
  String get sameDay => 'Giao hàng trong ngày';

  @override
  String get overnight => 'Giao hàng qua đêm';

  @override
  String get twoDay => 'Giao hàng trong hai ngày';

  @override
  String get economy => 'Giao hàng tiết kiệm';

  @override
  String get rush => 'Giao hàng hỏa tốc';

  @override
  String get scheduled => 'Giao hàng theo lịch hẹn';

  @override
  String get core => 'Core';

  @override
  String get noBrowsingFlowYet => 'Chưa có luồng duyệt';

  @override
  String get cannotBeLeftBlank => 'Không được để trống';

  @override
  String get thereAreCurrentlyNoProducts => 'Hiện tại không có sản phẩm nào';

  @override
  String get removeFilter => 'Xóa bộ lọc';

  @override
  String get paymentAfterTax => 'Thanh toán sau thuế';

  @override
  String get intoMoneyNoVAT => 'Thành tiền chưa VAT';

  @override
  String get yearlyAndSeniorityLeave => 'Nghỉ phép năm & Thâm niên';

  @override
  String get otherLeave => 'Nghỉ phép khác';

  @override
  String get horizontalCalendar => 'Lịch ngang';

  @override
  String get verticalCalendar => 'Lịch dọc';

  @override
  String get unpaidLeave => 'Nghỉ không hưởng lương công ty';

  @override
  String get theStartTimeMustBeAfterTheCurrentTime => 'Thời gian bắt đầu phải sau thời gian hiện tại';

  @override
  String get month => 'tháng';

  @override
  String get quantityCannotBeZero => 'Số lượng không được bằng 0';

  @override
  String get duplicateEmail => 'Email bị trùng';

  @override
  String get invalidParentId => 'Id đối tượng không hợp lệ';

  @override
  String get itemNotExists => 'Đối tượng không tồn tại';

  @override
  String get dataInUse => 'Dữ liệu đang được sử dụng';

  @override
  String get duplicateCode => 'Mã bị trùng';

  @override
  String get startDateAfterEndDate => 'Ngày bắt đầu sau ngày kết thúc';

  @override
  String get idsEmpty => 'Ids rỗng';

  @override
  String get userDoesNotExist => 'Người dùng không tồn tại';

  @override
  String get emailInUse => 'Email đang được sử dụng';

  @override
  String get companyEmailInUse => 'Email công ty đang được sử dụng';

  @override
  String get phoneNumberInUse => 'Số điện thoại đang được sử dụng';

  @override
  String get userCreationFailed => 'Tạo người dùng thất bại';

  @override
  String get differentRoleUserSystem => 'Hệ thống người dùng role khác';

  @override
  String get userNameInUse => 'Tên đăng nhập đang được sử dụng';

  @override
  String get userNameCannotBeEmpty => 'Tên đăng nhập không được rỗng';

  @override
  String get userNameNotFound => 'Tên đăng nhập không tồn tại';

  @override
  String get bothEmailsEmpty => 'Cả email cá nhân và email công ty đều rỗng';

  @override
  String get duplicatePassportNumber => 'Số hộ chiếu bị trùng';

  @override
  String get duplicateCitizenID => 'Số CMND/CCCD bị trùng';

  @override
  String get emailCannotBeEmpty => 'Email không được rỗng';

  @override
  String get onlyOneFulltimeInDepartment => 'Chỉ có thể có một nhân viên toàn thời gian trong một phòng ban';

  @override
  String get parttimeToFulltimeOnly => 'Chỉ có thể chuyển từ bán thời gian sang toàn thời gian';

  @override
  String get duplicateLicensePlate => 'Biển số xe bị trùng';

  @override
  String get duplicateTaxNumber => 'Mã số thuế bị trùng';

  @override
  String get duplicateBankAccountNumber => 'Số tài khoản ngân hàng bị trùng';

  @override
  String get listOvertime => 'Danh sách giờ tăng ca';

  @override
  String get totalTime => 'Tổng thời gian';

  @override
  String get yearlyLeave => 'Phép năm';

  @override
  String get seniorityLeave => 'Thâm niên';

  @override
  String get compensatoryLeave => 'Nghỉ bù';

  @override
  String get weddingLeave => 'Nghỉ cưới';

  @override
  String get mourningLeave => 'Nghỉ tang';

  @override
  String get homeSickLeave => 'Nghỉ ốm tại nhà';

  @override
  String get hospitalSickLeave => 'Nghỉ ốm vào viện';

  @override
  String get maternityLeave => 'Nghỉ thai sản';

  @override
  String get revoke => 'Hủy đơn';

  @override
  String get leaveNumberUsed => 'Số NP được nghỉ tối đa';

  @override
  String get leaveNumberPermission => 'Số NP đã nghỉ';

  @override
  String get leaveNumberRemaining => 'Số NP còn lại';

  @override
  String get leaveNumberUsedH => 'Số giờ được nghỉ tối đa';

  @override
  String get leaveNumberPermissionH => 'Số giờ đã nghỉ';

  @override
  String get leaveNumberRemainingH => 'Số giờ còn lại';

  @override
  String get youEarly => 'Về sớm';

  @override
  String get youLater => 'Đi muộn';

  @override
  String get timeKeepingList => 'Danh sách thời gian';

  @override
  String get listTime => 'Danh sách thời gian';

  @override
  String get workOffset => 'Làm bù';

  @override
  String get reasonForRelease => 'Lý do xin xuất kho';

  @override
  String get reasonForBusinessTrip => 'Lý do đi công tác';

  @override
  String get no => 'Không';

  @override
  String get yes => 'Có';

  @override
  String get leaveManagement => 'Quản lý phép';

  @override
  String get registerShift => 'Đăng ký lịch làm việc';

  @override
  String get listSchools => 'Danh sách trường';

  @override
  String get overTimeLeave => 'Nghỉ bù OT';

  @override
  String get leaveList => 'Danh sách phép';

  @override
  String get leaveUseHistory => 'Lịch sử dùng phép';

  @override
  String get total => 'Tổng';

  @override
  String get used => 'Đã dùng';

  @override
  String get remaining => 'Còn lại';

  @override
  String get day => 'Ngày';

  @override
  String get hour => 'Giờ';

  @override
  String get addition => 'Cộng';

  @override
  String get subtraction => 'Trừ';

  @override
  String get totalLeaveOfChanges => 'Tổng số phép thay đổi';

  @override
  String get actionName => 'Tên hành động';

  @override
  String get totalRemainingLeaveDays => 'Tổng số phép còn lại';

  @override
  String get vacationPeriod => 'Tời gian xin nghỉ';

  @override
  String get seeRequest => 'Xem đơn từ';

  @override
  String get sourceOfLeave => 'Nguồn phép';

  @override
  String get doYouWantRevokeYourRequest => 'Bạn có chắc chắn muốn hủy đơn?';

  @override
  String get start => 'Bắt đầu';

  @override
  String get end => 'Kết thúc';

  @override
  String get flow => 'Luồng duyệt';

  @override
  String get trackFlowProgres => 'Tiến trình duyệt';

  @override
  String get youDoNotHaveAShiftToday => 'Bạn không có lịch đi trường vào ngày hôm nay!';

  @override
  String get worksheet => 'Bảng công';

  @override
  String get actualWork => 'Công thực tế';

  @override
  String get leaveWork => 'Công nghỉ phép';

  @override
  String get holidayWork => 'Công nghỉ lễ';

  @override
  String get salaryWork => 'Công tính lương';

  @override
  String get noSalaryWork => 'Công không lương';

  @override
  String get workTime => 'Số giờ làm việc';

  @override
  String get timeEarly => 'Thời gian về sớm';

  @override
  String get timeLate => 'Thời gian đi muộn';

  @override
  String get realWork => 'Công chuẩn';

  @override
  String get seeDetails => 'Xem chi tiết';

  @override
  String get onTime => 'Chấm công đúng giờ';

  @override
  String get forgotChecking => 'Quên chấm công';

  @override
  String get offWork => 'Không có ca làm';

  @override
  String get isRequest => 'Có đơn từ';

  @override
  String get holiday => 'Nghỉ lễ';

  @override
  String get noAttendance => 'Không yêu cầu chấm công';

  @override
  String get offSet => 'Làm bù';

  @override
  String get timeWork => 'Số giờ làm việc';

  @override
  String get detailWork => 'Công chi tiết';

  @override
  String get summary => 'Công tổng hợp';

  @override
  String get year => 'năm';

  @override
  String get request => 'Đơn từ';

  @override
  String get shift => 'Ca công';

  @override
  String get workInDay => 'Công ghi nhận trong ngày';

  @override
  String get minutesToLate => 'Số phút đi muộn';

  @override
  String get minutesToEarly => 'Số phút về sớm';

  @override
  String get totalOTHours => 'Tổng số giờ làm thêm';

  @override
  String get typeOfShift => 'Loại ca làm việc';

  @override
  String get oTCoefficient => 'Hệ số OT';

  @override
  String get dateType => 'Loại ngày';

  @override
  String get ot => 'Làm thêm giờ';

  @override
  String get totalLeaveWork => 'Số công nghỉ';

  @override
  String get noShiftsWork => 'Không có ca làm việc';

  @override
  String get regularDay => 'Ngày thường';

  @override
  String get timeFrameOT => 'Khung giờ làm thêm';

  @override
  String get timeFrame => 'khung giờ';

  @override
  String get numberOfLate => 'Số lần về sớm';

  @override
  String get numberOfEarly => 'Số lần đi muộn';

  @override
  String get workOT => ' Số giờ tăng ca';

  @override
  String get historyTimekeeping => 'Lịch sử chấm công';

  @override
  String get totalTimeWork => 'Tổng số giờ làm việc';

  @override
  String get totalTimeWorkCompensatory => 'Tổng thời gian làm bù';

  @override
  String get titleBusiness => 'Thời gian đi công tác';

  @override
  String get timeStart => 'Thời gian đi';

  @override
  String get timeEnd => 'Thời gian về';

  @override
  String get socialInsuranceLeave => 'BHXH chi trả';

  @override
  String get lateOrEarly => 'Đi muộn/Về sớm';

  @override
  String get lateOrEarlyCreate => 'Tạo đơn đăng ký đi muộn/Về sớm';

  @override
  String get timekeepingError => 'Chấm công lỗi';

  @override
  String get monday => 'Thứ hai';

  @override
  String get tuesday => 'Thứ ba';

  @override
  String get wednesday => 'Thứ tư';

  @override
  String get thursday => 'Thứ năm';

  @override
  String get friday => 'Thứ sáu';

  @override
  String get saturday => 'Thứ bảy';

  @override
  String get sunday => 'Chủ nhật';

  @override
  String get calendarWork => 'Lịch làm việc';

  @override
  String get shiftManagement => 'Quản lý ca làm việc cá nhân';

  @override
  String get week => 'Tuần';

  @override
  String get pendingCancel => 'Chờ duyệt hủy ca';

  @override
  String get remove => 'Bị gỡ khỏi ca';

  @override
  String get usable => 'Khả dụng';

  @override
  String get unusable => 'Không khả dụng';

  @override
  String get administrativeShift => 'Ca hành chính';

  @override
  String get singleShift => 'Ca đơn';

  @override
  String get unregistered => 'Chưa đăng ký';

  @override
  String get cancelShiftRegistration => 'Hủy đăng ký ca';

  @override
  String get cancelShiftReceiveRegistration => 'Hủy đăng ký nhận ca';

  @override
  String get cancelShiftCancellationRequest => 'Hủy đăng ký nhận ca';

  @override
  String get registerForShifts => 'Đăng ký ca';

  @override
  String get invalid => 'Không hợp lệ';

  @override
  String get fingerprint => 'Vân tay';

  @override
  String get gPS => 'GPS';

  @override
  String get wrongPassword => 'Sai mật khẩu';

  @override
  String get none => 'Không';

  @override
  String get reasonForCancelingRequest => 'Lý do hủy yêu cầu';

  @override
  String get loading => 'Vui lòng chờ...';

  @override
  String get halfDayToOneDay => 'Đơn xin nghỉ 0,5-1 ngày';

  @override
  String get twoDayToFourDay => 'Đơn xin nghỉ 2-4 ngày';

  @override
  String get fiveDaysOrMore => 'Đơn xin nghỉ 5 ngày trở lên';

  @override
  String get halfDayToOneDayCreate => 'Tạo đơn xin nghỉ 0,5-1 ngày';

  @override
  String get twoDayToFourDayCreate => 'Tạo đơn xin nghỉ 2-4 ngày';

  @override
  String get fiveDaysOrMoreCreate => 'Tạo đơn xin nghỉ 5 ngày trở lên';

  @override
  String get earlyLate => 'Đơn xin đi muộn/ về sớm';

  @override
  String get vehicleF => 'Đơn đề nghị điều xe';

  @override
  String get businessF => 'Đơn đề nghị đi công tác';

  @override
  String get releaseOfWarehouseF => 'Đơn đề nghị xuất kho';

  @override
  String get stationery => 'Đơn đặt văn phòng phẩm';

  @override
  String get explanationF => 'Đơn sửa chấm công';

  @override
  String get oT => 'Đơn đề xuất làm thêm giờ';

  @override
  String get requestType => 'Loại đơn từ';

  @override
  String get chooseARequest => 'Chọn loại đơn từ';

  @override
  String nameSchool(Object a) {
    return 'Trường học$a';
  }

  @override
  String nameClass(Object a) {
    return 'Lớp$a';
  }

  @override
  String nameTeacher(Object a) {
    return 'Giáo viên$a';
  }

  @override
  String get timekeepingTime => 'Thời gian chấm công';

  @override
  String get map => 'Bản đồ';

  @override
  String get timekeepingSuccess => 'Chấm công thành công';

  @override
  String get timekeepingUnSuccess => 'Chấm công không thành công';

  @override
  String get chooseWorkShift => 'Chọn ca làm việc';

  @override
  String get ifOto => 'Nếu đi bằng ô tô, họ tên của tài xế';

  @override
  String get totalOvertimeHours => 'Tổng số giờ làm thêm';

  @override
  String get required => 'Bắt buộc';

  @override
  String get personalReasons => 'Cá nhân';

  @override
  String get companyReasons => 'Công việc';

  @override
  String get firstShift => 'Ca đầu';

  @override
  String get lastShift => 'Ca cuối';

  @override
  String get totalWork => 'Số công';

  @override
  String get createRequestFailed => 'Tạo đơn không thành công';

  @override
  String get editRequestUnsuccessful => 'Sửa đơn không thành công';

  @override
  String get createSuccess => 'Tạo đơn thành công';

  @override
  String get editRequestSuccess => 'Sửa đơn thành công';

  @override
  String get theTotalNumberOfLeaveIsNotEnough => 'Bạn đã dùng hết số phép của mình rồi!';

  @override
  String get approvedSuccess => 'Phê duyệt thành công';

  @override
  String get approvedUnsuccessful => 'Phê duyệt thất bại';

  @override
  String get cancelRequest => 'Hủy đơn';

  @override
  String get leaveReason => 'Lý do nghỉ';

  @override
  String get reasonType => 'Loại lý do';

  @override
  String get updateUnsuccessful => 'Cập nhật thông tin không thành công!';

  @override
  String get postal => 'Chuyển phát';

  @override
  String get mon => 'T2';

  @override
  String get tue => 'T3';

  @override
  String get wed => 'T4';

  @override
  String get thu => 'T5';

  @override
  String get fri => 'T6';

  @override
  String get sat => 'T7';

  @override
  String get sun => 'CN';

  @override
  String get numberTotalWork => 'Tổng số công';

  @override
  String get gPSAndFingerprint => 'Hình thức chấm công: GPS & Vân tay';

  @override
  String get noTimekeeping => 'Hình thức chấm công: Không chấm công';

  @override
  String get reasonCreateRequest => 'Lý do tạo đơn';

  @override
  String get descriptionR => 'Mô tả';

  @override
  String get caseL => 'Trường hợp';

  @override
  String get revokeRequestSuccess => 'Hủy đơn thành công';

  @override
  String get revokeRequestUnsuccessful => 'Hủy đơn không thành công';

  @override
  String get notSelectedAShift => 'Bạn chưa chọn ca làm';

  @override
  String get notSelectedAOverTime => 'Bạn chưa chọn giờ tăng ca';

  @override
  String get selectTypeLeave => 'Loại nghỉ';

  @override
  String get selectLeave => 'Nguồn phép';

  @override
  String get destinationOT => 'Địa điểm làm thêm giờ';

  @override
  String get inCompany => 'Trong công ty';

  @override
  String get outCompany => 'Ngoài công ty';

  @override
  String get makeUpWork => 'Đơn đăng ký làm bù';

  @override
  String get createMakeUpWork => 'Tạo đơn làm bù';

  @override
  String get reasonMakeUpWork => 'Lý do làm bù';

  @override
  String get leaveDate => 'Ngày đã nghỉ';

  @override
  String get makeUpWorkDate => 'Ngày làm bù';

  @override
  String get totalMakeUpWorkTime => 'Số giờ làm bù';

  @override
  String get youDoNotHaveAShift => 'Bạn không có ca làm việc vào ngày đã chọn!';

  @override
  String get shiftWasLeave => 'Ca đã nghỉ';

  @override
  String get realCheckIn => 'Giờ Check-in thực tế';

  @override
  String get realCheckOut => 'Giờ Check-out thực tế';

  @override
  String get settingBiometric => 'Cài đặt Touch Id/Face Id';

  @override
  String get cancelBiometricSuccessful => 'Hủy đăng nhập bằng FaceId thành công';

  @override
  String get settingBiometricSuccessful => 'Cài đặt đăng nhập bằng FaceId thành công';

  @override
  String get authAccount => 'Xác thực tài khoản';

  @override
  String get offDay => 'Ngày nghỉ';

  @override
  String get oTSalary => 'Hệ số OT tính lương';

  @override
  String get oTMakeUpLeave => 'Hệ số OT nghỉ bù';

  @override
  String get oTSalaryH => 'Số giờ OT tính lương';

  @override
  String get oTMakeUpLeaveH => 'Số giờ OT nghỉ bù';

  @override
  String get makeUpTime => 'Thời gian làm bù';

  @override
  String get nameNotNullOrEmpty => ' Tên không được để trống';

  @override
  String get statusOtherActiveOrInActive => ' Trạng thái khác hoạt động hoặc không hoạt động';

  @override
  String get stepFlowNotNull => ' Bước duyệt không được bỏ trống';

  @override
  String get nameNull => ' Tên trống';

  @override
  String get nameAlreadyExist => ' Tên đã tồn tại';

  @override
  String get thisDepartmentAlreadyExistFlow => ' Phòng ban đã tồn tại luồng của loại đơn từ này';

  @override
  String get thisPositionAlreadyExistFlow => ' Chức vụ đã tồn tại luồng của loại đơn từ này';

  @override
  String get thisDepartmentPositionAlreadyExistFlow => ' Phòng ban và chức vụ đã tồn luồng của loại tại đơn từ này';

  @override
  String get thisUserAlreadyExistFlow => ' Nhân viên đã tồn tại luồng của loại đơn từ này';

  @override
  String get typeAlreadyHasStepFlow => ' Đơn từ này đã tồn tại luồng duyệt';

  @override
  String get thisFlowAlreadyExistsRequest => ' Luồng này đã có đơn từ';

  @override
  String get flowNotExist => ' Luồng không tồn tại';

  @override
  String get flowIsNotCoreType => ' Luồng không phải loại luồng duyệt luồng';

  @override
  String get statusInActiveUnableUpdate => ' Trạng thái không hoạt động không thể cập nhật';

  @override
  String get userIdNotNull => ' Người áp dụng không được bỏ trống';

  @override
  String get departmentIdOrPositionIdMustNotExist => ' Phòng ban hoặc chức vụ không được tồn tại khi loại là nhân viên';

  @override
  String get departmentIdAndPositionIdNotNull => ' Phòng ban hoặc chức vụ không được bỏ trống';

  @override
  String get userIdMustNotExist => ' Nhân viên không được tồn tại khi loại là phòng ban chức vụ';

  @override
  String get positionIdNotNull => ' Chức vụ không được bỏ trống';

  @override
  String get departmentIdOrUserIdMustNotExist => ' Phòng ban và nhân viên không được tồn tại khi loại là chức vụ';

  @override
  String get departmentIdNotNull => ' Phòng ban không được bỏ trống';

  @override
  String get positionIdOrUserIdMustNotExist => ' Chức vụ và nhân viên không được tồn tại khi loại là phòng ban';

  @override
  String get inValidFormat => ' Sai định dạng';

  @override
  String get configNotNull => ' Dữ liệu đơn từ không được để trống';

  @override
  String get exceededTheRequestedCreateTimeframe => ' Đã vượt quá thời gian được tạo yêu cầu';

  @override
  String get currentStatusIsNotEdit => ' Trạng thái hiện tại không phải là chỉnh sửa';

  @override
  String get currentStatusIsNotProcessOrEdit => ' Trạng thái hiện tại không phải là trong tiến trình hoặc chỉnh sửa';

  @override
  String get theNumberOfFormsCreatedHasExceededTheLimit => ' Số lượng đơn tư được tạo đã vượt quá giới hạn';

  @override
  String get endDateGreaterThanStartDate => ' Ngày kết thúc đang lớn hơn ngày bắt đầu';

  @override
  String get employeeNotFullTimeOrPartTime => ' Nhân viên không phải là chính thức hoặc nhân viên bán thời gian';

  @override
  String get userIdAndPositionIdCannotExistSameTime => ' Nhân viên và chức vụ không tồn tại cùng lúc';

  @override
  String get userIdOrPositionIdCanNotNull => ' Người dùng hoặc chức vụ không thể bỏ trống';

  @override
  String get flowDoesNotHaveEnoughComponents => ' Luồng phải đủ các thành phần bắt đầu, các bước, kết thúc';

  @override
  String get ifStepTypeStartOrEndNoUserIdPositionIdDepartmentId => ' Nếu là loạ bắt đầu hoặc kết thúc thì không có nhân viên, chức vụ và phòng ban';

  @override
  String get currentStatusNotNew => ' Trạng thái hiện tại không phải là mới';

  @override
  String get nameStepFlowNotNull => ' Tên bước duyệt không được để trống';

  @override
  String get dataNotNull => ' Dữ liệu không được bỏ trống';

  @override
  String get timeSlotAlreadyPleaseChooseAnother => ' Đã tồn tại đơn có cùng thời gian, vui lòng chọn lại thời gian';

  @override
  String get mustCreateMinimumTimeInAdvance => ' Phải tạo trước thời gian tối thiểu';

  @override
  String get pastTheDateOfExplanation => ' Quá ngày giải trình';

  @override
  String get errorTimeMakeUp1 => 'Tổng số giờ làm bù phải lớn hơn hoặc bằng số giờ làm việc đã nghỉ. Vui lòng điều chỉnh lại';

  @override
  String get errorTimeMakeUp2 => 'Thời gian làm bù đã trùng với ca làm việc khác. Vui lòng chọn lại';

  @override
  String get errorPlease => 'Đã có lỗi xảy ra , vui lòng thử lại sau!';

  @override
  String get limitFile => 'Số lượng tập tin vượt quá 5';

  @override
  String get saveRequest => 'Lưu đơn';

  @override
  String get createRequest => 'Tạo đơn';

  @override
  String get setHoursAndMinutes => 'Chọn thời gian';

  @override
  String get january => 'Tháng 1';

  @override
  String get february => 'Tháng 2';

  @override
  String get march => 'Tháng 3';

  @override
  String get april => 'Tháng 4';

  @override
  String get may => 'Tháng 5';

  @override
  String get june => 'Tháng 6';

  @override
  String get july => 'Tháng 7';

  @override
  String get august => 'Tháng 8';

  @override
  String get september => 'Tháng 9';

  @override
  String get october => 'Tháng 10';

  @override
  String get november => 'Tháng 11';

  @override
  String get december => 'Tháng 12';

  @override
  String get rejectSucceed => 'Từ chối đơn thành công';

  @override
  String get requestSucceed => 'Gửi yêu cầu sửa đơn thành công';

  @override
  String get cancelSucceed => 'Hủy đơn thành công';

  @override
  String get approveSucceed => 'Phê duyệt đơn thành công';

  @override
  String get rejectFailed => 'Từ chối đơn thất bại';

  @override
  String get requestFailed => 'Gửi yêu cầu sửa đơn thất bại';

  @override
  String get cancelFailed => 'Hủy đơn thất bại';

  @override
  String get approveFailed => 'Phê duyệt đơn thất bại';

  @override
  String get contentPopUpOpenGPS => 'Cho phép HRM truy cập vị trí của bạn';

  @override
  String get allow => 'Cho phép';

  @override
  String get contentDialogTimeKeepingUnSuccess => 'Chấm công không thành công';

  @override
  String get contentDialogTimeKeepingSuccess => 'Chấm công thành công';

  @override
  String get retry => 'Thử lại';

  @override
  String get rejectTitle => 'Bạn có chắc chắn muốn gỡ nhân viên này khỏi ca hiện tại?';

  @override
  String get rejectTitle1 => 'Bạn có chắc chắn muốn từ chối duyệt yêu cầu hủy ca của nhân viên này?';

  @override
  String get rejectTitle2 => 'Bạn có chắc chắn muốn từ chối duyệt yêu cầu đăng ký ca của nhân viên này?';

  @override
  String get proactiveCaseRegistrationManagement => 'Quản lý ca làm việc của nhân viên';

  @override
  String get receivedShift => 'Đã nhận ca';

  @override
  String get rejectShift => 'Ca bị từ chối duyệt';

  @override
  String get confirm => 'Xác nhận';

  @override
  String get waitingForApprovalToCancelShift => 'Chờ duyệt hủy ca';

  @override
  String get waitingForShiftRegistrationApproval => 'Chờ duyệt đăng ký ca';

  @override
  String get notRegisteredYet => 'Chưa đăng ký ca';

  @override
  String get dialogConfirmContent => 'Bạn có muốn phê duyệt ca làm việc này không ?';

  @override
  String get shiftOfDay => 'Ca làm việc hôm nay: ';

  @override
  String get moveToTheAppropriate => ' Vui lòng di chuyển đến vị trí hợp lệ trên bản đồ';

  @override
  String get chooseASchedule => 'Bạn cần chọn một lịch đi trường để chấm công.';

  @override
  String get noDataTimekeeping => 'Chưa có dữ liệu chấm công';

  @override
  String get notification => 'Thông báo';

  @override
  String get sent => 'Chưa đọc';

  @override
  String get read => 'Đã đọc';

  @override
  String get readAll => 'Đánh dấu tất cả là đã đọc';

  @override
  String get noNotification => 'Không có thông báo';

  @override
  String get shiftDetails => 'Chi tiết ca';

  @override
  String get shiftCode => 'Mã ca';

  @override
  String get shiftName => 'Tên ca làm việc';

  @override
  String get workingTime1 => 'Thời gian';

  @override
  String get recordedNumberOfShifts => 'Số công ghi nhận';

  @override
  String get operationDay => 'Ngày thao tác';

  @override
  String get validTimeKeeping => 'Chấm công hợp lệ';

  @override
  String get cancelShift1 => 'Hủy đăng ký ca';

  @override
  String get cancelShift2 => 'Hủy yêu cầu huỷ ca';

  @override
  String get shiftHistory => 'Lịch sử trạng thái ca:';

  @override
  String get noConnected => 'Có lỗi xảy ra, vui lòng kiểm tra lại!';

  @override
  String get reasonForCancellation => 'Lí do huỷ ca';

  @override
  String get shiftIsCancelled => 'Đã huỷ ca';

  @override
  String get skipLogin => 'Bỏ qua Đăng Nhập';

  @override
  String get cancelShiftSuccess => 'Gửi yêu cầu hủy ca thành công, Yêu cầu cần được xác nhận';

  @override
  String get cancelShiftSuccess1 => 'Hủy ca thành công';

  @override
  String get cancelCancelShiftSuccess => 'Hủy yêu cầu hủy ca thành công';

  @override
  String get registeredShiftSuccessfully => 'Đăng ký ca thành công, ca đang được chờ duyệt';

  @override
  String get remove2 => 'Gỡ khỏi ca';

  @override
  String get inputNameStaff => 'Nhập tên nhân viên';

  @override
  String get edit2 => 'Chưa chỉnh sửa đơn';

  @override
  String get errorNumber => 'Số lượng không được để trống';

  @override
  String get errNotData => 'Không có dữ liệu';

  @override
  String get filterByMonth => 'Lọc theo tháng';

  @override
  String get filterByDay => 'Lọc theo ngày';

  @override
  String get requestDeniedBy => 'Người từ chối duyệt đơn';

  @override
  String get requestCancelBy => 'Người hủy đơn';

  @override
  String get requestEditBy => 'Người YC sửa đơn';

  @override
  String get reasonReject => 'Lý do từ chối đơn:';

  @override
  String get reasonCancel => 'Lý do hủy đơn :';

  @override
  String get reasonForCanceling => 'Lí do hủy ca';

  @override
  String get reasonForRejection => 'Lý do bị từ chối duyệt';

  @override
  String get nameWorkShift => 'Tên ca làm việc';

  @override
  String get reasonForRemove => 'Lý do bị gỡ khỏi ca';

  @override
  String get mapLocation => 'Vị trí';

  @override
  String get reasonCannotBeLeftBlank => 'Lý do không được bỏ trống';

  @override
  String get reasonCancelShift => 'Lý do hủy ca';

  @override
  String get selectFilter => 'Chọn bộ lọc';

  @override
  String get loginBiometricAuthentication => 'Đăng nhập bằng sinh trắc học';

  @override
  String get useFaceIDInsteadOfAPassword => 'Sử dụng FaceID của bạn thay cho mật khẩu đăng nhập';

  @override
  String get approveShiftSuccessfully => 'Duyệt đăng ký ca thành công';

  @override
  String get refusedToRegisterASuccessfulShift => 'Từ chối đăng ký ca thành công';

  @override
  String get approveTheRequestToCancelTheShiftSuccessfully => 'Duyệt yêu cầu hủy ca làm thành công';

  @override
  String get rejectTheRequestToCancelTheShiftSuccessfully => 'Từ chối yêu cầu hủy ca làm thành công';

  @override
  String removeTheEmployeeShift(Object a) {
    return 'Bạn có chắc muốn gỡ nhân viên $a khỏi ca?';
  }

  @override
  String get removeEmployeeSuccessful => 'Gỡ nhân viên khỏi ca thanh công';

  @override
  String areYouSureCancelShift(Object a) {
    return 'Bạn có chắc chắn muốn hủy ca làm của nhân sự $a?';
  }

  @override
  String get quitLoggingInAccessUtilities => 'Bỏ qua đăng nhập, truy cập tiện ích';

  @override
  String get ifYouDoNotHaveAnAccountPleaseContactHCNS => 'Nếu bạn chưa có tài khoản, hãy liên hệ HCNS';

  @override
  String get enterReason => 'Nhập lý do...';

  @override
  String get forgotPasswordSuccess => 'Gửi mật khẩu thành công!';

  @override
  String get saveUpdateInfo => 'Lưu thông tin';

  @override
  String get i18nDays => 'ngày';

  @override
  String get i18nHours => 'giờ';

  @override
  String get i18nNotFullTimeOrPartTime => 'Bạn không thuộc diện nhân sự được phép đăng ký đơn';

  @override
  String get i18nCompensatoryLeave => 'Công nghỉ bù OT';

  @override
  String get i18nOTRate => 'Hệ số OT';

  @override
  String get i18nOTInformation => 'Thông tin OT';

  @override
  String get i18nOTInformationList => 'Danh sách thông tin OT';

  @override
  String get i18nRate => 'Hệ số';

  @override
  String get i18nTotalHour => 'Tổng số giờ';

  @override
  String get i18nReadMore => 'Xem thêm';

  @override
  String get i18nClose => 'Đóng';

  @override
  String get i18nTokenExpired => 'Phiên đăng nhập của bạn đã hết hạn. Vui lòng đăng nhập lại để tiếp tục.';

  @override
  String get i18nYouWantToApproveThisApplication => 'Bạn có chắc chắn phê duyệt đơn này?';

  @override
  String get i18nReportLastMonthIsWorkOnlyOnThe1stAnd2nd => 'Giải trình công của tháng trước đã hết hạn vào ngày 2 tháng này';

  @override
  String get i18nOnlyAllowedToEditWorkThisMonthOrLastMonth => 'Chỉ cho phép chỉnh sửa tháng này hoặc tháng trước.';

  @override
  String get editAttendance => 'sửa chấm công';

  @override
  String get youAreSelecting => 'Bạn đang chọn';
}
