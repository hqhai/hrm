import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/l10n/app_localizations.dart';

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

enum ConfigRoleStringValues {
  generalManager('GeneralManager'),
  manager('Manager'),
  user('User'),
  userSystem('UserSystem');

  final String name;

  const ConfigRoleStringValues(this.name);
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

enum GenderEnum {
  male('Nam', 'Male'),
  female('Nữ', 'Female'),
  other('Khác', 'Other');

  final String nameVi;
  final String nameEn;

  const GenderEnum(this.nameVi, this.nameEn);
}

enum StatusRequisitionEnum {
  pending('Pending', 'Chờ duyệt'),
  reject('Reject', 'Đã từ chối'),
  modification('Modification application', 'Sửa lại đơn'),
  done('Done', 'Đã duyệt'),
  expiredEdit('Expired edit', 'Quá hạn sửa'),
  expired('Expired', 'Hết hạn');

  final String nameEn;
  final String nameVi;

  const StatusRequisitionEnum(this.nameEn, this.nameVi);
}

extension ConfigStatusExtension on StatusRequisitionEnum {
  String get configStatusName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case StatusRequisitionEnum.pending:
        return appLocalizations.pending;
      case StatusRequisitionEnum.reject:
        return appLocalizations.reject;
      case StatusRequisitionEnum.modification:
        return appLocalizations.modification;
      case StatusRequisitionEnum.done:
        return appLocalizations.done;
      case StatusRequisitionEnum.expiredEdit:
        return appLocalizations.expiredEdit;
      case StatusRequisitionEnum.expired:
        return appLocalizations.expired;
    }
  }
}


enum RequisitionTypeEnum {
  leave('Đơn xin nghỉ', 'Application for leave'),
  explanation('Giải trình công', 'Explanation'),
  overtime('Đơn tăng ca', 'Overtime'),
  vehicleDispatch('Đơn đề nghị điều xe', 'Application for vehicle dispatch'),
  postalDelivery('Đơn đề nghị chuyển phát bưu điện', 'Application for postal delivery'),
  releaseOfWarehouse('Đơn đề nghị xuất kho', 'Application for release of warehouse'),
  stationeryOrder('Phiếu đặt văn phòng phẩm', 'Stationery order form'),
  business('Đơn công tác', 'application for business trip');

  final String nameVi;
  final String nameEn;

  const RequisitionTypeEnum(this.nameVi, this.nameEn);
}

extension ConfigTypeExtension on RequisitionTypeEnum {
  String get configTypeName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {

      case RequisitionTypeEnum.leave:
        return appLocalizations.leave;
      case RequisitionTypeEnum.explanation:
        return appLocalizations.explanation;
      case RequisitionTypeEnum.overtime:
        return appLocalizations.overtime;
      case RequisitionTypeEnum.vehicleDispatch:
        return appLocalizations.vehicleDispatch;
      case RequisitionTypeEnum.postalDelivery:
        return appLocalizations.postalDelivery;
      case RequisitionTypeEnum.releaseOfWarehouse:
        return appLocalizations.releaseOfWarehouse;
      case RequisitionTypeEnum.stationeryOrder:
        return appLocalizations.stationeryOrder;
      case RequisitionTypeEnum.business:
        return appLocalizations.business;
    }
  }
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
