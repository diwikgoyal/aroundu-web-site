// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_members_lobby_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$removeLobbyMemberHash() => r'b2aae6f941622a13907c21e25e3ad9411866081b';

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

/// See also [removeLobbyMember].
@ProviderFor(removeLobbyMember)
const removeLobbyMemberProvider = RemoveLobbyMemberFamily();

/// See also [removeLobbyMember].
class RemoveLobbyMemberFamily extends Family<AsyncValue<bool>> {
  /// See also [removeLobbyMember].
  const RemoveLobbyMemberFamily();

  /// See also [removeLobbyMember].
  RemoveLobbyMemberProvider call({
    required String lobbyId,
    required List<String> membersToRemove,
  }) {
    return RemoveLobbyMemberProvider(
      lobbyId: lobbyId,
      membersToRemove: membersToRemove,
    );
  }

  @override
  RemoveLobbyMemberProvider getProviderOverride(
    covariant RemoveLobbyMemberProvider provider,
  ) {
    return call(
      lobbyId: provider.lobbyId,
      membersToRemove: provider.membersToRemove,
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
  String? get name => r'removeLobbyMemberProvider';
}

/// See also [removeLobbyMember].
class RemoveLobbyMemberProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [removeLobbyMember].
  RemoveLobbyMemberProvider({
    required String lobbyId,
    required List<String> membersToRemove,
  }) : this._internal(
         (ref) => removeLobbyMember(
           ref as RemoveLobbyMemberRef,
           lobbyId: lobbyId,
           membersToRemove: membersToRemove,
         ),
         from: removeLobbyMemberProvider,
         name: r'removeLobbyMemberProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$removeLobbyMemberHash,
         dependencies: RemoveLobbyMemberFamily._dependencies,
         allTransitiveDependencies:
             RemoveLobbyMemberFamily._allTransitiveDependencies,
         lobbyId: lobbyId,
         membersToRemove: membersToRemove,
       );

  RemoveLobbyMemberProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lobbyId,
    required this.membersToRemove,
  }) : super.internal();

  final String lobbyId;
  final List<String> membersToRemove;

  @override
  Override overrideWith(
    FutureOr<bool> Function(RemoveLobbyMemberRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RemoveLobbyMemberProvider._internal(
        (ref) => create(ref as RemoveLobbyMemberRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lobbyId: lobbyId,
        membersToRemove: membersToRemove,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _RemoveLobbyMemberProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RemoveLobbyMemberProvider &&
        other.lobbyId == lobbyId &&
        other.membersToRemove == membersToRemove;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lobbyId.hashCode);
    hash = _SystemHash.combine(hash, membersToRemove.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RemoveLobbyMemberRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `lobbyId` of this provider.
  String get lobbyId;

  /// The parameter `membersToRemove` of this provider.
  List<String> get membersToRemove;
}

class _RemoveLobbyMemberProviderElement
    extends AutoDisposeFutureProviderElement<bool>
    with RemoveLobbyMemberRef {
  _RemoveLobbyMemberProviderElement(super.provider);

  @override
  String get lobbyId => (origin as RemoveLobbyMemberProvider).lobbyId;
  @override
  List<String> get membersToRemove =>
      (origin as RemoveLobbyMemberProvider).membersToRemove;
}

String _$invitePeopleInLobbyHash() =>
    r'1acca62bd42f0d1a9688370138d819718e9d94d4';

/// See also [invitePeopleInLobby].
@ProviderFor(invitePeopleInLobby)
const invitePeopleInLobbyProvider = InvitePeopleInLobbyFamily();

/// See also [invitePeopleInLobby].
class InvitePeopleInLobbyFamily extends Family<AsyncValue<bool>> {
  /// See also [invitePeopleInLobby].
  const InvitePeopleInLobbyFamily();

  /// See also [invitePeopleInLobby].
  InvitePeopleInLobbyProvider call({
    required String lobbyId,
    required List<String> friendsIds,
    required List<String> squadMembersIds,
  }) {
    return InvitePeopleInLobbyProvider(
      lobbyId: lobbyId,
      friendsIds: friendsIds,
      squadMembersIds: squadMembersIds,
    );
  }

  @override
  InvitePeopleInLobbyProvider getProviderOverride(
    covariant InvitePeopleInLobbyProvider provider,
  ) {
    return call(
      lobbyId: provider.lobbyId,
      friendsIds: provider.friendsIds,
      squadMembersIds: provider.squadMembersIds,
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
  String? get name => r'invitePeopleInLobbyProvider';
}

/// See also [invitePeopleInLobby].
class InvitePeopleInLobbyProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [invitePeopleInLobby].
  InvitePeopleInLobbyProvider({
    required String lobbyId,
    required List<String> friendsIds,
    required List<String> squadMembersIds,
  }) : this._internal(
         (ref) => invitePeopleInLobby(
           ref as InvitePeopleInLobbyRef,
           lobbyId: lobbyId,
           friendsIds: friendsIds,
           squadMembersIds: squadMembersIds,
         ),
         from: invitePeopleInLobbyProvider,
         name: r'invitePeopleInLobbyProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$invitePeopleInLobbyHash,
         dependencies: InvitePeopleInLobbyFamily._dependencies,
         allTransitiveDependencies:
             InvitePeopleInLobbyFamily._allTransitiveDependencies,
         lobbyId: lobbyId,
         friendsIds: friendsIds,
         squadMembersIds: squadMembersIds,
       );

  InvitePeopleInLobbyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lobbyId,
    required this.friendsIds,
    required this.squadMembersIds,
  }) : super.internal();

  final String lobbyId;
  final List<String> friendsIds;
  final List<String> squadMembersIds;

  @override
  Override overrideWith(
    FutureOr<bool> Function(InvitePeopleInLobbyRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: InvitePeopleInLobbyProvider._internal(
        (ref) => create(ref as InvitePeopleInLobbyRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lobbyId: lobbyId,
        friendsIds: friendsIds,
        squadMembersIds: squadMembersIds,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _InvitePeopleInLobbyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InvitePeopleInLobbyProvider &&
        other.lobbyId == lobbyId &&
        other.friendsIds == friendsIds &&
        other.squadMembersIds == squadMembersIds;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lobbyId.hashCode);
    hash = _SystemHash.combine(hash, friendsIds.hashCode);
    hash = _SystemHash.combine(hash, squadMembersIds.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin InvitePeopleInLobbyRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `lobbyId` of this provider.
  String get lobbyId;

  /// The parameter `friendsIds` of this provider.
  List<String> get friendsIds;

  /// The parameter `squadMembersIds` of this provider.
  List<String> get squadMembersIds;
}

class _InvitePeopleInLobbyProviderElement
    extends AutoDisposeFutureProviderElement<bool>
    with InvitePeopleInLobbyRef {
  _InvitePeopleInLobbyProviderElement(super.provider);

  @override
  String get lobbyId => (origin as InvitePeopleInLobbyProvider).lobbyId;
  @override
  List<String> get friendsIds =>
      (origin as InvitePeopleInLobbyProvider).friendsIds;
  @override
  List<String> get squadMembersIds =>
      (origin as InvitePeopleInLobbyProvider).squadMembersIds;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
