// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'past_lobby_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activateLobbyHash() => r'0b146f65ce202c31a55bede955662b83d630c11d';

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

/// Provider to activate a lobby
///
/// Copied from [activateLobby].
@ProviderFor(activateLobby)
const activateLobbyProvider = ActivateLobbyFamily();

/// Provider to activate a lobby
///
/// Copied from [activateLobby].
class ActivateLobbyFamily extends Family<AsyncValue<bool>> {
  /// Provider to activate a lobby
  ///
  /// Copied from [activateLobby].
  const ActivateLobbyFamily();

  /// Provider to activate a lobby
  ///
  /// Copied from [activateLobby].
  ActivateLobbyProvider call(String lobbyId) {
    return ActivateLobbyProvider(lobbyId);
  }

  @override
  ActivateLobbyProvider getProviderOverride(
    covariant ActivateLobbyProvider provider,
  ) {
    return call(provider.lobbyId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'activateLobbyProvider';
}

/// Provider to activate a lobby
///
/// Copied from [activateLobby].
class ActivateLobbyProvider extends AutoDisposeFutureProvider<bool> {
  /// Provider to activate a lobby
  ///
  /// Copied from [activateLobby].
  ActivateLobbyProvider(String lobbyId)
    : this._internal(
        (ref) => activateLobby(ref as ActivateLobbyRef, lobbyId),
        from: activateLobbyProvider,
        name: r'activateLobbyProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$activateLobbyHash,
        dependencies: ActivateLobbyFamily._dependencies,
        allTransitiveDependencies:
            ActivateLobbyFamily._allTransitiveDependencies,
        lobbyId: lobbyId,
      );

  ActivateLobbyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lobbyId,
  }) : super.internal();

  final String lobbyId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(ActivateLobbyRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ActivateLobbyProvider._internal(
        (ref) => create(ref as ActivateLobbyRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lobbyId: lobbyId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _ActivateLobbyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ActivateLobbyProvider && other.lobbyId == lobbyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lobbyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ActivateLobbyRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `lobbyId` of this provider.
  String get lobbyId;
}

class _ActivateLobbyProviderElement
    extends AutoDisposeFutureProviderElement<bool>
    with ActivateLobbyRef {
  _ActivateLobbyProviderElement(super.provider);

  @override
  String get lobbyId => (origin as ActivateLobbyProvider).lobbyId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
