// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lobbies_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$yourLobbiesHash() => r'0c53564f76c4e2341ed97ed7cb8d72f53b1dcbaf';

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

/// See also [yourLobbies].
@ProviderFor(yourLobbies)
const yourLobbiesProvider = YourLobbiesFamily();

/// See also [yourLobbies].
class YourLobbiesFamily extends Family<AsyncValue<List<Lobby>>> {
  /// See also [yourLobbies].
  const YourLobbiesFamily();

  /// See also [yourLobbies].
  YourLobbiesProvider call({String? categoryId, String? subCategoryId}) {
    return YourLobbiesProvider(
      categoryId: categoryId,
      subCategoryId: subCategoryId,
    );
  }

  @override
  YourLobbiesProvider getProviderOverride(
    covariant YourLobbiesProvider provider,
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
  String? get name => r'yourLobbiesProvider';
}

/// See also [yourLobbies].
class YourLobbiesProvider extends FutureProvider<List<Lobby>> {
  /// See also [yourLobbies].
  YourLobbiesProvider({String? categoryId, String? subCategoryId})
    : this._internal(
        (ref) => yourLobbies(
          ref as YourLobbiesRef,
          categoryId: categoryId,
          subCategoryId: subCategoryId,
        ),
        from: yourLobbiesProvider,
        name: r'yourLobbiesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$yourLobbiesHash,
        dependencies: YourLobbiesFamily._dependencies,
        allTransitiveDependencies: YourLobbiesFamily._allTransitiveDependencies,
        categoryId: categoryId,
        subCategoryId: subCategoryId,
      );

  YourLobbiesProvider._internal(
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
    FutureOr<List<Lobby>> Function(YourLobbiesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: YourLobbiesProvider._internal(
        (ref) => create(ref as YourLobbiesRef),
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
  FutureProviderElement<List<Lobby>> createElement() {
    return _YourLobbiesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is YourLobbiesProvider &&
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
mixin YourLobbiesRef on FutureProviderRef<List<Lobby>> {
  /// The parameter `categoryId` of this provider.
  String? get categoryId;

  /// The parameter `subCategoryId` of this provider.
  String? get subCategoryId;
}

class _YourLobbiesProviderElement extends FutureProviderElement<List<Lobby>>
    with YourLobbiesRef {
  _YourLobbiesProviderElement(super.provider);

  @override
  String? get categoryId => (origin as YourLobbiesProvider).categoryId;
  @override
  String? get subCategoryId => (origin as YourLobbiesProvider).subCategoryId;
}

String _$recommendedLobbiesHash() =>
    r'4664a8c2ad63b49ac70d34f5abf1d807daae5805';

/// See also [recommendedLobbies].
@ProviderFor(recommendedLobbies)
const recommendedLobbiesProvider = RecommendedLobbiesFamily();

/// See also [recommendedLobbies].
class RecommendedLobbiesFamily extends Family<AsyncValue<List<Lobby>>> {
  /// See also [recommendedLobbies].
  const RecommendedLobbiesFamily();

  /// See also [recommendedLobbies].
  RecommendedLobbiesProvider call({String? categoryId, String? subCategoryId}) {
    return RecommendedLobbiesProvider(
      categoryId: categoryId,
      subCategoryId: subCategoryId,
    );
  }

  @override
  RecommendedLobbiesProvider getProviderOverride(
    covariant RecommendedLobbiesProvider provider,
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
  String? get name => r'recommendedLobbiesProvider';
}

/// See also [recommendedLobbies].
class RecommendedLobbiesProvider extends FutureProvider<List<Lobby>> {
  /// See also [recommendedLobbies].
  RecommendedLobbiesProvider({String? categoryId, String? subCategoryId})
    : this._internal(
        (ref) => recommendedLobbies(
          ref as RecommendedLobbiesRef,
          categoryId: categoryId,
          subCategoryId: subCategoryId,
        ),
        from: recommendedLobbiesProvider,
        name: r'recommendedLobbiesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$recommendedLobbiesHash,
        dependencies: RecommendedLobbiesFamily._dependencies,
        allTransitiveDependencies:
            RecommendedLobbiesFamily._allTransitiveDependencies,
        categoryId: categoryId,
        subCategoryId: subCategoryId,
      );

  RecommendedLobbiesProvider._internal(
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
    FutureOr<List<Lobby>> Function(RecommendedLobbiesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RecommendedLobbiesProvider._internal(
        (ref) => create(ref as RecommendedLobbiesRef),
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
  FutureProviderElement<List<Lobby>> createElement() {
    return _RecommendedLobbiesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecommendedLobbiesProvider &&
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
mixin RecommendedLobbiesRef on FutureProviderRef<List<Lobby>> {
  /// The parameter `categoryId` of this provider.
  String? get categoryId;

  /// The parameter `subCategoryId` of this provider.
  String? get subCategoryId;
}

class _RecommendedLobbiesProviderElement
    extends FutureProviderElement<List<Lobby>>
    with RecommendedLobbiesRef {
  _RecommendedLobbiesProviderElement(super.provider);

  @override
  String? get categoryId => (origin as RecommendedLobbiesProvider).categoryId;
  @override
  String? get subCategoryId =>
      (origin as RecommendedLobbiesProvider).subCategoryId;
}

String _$topLobbiesHash() => r'c013f4392812ffefa59456d9dd7d091c3032e756';

/// See also [topLobbies].
@ProviderFor(topLobbies)
const topLobbiesProvider = TopLobbiesFamily();

/// See also [topLobbies].
class TopLobbiesFamily extends Family<AsyncValue<List<Lobby>>> {
  /// See also [topLobbies].
  const TopLobbiesFamily();

  /// See also [topLobbies].
  TopLobbiesProvider call({String? categoryId, String? subCategoryId}) {
    return TopLobbiesProvider(
      categoryId: categoryId,
      subCategoryId: subCategoryId,
    );
  }

  @override
  TopLobbiesProvider getProviderOverride(
    covariant TopLobbiesProvider provider,
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
  String? get name => r'topLobbiesProvider';
}

/// See also [topLobbies].
class TopLobbiesProvider extends FutureProvider<List<Lobby>> {
  /// See also [topLobbies].
  TopLobbiesProvider({String? categoryId, String? subCategoryId})
    : this._internal(
        (ref) => topLobbies(
          ref as TopLobbiesRef,
          categoryId: categoryId,
          subCategoryId: subCategoryId,
        ),
        from: topLobbiesProvider,
        name: r'topLobbiesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$topLobbiesHash,
        dependencies: TopLobbiesFamily._dependencies,
        allTransitiveDependencies: TopLobbiesFamily._allTransitiveDependencies,
        categoryId: categoryId,
        subCategoryId: subCategoryId,
      );

  TopLobbiesProvider._internal(
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
    FutureOr<List<Lobby>> Function(TopLobbiesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TopLobbiesProvider._internal(
        (ref) => create(ref as TopLobbiesRef),
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
  FutureProviderElement<List<Lobby>> createElement() {
    return _TopLobbiesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TopLobbiesProvider &&
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
mixin TopLobbiesRef on FutureProviderRef<List<Lobby>> {
  /// The parameter `categoryId` of this provider.
  String? get categoryId;

  /// The parameter `subCategoryId` of this provider.
  String? get subCategoryId;
}

class _TopLobbiesProviderElement extends FutureProviderElement<List<Lobby>>
    with TopLobbiesRef {
  _TopLobbiesProviderElement(super.provider);

  @override
  String? get categoryId => (origin as TopLobbiesProvider).categoryId;
  @override
  String? get subCategoryId => (origin as TopLobbiesProvider).subCategoryId;
}

String _$joinedLobbiesHash() => r'a6f009077c100367eba23195f1c4aebb2f81b525';

/// See also [joinedLobbies].
@ProviderFor(joinedLobbies)
const joinedLobbiesProvider = JoinedLobbiesFamily();

/// See also [joinedLobbies].
class JoinedLobbiesFamily extends Family<AsyncValue<List<Lobby>>> {
  /// See also [joinedLobbies].
  const JoinedLobbiesFamily();

  /// See also [joinedLobbies].
  JoinedLobbiesProvider call({String? categoryId, String? subCategoryId}) {
    return JoinedLobbiesProvider(
      categoryId: categoryId,
      subCategoryId: subCategoryId,
    );
  }

  @override
  JoinedLobbiesProvider getProviderOverride(
    covariant JoinedLobbiesProvider provider,
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
  String? get name => r'joinedLobbiesProvider';
}

/// See also [joinedLobbies].
class JoinedLobbiesProvider extends FutureProvider<List<Lobby>> {
  /// See also [joinedLobbies].
  JoinedLobbiesProvider({String? categoryId, String? subCategoryId})
    : this._internal(
        (ref) => joinedLobbies(
          ref as JoinedLobbiesRef,
          categoryId: categoryId,
          subCategoryId: subCategoryId,
        ),
        from: joinedLobbiesProvider,
        name: r'joinedLobbiesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$joinedLobbiesHash,
        dependencies: JoinedLobbiesFamily._dependencies,
        allTransitiveDependencies:
            JoinedLobbiesFamily._allTransitiveDependencies,
        categoryId: categoryId,
        subCategoryId: subCategoryId,
      );

  JoinedLobbiesProvider._internal(
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
    FutureOr<List<Lobby>> Function(JoinedLobbiesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: JoinedLobbiesProvider._internal(
        (ref) => create(ref as JoinedLobbiesRef),
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
  FutureProviderElement<List<Lobby>> createElement() {
    return _JoinedLobbiesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is JoinedLobbiesProvider &&
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
mixin JoinedLobbiesRef on FutureProviderRef<List<Lobby>> {
  /// The parameter `categoryId` of this provider.
  String? get categoryId;

  /// The parameter `subCategoryId` of this provider.
  String? get subCategoryId;
}

class _JoinedLobbiesProviderElement extends FutureProviderElement<List<Lobby>>
    with JoinedLobbiesRef {
  _JoinedLobbiesProviderElement(super.provider);

  @override
  String? get categoryId => (origin as JoinedLobbiesProvider).categoryId;
  @override
  String? get subCategoryId => (origin as JoinedLobbiesProvider).subCategoryId;
}

String _$savedLobbiesHash() => r'654064a14ce0b861ea2e948ab9ec56ed7158cd9e';

/// See also [savedLobbies].
@ProviderFor(savedLobbies)
const savedLobbiesProvider = SavedLobbiesFamily();

/// See also [savedLobbies].
class SavedLobbiesFamily extends Family<AsyncValue<List<Lobby>>> {
  /// See also [savedLobbies].
  const SavedLobbiesFamily();

  /// See also [savedLobbies].
  SavedLobbiesProvider call({String? categoryId, String? subCategoryId}) {
    return SavedLobbiesProvider(
      categoryId: categoryId,
      subCategoryId: subCategoryId,
    );
  }

  @override
  SavedLobbiesProvider getProviderOverride(
    covariant SavedLobbiesProvider provider,
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
  String? get name => r'savedLobbiesProvider';
}

/// See also [savedLobbies].
class SavedLobbiesProvider extends FutureProvider<List<Lobby>> {
  /// See also [savedLobbies].
  SavedLobbiesProvider({String? categoryId, String? subCategoryId})
    : this._internal(
        (ref) => savedLobbies(
          ref as SavedLobbiesRef,
          categoryId: categoryId,
          subCategoryId: subCategoryId,
        ),
        from: savedLobbiesProvider,
        name: r'savedLobbiesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$savedLobbiesHash,
        dependencies: SavedLobbiesFamily._dependencies,
        allTransitiveDependencies:
            SavedLobbiesFamily._allTransitiveDependencies,
        categoryId: categoryId,
        subCategoryId: subCategoryId,
      );

  SavedLobbiesProvider._internal(
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
    FutureOr<List<Lobby>> Function(SavedLobbiesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SavedLobbiesProvider._internal(
        (ref) => create(ref as SavedLobbiesRef),
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
  FutureProviderElement<List<Lobby>> createElement() {
    return _SavedLobbiesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SavedLobbiesProvider &&
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
mixin SavedLobbiesRef on FutureProviderRef<List<Lobby>> {
  /// The parameter `categoryId` of this provider.
  String? get categoryId;

  /// The parameter `subCategoryId` of this provider.
  String? get subCategoryId;
}

class _SavedLobbiesProviderElement extends FutureProviderElement<List<Lobby>>
    with SavedLobbiesRef {
  _SavedLobbiesProviderElement(super.provider);

  @override
  String? get categoryId => (origin as SavedLobbiesProvider).categoryId;
  @override
  String? get subCategoryId => (origin as SavedLobbiesProvider).subCategoryId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
