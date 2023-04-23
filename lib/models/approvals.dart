import 'package:freezed_annotation/freezed_annotation.dart';
import 'approval.dart';

part 'approvals.freezed.dart';
part 'approvals.g.dart';

@freezed
abstract class Approvals with _$Approvals {
  const factory Approvals({
    required List<Approval> approvalList,
  }) = _Approvals;
  factory Approvals.fromJson(Map<String, dynamic> json) => _$ApprovalsFromJson(json);
}
