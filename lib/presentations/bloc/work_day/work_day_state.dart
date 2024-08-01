import 'package:base_app/data/models/response/paging_infor_request.dart';
import 'package:base_app/domain/entities/work_day/work_day.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'work_day_state.g.dart';

@CopyWith()
class WorkDayState extends Equatable {
  final Map<DateTime, WorkDay> workDays;
  final List<DateTime> workDayIds;
  final DateTime? selectDate;
  final bool isLoading;
  final List<WorkDayAdmin> items;
  final PagingInfoRequest pagingInfo;
  final List<UsableAdmin> electiveShiftItems;
  final PagingInfoRequest electiveShiftPagingInfo;
  final List<WorkDayAdmin> itemsDetail;
  final PagingInfoRequest pagingInfoDetail;

  const WorkDayState({
    this.itemsDetail = const [],
    this.pagingInfoDetail = const PagingInfoRequest(),
    this.electiveShiftItems = const [],
    this.electiveShiftPagingInfo = const PagingInfoRequest(),
    this.workDays = const {},
    this.workDayIds = const [],
    this.selectDate,
    this.isLoading = false,
    this.items = const [],
    this.pagingInfo = const PagingInfoRequest(),
  });

  @override
  List<Object?> get props => [
        itemsDetail,
        pagingInfoDetail,
        electiveShiftItems,
        electiveShiftPagingInfo,
        items,
        pagingInfo,
        workDays,
        workDayIds,
        selectDate,
        isLoading
      ];
}
