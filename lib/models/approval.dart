import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'approval.freezed.dart';
part 'approval.g.dart';

@freezed
class Approval with _$Approval {
  const factory Approval({
    required String fileName,
    required String userName,
    required String actionType,
    required String description,
    required String createdAt,
    required int fileId,
    required int userId,
  }) = _Approval;

  factory Approval.fromJson(Map<String, Object?> json) => _$ApprovalFromJson(json);
}
