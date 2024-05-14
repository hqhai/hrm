// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map<String, dynamic> json) => Request(
      id: json['id'] as String,
      createdUserId: json['createdUserId'] as String,
      updatedUserId: json['updatedUserId'] as String?,
      createdFullName: json['createdFullName'] as String?,
      updatedFullName: json['updatedFullName'] as String?,
      createdDate: json['createdDate'] as String?,
      updatedDate: json['updatedDate'] as String?,
      type: json['type'] as String?,
      isApprove: json['isApprove'] as bool?,
      approverId: json['approverId'] as String?,
      priority: json['priority'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      filePathsStr: json['filePathsStr'] as String?,
      department: json['department'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      note: json['note'] as String?,
      filePaths: (json['filePaths'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      status: json['status'] as String?,
      dateConfirmDone: json['dateConfirmDone'] as String?,
      configStr: json['configStr'] as String?,
    );

Map<String, dynamic> _$RequestToJson(Request instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'createdUserId': instance.createdUserId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('updatedUserId', instance.updatedUserId);
  writeNotNull('createdFullName', instance.createdFullName);
  writeNotNull('updatedFullName', instance.updatedFullName);
  writeNotNull('createdDate', instance.createdDate);
  writeNotNull('updatedDate', instance.updatedDate);
  writeNotNull('type', instance.type);
  writeNotNull('isApprove', instance.isApprove);
  writeNotNull('approverId', instance.approverId);
  writeNotNull('priority', instance.priority);
  writeNotNull('title', instance.title);
  writeNotNull('content', instance.content);
  writeNotNull('filePathsStr', instance.filePathsStr);
  writeNotNull('department', instance.department);
  writeNotNull('phoneNumber', instance.phoneNumber);
  writeNotNull('note', instance.note);
  writeNotNull('filePaths', instance.filePaths);
  writeNotNull('status', instance.status);
  writeNotNull('dateConfirmDone', instance.dateConfirmDone);
  writeNotNull('configStr', instance.configStr);
  return val;
}
