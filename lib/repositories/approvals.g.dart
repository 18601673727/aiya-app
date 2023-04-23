// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approvals.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$approvalsRepositoryHash() =>
    r'ade2ee7dbde8d872fe173d7a8c8826cdc9881f24';

/// See also [approvalsRepository].
@ProviderFor(approvalsRepository)
final approvalsRepositoryProvider =
    AutoDisposeProvider<ApprovalsRepository>.internal(
  approvalsRepository,
  name: r'approvalsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$approvalsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ApprovalsRepositoryRef = AutoDisposeProviderRef<ApprovalsRepository>;
String _$fetchApprovalsHash() => r'9a2437f0ec05755bacc21b98cf7ef5ee394dfe6e';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef FetchApprovalsRef = AutoDisposeFutureProviderRef<List<Approval>>;

/// See also [fetchApprovals].
@ProviderFor(fetchApprovals)
const fetchApprovalsProvider = FetchApprovalsFamily();

/// See also [fetchApprovals].
class FetchApprovalsFamily extends Family<AsyncValue<List<Approval>>> {
  /// See also [fetchApprovals].
  const FetchApprovalsFamily();

  /// See also [fetchApprovals].
  FetchApprovalsProvider call({
    required int pageNumber,
  }) {
    return FetchApprovalsProvider(
      pageNumber: pageNumber,
    );
  }

  @override
  FetchApprovalsProvider getProviderOverride(
    covariant FetchApprovalsProvider provider,
  ) {
    return call(
      pageNumber: provider.pageNumber,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchApprovalsProvider';
}

/// See also [fetchApprovals].
class FetchApprovalsProvider extends AutoDisposeFutureProvider<List<Approval>> {
  /// See also [fetchApprovals].
  FetchApprovalsProvider({
    required this.pageNumber,
  }) : super.internal(
          (ref) => fetchApprovals(
            ref,
            pageNumber: pageNumber,
          ),
          from: fetchApprovalsProvider,
          name: r'fetchApprovalsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchApprovalsHash,
          dependencies: FetchApprovalsFamily._dependencies,
          allTransitiveDependencies:
              FetchApprovalsFamily._allTransitiveDependencies,
        );

  final int pageNumber;

  @override
  bool operator ==(Object other) {
    return other is FetchApprovalsProvider && other.pageNumber == pageNumber;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pageNumber.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
