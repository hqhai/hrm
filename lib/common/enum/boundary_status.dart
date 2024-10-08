import 'package:json_annotation/json_annotation.dart';

enum EnumBoundaryStatus {
  @JsonValue('')
  unknown(''),
  @JsonValue('Edit')
  edit('Edit'),
  @JsonValue('Create')
  addition('Create'),
  @JsonValue('New')
  newStatus('New'),
  @JsonValue('Cancel')
  cancel('Cancel'),
  @JsonValue('Approve')
  approve('Approve'),
  @JsonValue('Reject')
  reject('Reject');

  final String name;

  const EnumBoundaryStatus(this.name);
}
