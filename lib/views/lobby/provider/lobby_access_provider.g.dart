// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lobby_access_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$handleLobbyAccessHash() => r'332ba365ba82d003c85f3b0717d95c22b9f34f3e';

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

/// See also [handleLobbyAccess].
@ProviderFor(handleLobbyAccess)
const handleLobbyAccessProvider = HandleLobbyAccessFamily();

/// See also [handleLobbyAccess].
class HandleLobbyAccessFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [handleLobbyAccess].
  const HandleLobbyAccessFamily();

  /// See also [handleLobbyAccess].
  HandleLobbyAccessProvider call(
    String lobbyId,
    bool isPrivate, {
    required bool hasForm,
    List<String>? groupId,
    List<String>? friends,
    String text = '',
    Map<String, dynamic> form = const {},
    List<Map<String, dynamic>> formList = const [],
    int? slots,
    String? offerId,
    List<SelectedTicket>? selectedTickets,
  }) {
    return HandleLobbyAccessProvider(
      lobbyId,
      isPrivate,
      hasForm: hasForm,
      groupId: groupId,
      friends: friends,
      text: text,
      form: form,
      formList: formList,
      slots: slots,
      offerId: offerId,
      selectedTickets: selectedTickets,
    );
  }

  @override
  HandleLobbyAccessProvider getProviderOverride(
    covariant HandleLobbyAccessProvider provider,
  ) {
    return call(
      provider.lobbyId,
      provider.isPrivate,
      hasForm: provider.hasForm,
      groupId: provider.groupId,
      friends: provider.friends,
      text: provider.text,
      form: provider.form,
      formList: provider.formList,
      slots: provider.slots,
      offerId: provider.offerId,
      selectedTickets: provider.selectedTickets,
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
  String? get name => r'handleLobbyAccessProvider';
}

/// See also [handleLobbyAccess].
class HandleLobbyAccessProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [handleLobbyAccess].
  HandleLobbyAccessProvider(
    String lobbyId,
    bool isPrivate, {
    required bool hasForm,
    List<String>? groupId,
    List<String>? friends,
    String text = '',
    Map<String, dynamic> form = const {},
    List<Map<String, dynamic>> formList = const [],
    int? slots,
    String? offerId,
    List<SelectedTicket>? selectedTickets,
  }) : this._internal(
         (ref) => handleLobbyAccess(
           ref as HandleLobbyAccessRef,
           lobbyId,
           isPrivate,
           hasForm: hasForm,
           groupId: groupId,
           friends: friends,
           text: text,
           form: form,
           formList: formList,
           slots: slots,
           offerId: offerId,
           selectedTickets: selectedTickets,
         ),
         from: handleLobbyAccessProvider,
         name: r'handleLobbyAccessProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$handleLobbyAccessHash,
         dependencies: HandleLobbyAccessFamily._dependencies,
         allTransitiveDependencies:
             HandleLobbyAccessFamily._allTransitiveDependencies,
         lobbyId: lobbyId,
         isPrivate: isPrivate,
         hasForm: hasForm,
         groupId: groupId,
         friends: friends,
         text: text,
         form: form,
         formList: formList,
         slots: slots,
         offerId: offerId,
         selectedTickets: selectedTickets,
       );

  HandleLobbyAccessProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lobbyId,
    required this.isPrivate,
    required this.hasForm,
    required this.groupId,
    required this.friends,
    required this.text,
    required this.form,
    required this.formList,
    required this.slots,
    required this.offerId,
    required this.selectedTickets,
  }) : super.internal();

  final String lobbyId;
  final bool isPrivate;
  final bool hasForm;
  final List<String>? groupId;
  final List<String>? friends;
  final String text;
  final Map<String, dynamic> form;
  final List<Map<String, dynamic>> formList;
  final int? slots;
  final String? offerId;
  final List<SelectedTicket>? selectedTickets;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(HandleLobbyAccessRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HandleLobbyAccessProvider._internal(
        (ref) => create(ref as HandleLobbyAccessRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lobbyId: lobbyId,
        isPrivate: isPrivate,
        hasForm: hasForm,
        groupId: groupId,
        friends: friends,
        text: text,
        form: form,
        formList: formList,
        slots: slots,
        offerId: offerId,
        selectedTickets: selectedTickets,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _HandleLobbyAccessProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HandleLobbyAccessProvider &&
        other.lobbyId == lobbyId &&
        other.isPrivate == isPrivate &&
        other.hasForm == hasForm &&
        other.groupId == groupId &&
        other.friends == friends &&
        other.text == text &&
        other.form == form &&
        other.formList == formList &&
        other.slots == slots &&
        other.offerId == offerId &&
        other.selectedTickets == selectedTickets;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lobbyId.hashCode);
    hash = _SystemHash.combine(hash, isPrivate.hashCode);
    hash = _SystemHash.combine(hash, hasForm.hashCode);
    hash = _SystemHash.combine(hash, groupId.hashCode);
    hash = _SystemHash.combine(hash, friends.hashCode);
    hash = _SystemHash.combine(hash, text.hashCode);
    hash = _SystemHash.combine(hash, form.hashCode);
    hash = _SystemHash.combine(hash, formList.hashCode);
    hash = _SystemHash.combine(hash, slots.hashCode);
    hash = _SystemHash.combine(hash, offerId.hashCode);
    hash = _SystemHash.combine(hash, selectedTickets.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HandleLobbyAccessRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `lobbyId` of this provider.
  String get lobbyId;

  /// The parameter `isPrivate` of this provider.
  bool get isPrivate;

  /// The parameter `hasForm` of this provider.
  bool get hasForm;

  /// The parameter `groupId` of this provider.
  List<String>? get groupId;

  /// The parameter `friends` of this provider.
  List<String>? get friends;

  /// The parameter `text` of this provider.
  String get text;

  /// The parameter `form` of this provider.
  Map<String, dynamic> get form;

  /// The parameter `formList` of this provider.
  List<Map<String, dynamic>> get formList;

  /// The parameter `slots` of this provider.
  int? get slots;

  /// The parameter `offerId` of this provider.
  String? get offerId;

  /// The parameter `selectedTickets` of this provider.
  List<SelectedTicket>? get selectedTickets;
}

class _HandleLobbyAccessProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with HandleLobbyAccessRef {
  _HandleLobbyAccessProviderElement(super.provider);

  @override
  String get lobbyId => (origin as HandleLobbyAccessProvider).lobbyId;
  @override
  bool get isPrivate => (origin as HandleLobbyAccessProvider).isPrivate;
  @override
  bool get hasForm => (origin as HandleLobbyAccessProvider).hasForm;
  @override
  List<String>? get groupId => (origin as HandleLobbyAccessProvider).groupId;
  @override
  List<String>? get friends => (origin as HandleLobbyAccessProvider).friends;
  @override
  String get text => (origin as HandleLobbyAccessProvider).text;
  @override
  Map<String, dynamic> get form => (origin as HandleLobbyAccessProvider).form;
  @override
  List<Map<String, dynamic>> get formList =>
      (origin as HandleLobbyAccessProvider).formList;
  @override
  int? get slots => (origin as HandleLobbyAccessProvider).slots;
  @override
  String? get offerId => (origin as HandleLobbyAccessProvider).offerId;
  @override
  List<SelectedTicket>? get selectedTickets =>
      (origin as HandleLobbyAccessProvider).selectedTickets;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
