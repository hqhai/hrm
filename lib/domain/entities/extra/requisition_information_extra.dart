import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'requisition_information_extra.g.dart';

@CopyWith()
@JsonSerializable()
class RequisitionInformationExtra {
  final String id;
  final bool checkUser;

  const RequisitionInformationExtra({
    this.id = '',
    this.checkUser = false,
  });

  factory RequisitionInformationExtra.fromJson(Map<String, dynamic> json) => _$RequisitionInformationExtraFromJson(json);

  Map<String, dynamic> toJson() => _$RequisitionInformationExtraToJson(this);
}
