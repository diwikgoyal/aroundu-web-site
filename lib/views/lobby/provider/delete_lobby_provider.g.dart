// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_lobby_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$deleteLobbyHash() => r'a4a1343b15428547885273ca898ffada74d0488a';

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

/// See also [deleteLobby].
@ProviderFor(deleteLobby)
const deleteLobbyProvider = DeleteLobbyFamily();

/// See also [deleteLobby].
class DeleteLobbyFamily extends Family<AsyncValue<bool>> {
  /// See also [deleteLobby].
  const DeleteLobbyFamily();

  /// See also [deleteLobby].
  DeleteLobbyProvider call(String lobbyId) {
    return DeleteLobbyProvider(lobbyId);
  }

  @override
  DeleteLobbyProvider getProviderOverride(
    covariant DeleteLobbyProvider provider,
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
  String? get name => r'deleteLobbyProvider';
}

/// See also [deleteLobby].
class DeleteLobbyProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [deleteLobby].
  DeleteLobbyProvider(String lobbyId)
    : this._internal(
        (ref) => deleteLobby(ref as DeleteLobbyRef, lobbyId),
        from: deleteLobbyProvider,
        name: r'deleteLobbyProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$deleteLobbyHash,
        dependencies: DeleteLobbyFamily._dependencies,
        allTransitiveDependencies: DeleteLobbyFamily._allTransitiveDependencies,
        lobbyId: lobbyId,
      );

  DeleteLobbyProvider._internal(
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
    FutureOr<bool> Function(DeleteLobbyRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteLobbyProvider._internal(
        (ref) => create(ref as DeleteLobbyRef),
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
    return _DeleteLobbyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteLobbyProvider && other.lobbyId == lobbyId;
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
mixin DeleteLobbyRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `lobbyId` of this provider.
  String get lobbyId;
}

class _DeleteLobbyProviderElement extends AutoDisposeFutureProviderElement<bool>
    with DeleteLobbyRef {
  _DeleteLobbyProviderElement(super.provider);

  @override
  String get lobbyId => (origin as DeleteLobbyProvider).lobbyId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
