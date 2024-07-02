class PathConfig {
  static String login = '/auth/login';
  static String signup = '/auth/sign-up';
  static String register = '/auth/register';
  static String userInfo = '/user/get-user-profile';
  static String getUsersByRole = '/user/get-users-by-role';
  static String getUserAttendance = '/attendance/get-user-attendances';
  static String getAttendance = '/attendance/get-attendances';
  static String getTimeKeepingByEmail = '/attendance/get-attendances';
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
  static String checkInSetting ='/checkin-setting';
  static String forgotPassword ='/user/forgot-password';
  static String registerSystem = '/auth/register-system-user';
  static String note = '/system-user-calender';
  static String deleteAccount = '/user/delete-system-user';
  static String location = '/location';
  //user
  static String getUserIds = '/user/get-user-ids';
  static String updateProfile = '/user/update-profile-user';
  static String searchUser = '/admin/user/search-user';
  //request
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
  static String changeStatus = '/request/change-status';
  static String editRequestEdit = '/request/edit-request-edit';

}
