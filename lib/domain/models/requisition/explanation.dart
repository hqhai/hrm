import 'package:base_app/common/utils/date_time_json.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'explanation.g.dart';

@CopyWith()
@JsonSerializable()
@CustomDateTimeConverter()
@CopyWith()
class Explanation extends Equatable {
  final String note;
  final DateTime? workDate;
  final int checkIn;
  final int checkOut;

  const Explanation({
    this.note = '',
    this.workDate,
    this.checkIn = 0,
    this.checkOut = 0,
  });

  factory Explanation.fromJson(Map<String, dynamic> json) => _$ExplanationFromJson(json);

  Map<String, dynamic> toJson() => _$ExplanationToJson(this);

  @override
  List<Object?> get props => [
        note,
        workDate,
        checkIn,
        checkOut,
      ];
}
