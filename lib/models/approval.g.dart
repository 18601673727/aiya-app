// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Approval _$$_ApprovalFromJson(Map<String, dynamic> json) => _$_Approval(
      fileName: json['fileName'] as String,
      userName: json['userName'] as String,
      actionType: json['actionType'] as String,
      description: json['description'] as String,
      createdAt: json['createdAt'] as String,
      fileId: json['fileId'] as int,
      userId: json['userId'] as int,
    );

Map<String, dynamic> _$$_ApprovalToJson(_$_Approval instance) =>
    <String, dynamic>{
      'fileName': instance.fileName,
      'userName': instance.userName,
      'actionType': instance.actionType,
      'description': instance.description,
      'createdAt': instance.createdAt,
      'fileId': instance.fileId,
      'userId': instance.userId,
    };
