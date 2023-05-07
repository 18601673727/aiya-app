// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$approvalRepositoryHash() =>
    r'0137c7e9f583b421e6e7db93d0f97c7fe3493b30';

/// See also [approvalRepository].
@ProviderFor(approvalRepository)
final approvalRepositoryProvider =
    AutoDisposeProvider<ApprovalRepository>.internal(
  approvalRepository,
  name: r'approvalRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$approvalRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ApprovalRepositoryRef = AutoDisposeProviderRef<ApprovalRepository>;
String _$fetchApprovalHash() => r'de21c855741572f2424bee248455adcd17d04905';

/// See also [fetchApproval].
@ProviderFor(fetchApproval)
final fetchApprovalProvider =
    AutoDisposeFutureProvider<List<Approval>>.internal(
  fetchApproval,
  name: r'fetchApprovalProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchApprovalHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchApprovalRef = AutoDisposeFutureProviderRef<List<Approval>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
