import 'package:base_app/domain/entities/attendance/work_sheet.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'work_sheet_state.g.dart';

@CopyWith()
class WorkSheetState extends Equatable {
  final WorkSheet workSheet;

  const WorkSheetState({this.workSheet = const WorkSheet()});

  @override
  List<Object> get props => [workSheet];
}
