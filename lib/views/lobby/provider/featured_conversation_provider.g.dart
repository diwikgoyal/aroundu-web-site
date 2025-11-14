// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'featured_conversation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$askQuestionHash() => r'ae198f3a878c6a3b72438f6fa20469ba437e3f24';

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

/// See also [askQuestion].
@ProviderFor(askQuestion)
const askQuestionProvider = AskQuestionFamily();

/// See also [askQuestion].
class AskQuestionFamily extends Family<AsyncValue<bool>> {
  /// See also [askQuestion].
  const AskQuestionFamily();

  /// See also [askQuestion].
  AskQuestionProvider call(String lobbyId, String question) {
    return AskQuestionProvider(lobbyId, question);
  }

  @override
  AskQuestionProvider getProviderOverride(
    covariant AskQuestionProvider provider,
  ) {
    return call(provider.lobbyId, provider.question);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'askQuestionProvider';
}

/// See also [askQuestion].
class AskQuestionProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [askQuestion].
  AskQuestionProvider(String lobbyId, String question)
    : this._internal(
        (ref) => askQuestion(ref as AskQuestionRef, lobbyId, question),
        from: askQuestionProvider,
        name: r'askQuestionProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$askQuestionHash,
        dependencies: AskQuestionFamily._dependencies,
        allTransitiveDependencies: AskQuestionFamily._allTransitiveDependencies,
        lobbyId: lobbyId,
        question: question,
      );

  AskQuestionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lobbyId,
    required this.question,
  }) : super.internal();

  final String lobbyId;
  final String question;

  @override
  Override overrideWith(
    FutureOr<bool> Function(AskQuestionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AskQuestionProvider._internal(
        (ref) => create(ref as AskQuestionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lobbyId: lobbyId,
        question: question,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _AskQuestionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AskQuestionProvider &&
        other.lobbyId == lobbyId &&
        other.question == question;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lobbyId.hashCode);
    hash = _SystemHash.combine(hash, question.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AskQuestionRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `lobbyId` of this provider.
  String get lobbyId;

  /// The parameter `question` of this provider.
  String get question;
}

class _AskQuestionProviderElement extends AutoDisposeFutureProviderElement<bool>
    with AskQuestionRef {
  _AskQuestionProviderElement(super.provider);

  @override
  String get lobbyId => (origin as AskQuestionProvider).lobbyId;
  @override
  String get question => (origin as AskQuestionProvider).question;
}

String _$answerQuestionHash() => r'c03fbde379ff38bb8f6b820d4fc093da887f1a89';

/// See also [answerQuestion].
@ProviderFor(answerQuestion)
const answerQuestionProvider = AnswerQuestionFamily();

/// See also [answerQuestion].
class AnswerQuestionFamily extends Family<AsyncValue<bool>> {
  /// See also [answerQuestion].
  const AnswerQuestionFamily();

  /// See also [answerQuestion].
  AnswerQuestionProvider call(
    String lobbyId,
    String questionId,
    String answer,
  ) {
    return AnswerQuestionProvider(lobbyId, questionId, answer);
  }

  @override
  AnswerQuestionProvider getProviderOverride(
    covariant AnswerQuestionProvider provider,
  ) {
    return call(provider.lobbyId, provider.questionId, provider.answer);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'answerQuestionProvider';
}

/// See also [answerQuestion].
class AnswerQuestionProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [answerQuestion].
  AnswerQuestionProvider(String lobbyId, String questionId, String answer)
    : this._internal(
        (ref) => answerQuestion(
          ref as AnswerQuestionRef,
          lobbyId,
          questionId,
          answer,
        ),
        from: answerQuestionProvider,
        name: r'answerQuestionProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$answerQuestionHash,
        dependencies: AnswerQuestionFamily._dependencies,
        allTransitiveDependencies:
            AnswerQuestionFamily._allTransitiveDependencies,
        lobbyId: lobbyId,
        questionId: questionId,
        answer: answer,
      );

  AnswerQuestionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lobbyId,
    required this.questionId,
    required this.answer,
  }) : super.internal();

  final String lobbyId;
  final String questionId;
  final String answer;

  @override
  Override overrideWith(
    FutureOr<bool> Function(AnswerQuestionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AnswerQuestionProvider._internal(
        (ref) => create(ref as AnswerQuestionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lobbyId: lobbyId,
        questionId: questionId,
        answer: answer,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _AnswerQuestionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AnswerQuestionProvider &&
        other.lobbyId == lobbyId &&
        other.questionId == questionId &&
        other.answer == answer;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lobbyId.hashCode);
    hash = _SystemHash.combine(hash, questionId.hashCode);
    hash = _SystemHash.combine(hash, answer.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AnswerQuestionRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `lobbyId` of this provider.
  String get lobbyId;

  /// The parameter `questionId` of this provider.
  String get questionId;

  /// The parameter `answer` of this provider.
  String get answer;
}

class _AnswerQuestionProviderElement
    extends AutoDisposeFutureProviderElement<bool>
    with AnswerQuestionRef {
  _AnswerQuestionProviderElement(super.provider);

  @override
  String get lobbyId => (origin as AnswerQuestionProvider).lobbyId;
  @override
  String get questionId => (origin as AnswerQuestionProvider).questionId;
  @override
  String get answer => (origin as AnswerQuestionProvider).answer;
}

String _$getFeaturedConversationsHash() =>
    r'4a462954c5d8f014f367881606409363181be969';

/// See also [getFeaturedConversations].
@ProviderFor(getFeaturedConversations)
const getFeaturedConversationsProvider = GetFeaturedConversationsFamily();

/// See also [getFeaturedConversations].
class GetFeaturedConversationsFamily
    extends Family<AsyncValue<List<ConversationQuestion>>> {
  /// See also [getFeaturedConversations].
  const GetFeaturedConversationsFamily();

  /// See also [getFeaturedConversations].
  GetFeaturedConversationsProvider call(String lobbyId) {
    return GetFeaturedConversationsProvider(lobbyId);
  }

  @override
  GetFeaturedConversationsProvider getProviderOverride(
    covariant GetFeaturedConversationsProvider provider,
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
  String? get name => r'getFeaturedConversationsProvider';
}

/// See also [getFeaturedConversations].
class GetFeaturedConversationsProvider
    extends AutoDisposeFutureProvider<List<ConversationQuestion>> {
  /// See also [getFeaturedConversations].
  GetFeaturedConversationsProvider(String lobbyId)
    : this._internal(
        (ref) => getFeaturedConversations(
          ref as GetFeaturedConversationsRef,
          lobbyId,
        ),
        from: getFeaturedConversationsProvider,
        name: r'getFeaturedConversationsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$getFeaturedConversationsHash,
        dependencies: GetFeaturedConversationsFamily._dependencies,
        allTransitiveDependencies:
            GetFeaturedConversationsFamily._allTransitiveDependencies,
        lobbyId: lobbyId,
      );

  GetFeaturedConversationsProvider._internal(
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
    FutureOr<List<ConversationQuestion>> Function(
      GetFeaturedConversationsRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetFeaturedConversationsProvider._internal(
        (ref) => create(ref as GetFeaturedConversationsRef),
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
  AutoDisposeFutureProviderElement<List<ConversationQuestion>> createElement() {
    return _GetFeaturedConversationsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetFeaturedConversationsProvider &&
        other.lobbyId == lobbyId;
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
mixin GetFeaturedConversationsRef
    on AutoDisposeFutureProviderRef<List<ConversationQuestion>> {
  /// The parameter `lobbyId` of this provider.
  String get lobbyId;
}

class _GetFeaturedConversationsProviderElement
    extends AutoDisposeFutureProviderElement<List<ConversationQuestion>>
    with GetFeaturedConversationsRef {
  _GetFeaturedConversationsProviderElement(super.provider);

  @override
  String get lobbyId => (origin as GetFeaturedConversationsProvider).lobbyId;
}

String _$getAllQuestionsHash() => r'e981265269ef2a9570dabdc183ad3bd194ba5631';

/// See also [getAllQuestions].
@ProviderFor(getAllQuestions)
const getAllQuestionsProvider = GetAllQuestionsFamily();

/// See also [getAllQuestions].
class GetAllQuestionsFamily
    extends Family<AsyncValue<List<ConversationQuestion>>> {
  /// See also [getAllQuestions].
  const GetAllQuestionsFamily();

  /// See also [getAllQuestions].
  GetAllQuestionsProvider call(String lobbyId) {
    return GetAllQuestionsProvider(lobbyId);
  }

  @override
  GetAllQuestionsProvider getProviderOverride(
    covariant GetAllQuestionsProvider provider,
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
  String? get name => r'getAllQuestionsProvider';
}

/// See also [getAllQuestions].
class GetAllQuestionsProvider
    extends AutoDisposeFutureProvider<List<ConversationQuestion>> {
  /// See also [getAllQuestions].
  GetAllQuestionsProvider(String lobbyId)
    : this._internal(
        (ref) => getAllQuestions(ref as GetAllQuestionsRef, lobbyId),
        from: getAllQuestionsProvider,
        name: r'getAllQuestionsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$getAllQuestionsHash,
        dependencies: GetAllQuestionsFamily._dependencies,
        allTransitiveDependencies:
            GetAllQuestionsFamily._allTransitiveDependencies,
        lobbyId: lobbyId,
      );

  GetAllQuestionsProvider._internal(
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
    FutureOr<List<ConversationQuestion>> Function(GetAllQuestionsRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetAllQuestionsProvider._internal(
        (ref) => create(ref as GetAllQuestionsRef),
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
  AutoDisposeFutureProviderElement<List<ConversationQuestion>> createElement() {
    return _GetAllQuestionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetAllQuestionsProvider && other.lobbyId == lobbyId;
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
mixin GetAllQuestionsRef
    on AutoDisposeFutureProviderRef<List<ConversationQuestion>> {
  /// The parameter `lobbyId` of this provider.
  String get lobbyId;
}

class _GetAllQuestionsProviderElement
    extends AutoDisposeFutureProviderElement<List<ConversationQuestion>>
    with GetAllQuestionsRef {
  _GetAllQuestionsProviderElement(super.provider);

  @override
  String get lobbyId => (origin as GetAllQuestionsProvider).lobbyId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
