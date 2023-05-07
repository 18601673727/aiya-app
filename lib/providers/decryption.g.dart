// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decryption.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$doDecryptionHash() => r'b22330d261428d97518c3c75a38a9d1761e01261';

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

typedef DoDecryptionRef = AutoDisposeFutureProviderRef<String>;

/// See also [doDecryption].
@ProviderFor(doDecryption)
const doDecryptionProvider = DoDecryptionFamily();

/// See also [doDecryption].
class DoDecryptionFamily extends Family<AsyncValue<String>> {
  /// See also [doDecryption].
  const DoDecryptionFamily();

  /// See also [doDecryption].
  DoDecryptionProvider call(
    String? realPath,
  ) {
    return DoDecryptionProvider(
      realPath,
    );
  }

  @override
  DoDecryptionProvider getProviderOverride(
    covariant DoDecryptionProvider provider,
  ) {
    return call(
      provider.realPath,
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
  String? get name => r'doDecryptionProvider';
}

/// See also [doDecryption].
class DoDecryptionProvider extends AutoDisposeFutureProvider<String> {
  /// See also [doDecryption].
  DoDecryptionProvider(
    this.realPath,
  ) : super.internal(
          (ref) => doDecryption(
            ref,
            realPath,
          ),
          from: doDecryptionProvider,
          name: r'doDecryptionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$doDecryptionHash,
          dependencies: DoDecryptionFamily._dependencies,
          allTransitiveDependencies:
              DoDecryptionFamily._allTransitiveDependencies,
        );

  final String? realPath;

  @override
  bool operator ==(Object other) {
    return other is DoDecryptionProvider && other.realPath == realPath;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, realPath.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
