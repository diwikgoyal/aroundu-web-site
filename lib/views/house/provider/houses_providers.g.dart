// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'houses_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$yourHousesHash() => r'9710db31cd7f07c07401e98d27ce505b23921402';

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

/// See also [yourHouses].
@ProviderFor(yourHouses)
const yourHousesProvider = YourHousesFamily();

/// See also [yourHouses].
class YourHousesFamily extends Family<AsyncValue<List<House>>> {
  /// See also [yourHouses].
  const YourHousesFamily();

  /// See also [yourHouses].
  YourHousesProvider call({String? categoryId, String? subCategoryId}) {
    return YourHousesProvider(
      categoryId: categoryId,
      subCategoryId: subCategoryId,
    );
  }

  @override
  YourHousesProvider getProviderOverride(
    covariant YourHousesProvider provider,
  ) {
    return call(
      categoryId: provider.categoryId,
      subCategoryId: provider.subCategoryId,
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
  String? get name => r'yourHousesProvider';
}

/// See also [yourHouses].
class YourHousesProvider extends FutureProvider<List<House>> {
  /// See also [yourHouses].
  YourHousesProvider({String? categoryId, String? subCategoryId})
    : this._internal(
        (ref) => yourHouses(
          ref as YourHousesRef,
          categoryId: categoryId,
          subCategoryId: subCategoryId,
        ),
        from: yourHousesProvider,
        name: r'yourHousesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$yourHousesHash,
        dependencies: YourHousesFamily._dependencies,
        allTransitiveDependencies: YourHousesFamily._allTransitiveDependencies,
        categoryId: categoryId,
        subCategoryId: subCategoryId,
      );

  YourHousesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
    required this.subCategoryId,
  }) : super.internal();

  final String? categoryId;
  final String? subCategoryId;

  @override
  Override overrideWith(
    FutureOr<List<House>> Function(YourHousesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: YourHousesProvider._internal(
        (ref) => create(ref as YourHousesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
        subCategoryId: subCategoryId,
      ),
    );
  }

  @override
  FutureProviderElement<List<House>> createElement() {
    return _YourHousesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is YourHousesProvider &&
        other.categoryId == categoryId &&
        other.subCategoryId == subCategoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);
    hash = _SystemHash.combine(hash, subCategoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin YourHousesRef on FutureProviderRef<List<House>> {
  /// The parameter `categoryId` of this provider.
  String? get categoryId;

  /// The parameter `subCategoryId` of this provider.
  String? get subCategoryId;
}

class _YourHousesProviderElement extends FutureProviderElement<List<House>>
    with YourHousesRef {
  _YourHousesProviderElement(super.provider);

  @override
  String? get categoryId => (origin as YourHousesProvider).categoryId;
  @override
  String? get subCategoryId => (origin as YourHousesProvider).subCategoryId;
}

String _$recommendedHousesHash() => r'a6be0c61534d1f74cca337253fa320943a877aee';

/// See also [recommendedHouses].
@ProviderFor(recommendedHouses)
const recommendedHousesProvider = RecommendedHousesFamily();

/// See also [recommendedHouses].
class RecommendedHousesFamily extends Family<AsyncValue<List<House>>> {
  /// See also [recommendedHouses].
  const RecommendedHousesFamily();

  /// See also [recommendedHouses].
  RecommendedHousesProvider call({String? categoryId, String? subCategoryId}) {
    return RecommendedHousesProvider(
      categoryId: categoryId,
      subCategoryId: subCategoryId,
    );
  }

  @override
  RecommendedHousesProvider getProviderOverride(
    covariant RecommendedHousesProvider provider,
  ) {
    return call(
      categoryId: provider.categoryId,
      subCategoryId: provider.subCategoryId,
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
  String? get name => r'recommendedHousesProvider';
}

/// See also [recommendedHouses].
class RecommendedHousesProvider extends FutureProvider<List<House>> {
  /// See also [recommendedHouses].
  RecommendedHousesProvider({String? categoryId, String? subCategoryId})
    : this._internal(
        (ref) => recommendedHouses(
          ref as RecommendedHousesRef,
          categoryId: categoryId,
          subCategoryId: subCategoryId,
        ),
        from: recommendedHousesProvider,
        name: r'recommendedHousesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$recommendedHousesHash,
        dependencies: RecommendedHousesFamily._dependencies,
        allTransitiveDependencies:
            RecommendedHousesFamily._allTransitiveDependencies,
        categoryId: categoryId,
        subCategoryId: subCategoryId,
      );

  RecommendedHousesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
    required this.subCategoryId,
  }) : super.internal();

  final String? categoryId;
  final String? subCategoryId;

  @override
  Override overrideWith(
    FutureOr<List<House>> Function(RecommendedHousesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RecommendedHousesProvider._internal(
        (ref) => create(ref as RecommendedHousesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
        subCategoryId: subCategoryId,
      ),
    );
  }

  @override
  FutureProviderElement<List<House>> createElement() {
    return _RecommendedHousesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecommendedHousesProvider &&
        other.categoryId == categoryId &&
        other.subCategoryId == subCategoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);
    hash = _SystemHash.combine(hash, subCategoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RecommendedHousesRef on FutureProviderRef<List<House>> {
  /// The parameter `categoryId` of this provider.
  String? get categoryId;

  /// The parameter `subCategoryId` of this provider.
  String? get subCategoryId;
}

class _RecommendedHousesProviderElement
    extends FutureProviderElement<List<House>>
    with RecommendedHousesRef {
  _RecommendedHousesProviderElement(super.provider);

  @override
  String? get categoryId => (origin as RecommendedHousesProvider).categoryId;
  @override
  String? get subCategoryId =>
      (origin as RecommendedHousesProvider).subCategoryId;
}

String _$topHousesHash() => r'a50e7f860f1a6ac03b0b5eed15656ebf1ce4ec31';

/// See also [topHouses].
@ProviderFor(topHouses)
const topHousesProvider = TopHousesFamily();

/// See also [topHouses].
class TopHousesFamily extends Family<AsyncValue<List<House>>> {
  /// See also [topHouses].
  const TopHousesFamily();

  /// See also [topHouses].
  TopHousesProvider call({String? categoryId, String? subCategoryId}) {
    return TopHousesProvider(
      categoryId: categoryId,
      subCategoryId: subCategoryId,
    );
  }

  @override
  TopHousesProvider getProviderOverride(covariant TopHousesProvider provider) {
    return call(
      categoryId: provider.categoryId,
      subCategoryId: provider.subCategoryId,
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
  String? get name => r'topHousesProvider';
}

/// See also [topHouses].
class TopHousesProvider extends FutureProvider<List<House>> {
  /// See also [topHouses].
  TopHousesProvider({String? categoryId, String? subCategoryId})
    : this._internal(
        (ref) => topHouses(
          ref as TopHousesRef,
          categoryId: categoryId,
          subCategoryId: subCategoryId,
        ),
        from: topHousesProvider,
        name: r'topHousesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$topHousesHash,
        dependencies: TopHousesFamily._dependencies,
        allTransitiveDependencies: TopHousesFamily._allTransitiveDependencies,
        categoryId: categoryId,
        subCategoryId: subCategoryId,
      );

  TopHousesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
    required this.subCategoryId,
  }) : super.internal();

  final String? categoryId;
  final String? subCategoryId;

  @override
  Override overrideWith(
    FutureOr<List<House>> Function(TopHousesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TopHousesProvider._internal(
        (ref) => create(ref as TopHousesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
        subCategoryId: subCategoryId,
      ),
    );
  }

  @override
  FutureProviderElement<List<House>> createElement() {
    return _TopHousesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TopHousesProvider &&
        other.categoryId == categoryId &&
        other.subCategoryId == subCategoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);
    hash = _SystemHash.combine(hash, subCategoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TopHousesRef on FutureProviderRef<List<House>> {
  /// The parameter `categoryId` of this provider.
  String? get categoryId;

  /// The parameter `subCategoryId` of this provider.
  String? get subCategoryId;
}

class _TopHousesProviderElement extends FutureProviderElement<List<House>>
    with TopHousesRef {
  _TopHousesProviderElement(super.provider);

  @override
  String? get categoryId => (origin as TopHousesProvider).categoryId;
  @override
  String? get subCategoryId => (origin as TopHousesProvider).subCategoryId;
}

String _$followedHousesHash() => r'c7fb1815283f156c8cbc071c7aa7fff146d8af92';

/// See also [followedHouses].
@ProviderFor(followedHouses)
const followedHousesProvider = FollowedHousesFamily();

/// See also [followedHouses].
class FollowedHousesFamily extends Family<AsyncValue<List<House>>> {
  /// See also [followedHouses].
  const FollowedHousesFamily();

  /// See also [followedHouses].
  FollowedHousesProvider call({String? categoryId, String? subCategoryId}) {
    return FollowedHousesProvider(
      categoryId: categoryId,
      subCategoryId: subCategoryId,
    );
  }

  @override
  FollowedHousesProvider getProviderOverride(
    covariant FollowedHousesProvider provider,
  ) {
    return call(
      categoryId: provider.categoryId,
      subCategoryId: provider.subCategoryId,
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
  String? get name => r'followedHousesProvider';
}

/// See also [followedHouses].
class FollowedHousesProvider extends FutureProvider<List<House>> {
  /// See also [followedHouses].
  FollowedHousesProvider({String? categoryId, String? subCategoryId})
    : this._internal(
        (ref) => followedHouses(
          ref as FollowedHousesRef,
          categoryId: categoryId,
          subCategoryId: subCategoryId,
        ),
        from: followedHousesProvider,
        name: r'followedHousesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$followedHousesHash,
        dependencies: FollowedHousesFamily._dependencies,
        allTransitiveDependencies:
            FollowedHousesFamily._allTransitiveDependencies,
        categoryId: categoryId,
        subCategoryId: subCategoryId,
      );

  FollowedHousesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
    required this.subCategoryId,
  }) : super.internal();

  final String? categoryId;
  final String? subCategoryId;

  @override
  Override overrideWith(
    FutureOr<List<House>> Function(FollowedHousesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FollowedHousesProvider._internal(
        (ref) => create(ref as FollowedHousesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
        subCategoryId: subCategoryId,
      ),
    );
  }

  @override
  FutureProviderElement<List<House>> createElement() {
    return _FollowedHousesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FollowedHousesProvider &&
        other.categoryId == categoryId &&
        other.subCategoryId == subCategoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);
    hash = _SystemHash.combine(hash, subCategoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FollowedHousesRef on FutureProviderRef<List<House>> {
  /// The parameter `categoryId` of this provider.
  String? get categoryId;

  /// The parameter `subCategoryId` of this provider.
  String? get subCategoryId;
}

class _FollowedHousesProviderElement extends FutureProviderElement<List<House>>
    with FollowedHousesRef {
  _FollowedHousesProviderElement(super.provider);

  @override
  String? get categoryId => (origin as FollowedHousesProvider).categoryId;
  @override
  String? get subCategoryId => (origin as FollowedHousesProvider).subCategoryId;
}

String _$createdHousesHash() => r'd493e0aae67bcedbe5aecf85a0bd8cf6b34e6b13';

/// See also [createdHouses].
@ProviderFor(createdHouses)
const createdHousesProvider = CreatedHousesFamily();

/// See also [createdHouses].
class CreatedHousesFamily extends Family<AsyncValue<List<House>>> {
  /// See also [createdHouses].
  const CreatedHousesFamily();

  /// See also [createdHouses].
  CreatedHousesProvider call({String? categoryId, String? subCategoryId}) {
    return CreatedHousesProvider(
      categoryId: categoryId,
      subCategoryId: subCategoryId,
    );
  }

  @override
  CreatedHousesProvider getProviderOverride(
    covariant CreatedHousesProvider provider,
  ) {
    return call(
      categoryId: provider.categoryId,
      subCategoryId: provider.subCategoryId,
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
  String? get name => r'createdHousesProvider';
}

/// See also [createdHouses].
class CreatedHousesProvider extends FutureProvider<List<House>> {
  /// See also [createdHouses].
  CreatedHousesProvider({String? categoryId, String? subCategoryId})
    : this._internal(
        (ref) => createdHouses(
          ref as CreatedHousesRef,
          categoryId: categoryId,
          subCategoryId: subCategoryId,
        ),
        from: createdHousesProvider,
        name: r'createdHousesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$createdHousesHash,
        dependencies: CreatedHousesFamily._dependencies,
        allTransitiveDependencies:
            CreatedHousesFamily._allTransitiveDependencies,
        categoryId: categoryId,
        subCategoryId: subCategoryId,
      );

  CreatedHousesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
    required this.subCategoryId,
  }) : super.internal();

  final String? categoryId;
  final String? subCategoryId;

  @override
  Override overrideWith(
    FutureOr<List<House>> Function(CreatedHousesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreatedHousesProvider._internal(
        (ref) => create(ref as CreatedHousesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
        subCategoryId: subCategoryId,
      ),
    );
  }

  @override
  FutureProviderElement<List<House>> createElement() {
    return _CreatedHousesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreatedHousesProvider &&
        other.categoryId == categoryId &&
        other.subCategoryId == subCategoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);
    hash = _SystemHash.combine(hash, subCategoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CreatedHousesRef on FutureProviderRef<List<House>> {
  /// The parameter `categoryId` of this provider.
  String? get categoryId;

  /// The parameter `subCategoryId` of this provider.
  String? get subCategoryId;
}

class _CreatedHousesProviderElement extends FutureProviderElement<List<House>>
    with CreatedHousesRef {
  _CreatedHousesProviderElement(super.provider);

  @override
  String? get categoryId => (origin as CreatedHousesProvider).categoryId;
  @override
  String? get subCategoryId => (origin as CreatedHousesProvider).subCategoryId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
