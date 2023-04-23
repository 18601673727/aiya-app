// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approvals.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Approvals _$$_ApprovalsFromJson(Map<String, dynamic> json) => _$_Approvals(
      approvalList: (json['approvalList'] as List<dynamic>)
          .map((e) => Approval.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ApprovalsToJson(_$_Approvals instance) =>
    <String, dynamic>{
      'approvalList': instance.approvalList,
    };
