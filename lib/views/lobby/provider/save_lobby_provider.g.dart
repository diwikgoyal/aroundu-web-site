// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_lobby_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$toggleBookmarkHash() => r'37cf09d659eb51e8574c49c443199afd0060f104';

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

/// See also [toggleBookmark].
@ProviderFor(toggleBookmark)
const toggleBookmarkProvider = ToggleBookmarkFamily();

/// See also [toggleBookmark].
class ToggleBookmarkFamily extends Family<AsyncValue<void>> {
  /// See also [toggleBookmark].
  const ToggleBookmarkFamily();

  /// See also [toggleBookmark].
  ToggleBookmarkProvider call({
    required String itemId,
    required bool isSaved,
    required String entityType,
  }) {
    return ToggleBookmarkProvider(
      itemId: itemId,
      isSaved: isSaved,
      entityType: entityType,
    );
  }

  @override
  ToggleBookmarkProvider getProviderOverride(
    covariant ToggleBookmarkProvider provider,
  ) {
    return call(
      itemId: provider.itemId,
      isSaved: provider.isSaved,
      entityType: provider.entityType,
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
  String? get name => r'toggleBookmarkProvider';
}

/// See also [toggleBookmark].
class ToggleBookmarkProvider extends AutoDisposeFutureProvider<void> {
  /// See also [toggleBookmark].
  ToggleBookmarkProvider({
    required String itemId,
    required bool isSaved,
    required String entityType,
  }) : this._internal(
         (ref) => toggleBookmark(
           ref as ToggleBookmarkRef,
           itemId: itemId,
           isSaved: isSaved,
           entityType: entityType,
         ),
         from: toggleBookmarkProvider,
         name: r'toggleBookmarkProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$toggleBookmarkHash,
         dependencies: ToggleBookmarkFamily._dependencies,
         allTransitiveDependencies:
             ToggleBookmarkFamily._allTransitiveDependencies,
         itemId: itemId,
         isSaved: isSaved,
         entityType: entityType,
       );

  ToggleBookmarkProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.itemId,
    required this.isSaved,
    required this.entityType,
  }) : super.internal();

  final String itemId;
  final bool isSaved;
  final String entityType;

  @override
  Override overrideWith(
    FutureOr<void> Function(ToggleBookmarkRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ToggleBookmarkProvider._internal(
        (ref) => create(ref as ToggleBookmarkRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        itemId: itemId,
        isSaved: isSaved,
        entityType: entityType,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _ToggleBookmarkProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ToggleBookmarkProvider &&
        other.itemId == itemId &&
        other.isSaved == isSaved &&
        other.entityType == entityType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, itemId.hashCode);
    hash = _SystemHash.combine(hash, isSaved.hashCode);
    hash = _SystemHash.combine(hash, entityType.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ToggleBookmarkRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `itemId` of this provider.
  String get itemId;

  /// The parameter `isSaved` of this provider.
  bool get isSaved;

  /// The parameter `entityType` of this provider.
  String get entityType;
}

class _ToggleBookmarkProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with ToggleBookmarkRef {
  _ToggleBookmarkProviderElement(super.provider);

  @override
  String get itemId => (origin as ToggleBookmarkProvider).itemId;
  @override
  bool get isSaved => (origin as ToggleBookmarkProvider).isSaved;
  @override
  String get entityType => (origin as ToggleBookmarkProvider).entityType;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
