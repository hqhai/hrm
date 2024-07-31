enum RequestStatus {
  init,
  start,
  success,
  fail,
}

enum UserStatus { init, start, success, fail, unauthorized, unknown }

enum AuthStatus {
  authInitial,
  loading,
  loggedIn,
  loggedOut,
  loginFail,
  unAuthentication,
  unauthorized
}

enum AttendanceStatus {
  init,
  getAttendanceInit,
  getAttendanceSuccess,
  getAttendanceError,
  setNoteSuccess,
  setNoteError
}

enum RegisterRequestStatus {
  init,
  success,
  nameInput,
  emailInput,
  passwordInput,
  errorNameInput,
  errorEmailInput,
  errorPasswordInput,
  registerInit,
  registerSuccess,
  registerError,
}

enum DepartmentStatus {
  init,
  createDepartmentInit,
  createDepartmentSuccess,
  createDepartmentError,
  updateDepartmentInit,
  updateDepartmentSuccess,
  updateDepartmentError,
  getDepartmentInit,
  getDepartmentSuccess,
  getDepartmentError,
  deleteDepartmentInit,
  deleteDepartmentSuccess,
  deleteDepartmentError,
  getDepartmentByIdInit,
  getDepartmentByIdSuccess,
  getDepartmentByIdError,
}

enum PositionStatus {
  init,
  createPositionInit,
  createPositionSuccess,
  createPositionError,
  updatePositionInit,
  updatePositionSuccess,
  updatePositionError,
  getPositionInit,
  getPositionSuccess,
  getPositionError,
  deletePositionInit,
  deletePositionSuccess,
  deletePositionError,
  getPositionByIdInit,
  getPositionByIdSuccess,
  getPositionByIdError,
}

enum PersonnelStatus {
  init,
  createPersonnelInit,
  createPersonnelSuccess,
  createPersonnelError,
  updatePersonnelInit,
  updatePersonnelSuccess,
  updatePersonnelError,
  getPersonnelInit,
  getPersonnelSuccess,
  getPersonnelError,
  deletePersonnelInit,
  deletePersonnelSuccess,
  deletePersonnelError,
  getPersonnelByIdInit,
  getPersonnelByIdSuccess,
  getPersonnelByIdError,
}

enum CheckInSettingStatus {
  init,
  createCheckInSettingInit,
  createCheckInSettingSuccess,
  createCheckInSettingError,
  updateCheckInSettingInit,
  updateCheckInSettingSuccess,
  updateCheckInSettingError,
  getCheckInSettingInit,
  getCheckInSettingSuccess,
  getCheckInSettingError,
  deleteCheckInSettingInit,
  deleteCheckInSettingSuccess,
  deleteCheckInSettingError,
  getCheckInSettingByIdInit,
  getCheckInSettingByIdSuccess,
  getCheckInSettingByIdError,
}

enum NoteStatus {
  init,
  error,
  createNoteInit,
  createNoteSuccess,
  createNoteError,
  createNoteErrorAlreadyExistOnDay,
  getNoteInit,
  getNoteSuccess,
  getNoteError,
  getNotesInit,
  getNotesSuccess,
  getNotesError,
  updateNoteInit,
  updateNoteSuccess,
  updateNoteError,
  deleteNoteInit,
  deleteNoteSuccess,
  deleteNoteError,
  expired,
  complete,
  unfinished,
  reset,
}

enum AddressStatus {
  init,
  start,
  success,
  fail,
  getProvincesSuccess,
  getDistrictsSuccess,
  getWardsSuccess,
}

enum BiometricEnum {
  haveRegistration,
  notRegistered,
}

