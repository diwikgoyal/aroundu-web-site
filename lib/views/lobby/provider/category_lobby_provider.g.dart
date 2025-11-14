// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_lobby_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getLobbiesFromCategoryHash() =>
    r'5efebb1b7b8829ee511d9b6e95bcc4aab3fdfda9';

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

/// See also [getLobbiesFromCategory].
@ProviderFor(getLobbiesFromCategory)
const getLobbiesFromCategoryProvider = GetLobbiesFromCategoryFamily();

/// See also [getLobbiesFromCategory].
class GetLobbiesFromCategoryFamily extends Family<AsyncValue<List<Lobby>>> {
  /// See also [getLobbiesFromCategory].
  const GetLobbiesFromCategoryFamily();

  /// See also [getLobbiesFromCategory].
  GetLobbiesFromCategoryProvider call(String categoryId) {
    return GetLobbiesFromCategoryProvider(categoryId);
  }

  @override
  GetLobbiesFromCategoryProvider getProviderOverride(
    covariant GetLobbiesFromCategoryProvider provider,
  ) {
    return call(provider.categoryId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getLobbiesFromCategoryProvider';
}

/// See also [getLobbiesFromCategory].
class GetLobbiesFromCategoryProvider
    extends AutoDisposeFutureProvider<List<Lobby>> {
  /// See also [getLobbiesFromCategory].
  GetLobbiesFromCategoryProvider(String categoryId)
    : this._internal(
        (ref) => getLobbiesFromCategory(
          ref as GetLobbiesFromCategoryRef,
          categoryId,
        ),
        from: getLobbiesFromCategoryProvider,
        name: r'getLobbiesFromCategoryProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$getLobbiesFromCategoryHash,
        dependencies: GetLobbiesFromCategoryFamily._dependencies,
        allTransitiveDependencies:
            GetLobbiesFromCategoryFamily._allTransitiveDependencies,
        categoryId: categoryId,
      );

  GetLobbiesFromCategoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
  }) : super.internal();

  final String categoryId;

  @override
  Override overrideWith(
    FutureOr<List<Lobby>> Function(GetLobbiesFromCategoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetLobbiesFromCategoryProvider._internal(
        (ref) => create(ref as GetLobbiesFromCategoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Lobby>> createElement() {
    return _GetLobbiesFromCategoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetLobbiesFromCategoryProvider &&
        other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetLobbiesFromCategoryRef on AutoDisposeFutureProviderRef<List<Lobby>> {
  /// The parameter `categoryId` of this provider.
  String get categoryId;
}

class _GetLobbiesFromCategoryProviderElement
    extends AutoDisposeFutureProviderElement<List<Lobby>>
    with GetLobbiesFromCategoryRef {
  _GetLobbiesFromCategoryProviderElement(super.provider);

  @override
  String get categoryId =>
      (origin as GetLobbiesFromCategoryProvider).categoryId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
