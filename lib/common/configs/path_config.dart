class PathConfig {
  static String login = '/auth/login';
  static String signup = '/auth/sign-up';
  static String register = '/auth/register';
  static String userInfo = '/user/get-user-profile';
  static String getUsersByRole = '/user/get-users-by-role';
  static String changePassword = '/user/change-password';
  static String getRequests = '/request/search-by-user';
  static String file = '/file';
  static String files = '/file/multiple';
  static String getRequestByAdmin = '/request/get-list-request-had-type';
  static String changeListStatus = '/request/change-list-status';
  static String roomMeeting = '/room-meeting';
  static String createRequestTypeRoomMeeting = '/room-meeting/create-request-type-room-meeting';
  static String updateStatusTypeRoomMeeting = '/room-meeting/update-status-type-room-meeting';
  static String getListUserByRequestExplanation = '/user/get-list-user-by-request-type-explanation';
  static String department = '/admin/department';
  static String departments = '/admin/department/get-departments';
  static String getDepartmentById = '/department/get-department';
  static String position = '/position';
  static String checkInSetting = '/checkin-setting';
  static String forgotPassword = '/user/forgot-password';
  static String registerSystem = '/auth/register-system-user';
  static String note = '/system-user-calender';
  static String deleteAccount = '/user/delete-system-user';
  static String location = '/location';

  ///Attendance
  static String getUserAttendance = '/attendance/get-user-attendances';
  static String getAttendance = '/attendance/get-attendances';

  ///user
  static String getUserIds = '/user/get-user-ids';
  static String updateProfile = '/user/update-profile-user';
  static String searchUser = '/admin/user/search-user';

  ///request
  static String flow = '/admin/flow';
  static String getFlowByUser = '/flow/get-flow-by-user';
  static String requestSearch = '/request/search';
  static String request = '/request';
  static String requestInId = '/request/get-request';
  static String stationery = '/stationery';
  static String getRequestSelf = '/request/get-request-self';
  static String getRequestApprove = '/request/get-request-approve';
  static String getRequestFollower = '/request/get-request-follower';
  static String stepRequestApprover = '/step-request-approver';
  static String stepRequestApproverCountStatus = '/step-request-approver/count-status';
  static String changeStatus = '/request/change-status';
  static String editRequestEdit = '/request/edit-request-edit';
  static String cancelRequest = '/request/cancel-request';

  ///CheckIn CheckOut
  static String schools = '/school/get-schools';
  static String checkIn = '/check-in';

  ///leave
  static String scheduleSchool = '/schedule-school/schedule-school-by-user';
  static String userLeave = '/user-leave-history/user-total';
  static String userLeaveHistory = '/user-leave-history/get-user-leave-history';
  static String workShiftByDate = '/workshift-setting/workshift-setting-by-date';
  static String workShiftExplanation = '/user-working-history/workshift-working-history';

  ///workDate
  static String getWorkShifts = '/workshift-request/get-workshift-requests';
  static String registerWorkShifts = '/workshift-request/create-workshift-request';
  static String cancelRegisterWorkShifts = '/workshift-request/update-status';
  static String workShiftApprove = '/workshift-approve';
  static String workshiftSettingGetElectiveShift = '/workshift-setting/get-elective-shift';
  static String workshiftRequest = '/workshift-request';
  static String workshiftSettingGetUser = '/workshift-setting/get-user';

  ///worksheet
  static String worksheet = '/worksheet/get-worksheet-by-user';
  static String requestByIds = '/request/get-request-by-ids';
  static String attendanceByDate = '/attendance/get-attendances-by-date';
  static String shiftById = '/admin/work-shift';
  static String getWorkShiftByUser = '/workshift-request/get-workshift-request-by-user';

  ///notification
  static String notification = '/notification-message';
}
