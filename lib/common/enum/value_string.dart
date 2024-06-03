
enum TypeRequestStatus {
  overTime('OverTime'),
  onLeave('OnLeave'),
  explanation('Explanation'),
  roomMeeting('RoomMeeting'),
  cRM('CRM'),
  iT('IT'),
  website('Website');

  final String name;

  const TypeRequestStatus(this.name);
}

enum StatusRequestStatus {
  pending('Pending'),
  reject('Reject'),
  subsequentApproval('SubsequentApproval'),
  doing('Doing'),
  done('Done'),
  cancel('Cancel');

  final String name;

  const StatusRequestStatus(this.name);
}

enum PriorityRequestStatus {
  high('High'),
  medium('Medium'),
  low('Low');

  final String name;

  const PriorityRequestStatus(this.name);
}




enum ParentId {
  aG('Atlantic group'),
  fsel('Five-star E-Learning');

  final String name;

  const ParentId(this.name);
}

enum LanguageEnum {
  vi('Tiếng Việt', 'vi'),
  en('English', 'en');

  final String name;
  final String code;

  const LanguageEnum(this.name, this.code);
}

enum LocationEnum {
  country('Country'),
  province('Province'),
  district('District'),
  ward('Ward');

  final String name;

  const LocationEnum(this.name);
}

enum WeekDayEnum {
  monday('Monday', 'Thứ hai'),
  tuesday('Tuesday', 'Thứ ba'),
  wednesday('Wednesday', 'Thứ tư'),
  thursday('Thursday', 'Thứ năm'),
  friday('Friday', 'Thứ sáu'),
  saturday('Saturday', 'Thứ bảy'),
  sunday('Sunday', 'Chủ nhật');

  final String nameEn;
  final String nameVi;

  const WeekDayEnum(this.nameEn, this.nameVi);
}
