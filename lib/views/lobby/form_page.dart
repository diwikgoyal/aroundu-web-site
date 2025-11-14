import 'package:aroundu/constants/colors_palette.dart';
import 'package:aroundu/designs/widgets/chip.widgets.designs.dart';
import 'package:aroundu/designs/widgets/text.widget.designs.dart';
import 'package:aroundu/designs/widgets/textfield.widget.designs.dart';
import 'package:aroundu/utils/api_service/api.service.dart';
import 'package:aroundu/utils/logger.utils.dart';
import 'package:aroundu/views/lobby/provider/lobbies_providers.dart';
import 'package:aroundu/views/lobby/provider/lobbies_providers_util.dart';
import 'package:aroundu/views/lobby/provider/lobby_access_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../designs/colors.designs.dart';
import '../../designs/widgets/button.widget.designs.dart';
import '../../designs/widgets/space.widget.designs.dart';

import 'package:aroundu/models/lobby.dart';

class PreviewFormScreen extends StatelessWidget {
  final FormModel form;

  const PreviewFormScreen({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: DesignText(text: 'Preview', fontSize: 14, fontWeight: FontWeight.w500),
        scrolledUnderElevation: 0,
        backgroundColor: DesignColors.bg,
      ),
      body: Column(
        children: [
          DesignText(text: form.title, fontSize: 18, fontWeight: FontWeight.w500),
          Expanded(
            child: ListView.builder(
              itemCount: form.questions.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final question = form.questions[index];
                if (question.questionType == 'text') {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            DesignText(text: question.questionText, fontSize: 16),
                            if (question.isMandatory) DesignText(text: ' *', fontSize: 16, color: Colors.red),
                          ],
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: question.answer.isNotEmpty ? question.answer : ""),
                          enabled: false, // Make text field read-only
                        ),
                      ],
                    ),
                  );
                } else if (question.questionType == 'multiple-choice') {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DesignText(text: question.questionText, fontSize: 16),
                      ),
                      Column(
                        children: question.options.map((option) {
                          return RadioListTile(
                            title: Text(option),
                            value: option,
                            groupValue: question.answer,
                            onChanged: null, // Disable selection
                          );
                        }).toList(),
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Question2 {
  final String id;
  final String questionText;
  final String questionType;
  final List<String> options;
  final String answer;
  final bool isMandatory;
  final String questionLabel;
  final String dataKey;

  Question2({
    required this.id,
    required this.questionText,
    required this.questionType,
    required this.options,
    required this.answer,
    required this.isMandatory,
    required this.questionLabel,
    required this.dataKey,
  });

  factory Question2.fromJson(Map<String, dynamic> json) {
    return Question2(
      id: json['id'],
      questionText: json['questionText'],
      questionType: json['questionType'],
      options: List<String>.from(json['options']),
      answer: json['answer'] ?? '',
      isMandatory: json['isMandatory'],
      questionLabel: json['questionLabel'],
      dataKey: json['dataKey'],
    );
  }
}

class FormModel2 {
  final String title;
  final List<Question2> questions;

  FormModel2({required this.title, required this.questions});

  factory FormModel2.fromJson(Map<String, dynamic> json) {
    return FormModel2(
      title: json['title'],
      questions: (json['questions'] as List).map((question) => Question2.fromJson(question)).toList(),
    );
  }
}

final lobbyFormAutofillProvider =
    FutureProvider.family<Map<String, dynamic>, ({String lobbyId, List<String> selectedTicketIds})>((
      ref,
      params,
    ) async {
      try {
        final response = await ApiService().get(
          "match/lobby/${params.lobbyId}/form/autofill",
          queryParameters: {'ticketIds': params.selectedTicketIds},
        );

        if (response.data is String) {
          return {"userId": null, "title": "", "questions": []};
        } else {
          return response.data as Map<String, dynamic> ?? {};
        }

        // Assuming the response.data is already a Map<String, dynamic>
      } catch (e, stack) {
        kLogger.trace("Failed to load autofill data: $e \n $stack");
        throw "Failed to load autofill data: $e";
      }
    });

// Define providers for managing form state
final formStateProvider = StateNotifierProvider.family<FormStateNotifier, FormModel, String>(
  (ref, lobbyId) => FormStateNotifier(lobbyId: lobbyId, ref: ref),
);

// Form state notifier to manage the form data
class FormStateNotifier extends StateNotifier<FormModel> {
  final String lobbyId;
  final Ref ref;
  final Map<String, TextEditingController> textControllers = {};

  FormStateNotifier({required this.lobbyId, required this.ref}) : super(FormModel(title: 'Loading...', questions: [])) {
    // loadFormData();
  }

  Future<void> loadFormData(List<String> selectedTicketIds, {bool isPublic = false}) async {
    Map<String, dynamic> autofillData = {};
    try {
      if (isPublic) {
        autofillData = await getFormQuestions(lobbyId, selectedTicketIds: selectedTicketIds);
      } else {
        autofillData = await ref.read(
          lobbyFormAutofillProvider((lobbyId: lobbyId, selectedTicketIds: selectedTicketIds)).future,
        );
      }
      final List<Question> questions = [];

      if (autofillData.containsKey('questions') && autofillData['questions'] is List) {
        final formQuestions = autofillData['questions'] as List;

        for (var questionData in formQuestions) {
          // Create Question object using your existing model
          final question = Question.fromJson(questionData);
          questions.add(question);

          // Create and initialize text controllers with existing answers
          if (question.questionType != 'multiple-choice') {
            textControllers[question.id] = TextEditingController(text: question.answer);
          }
        }
      }

      state = FormModel(title: autofillData['title'] ?? 'Form', questions: questions);
      kLogger.trace("form state: $state");
    } catch (e, stack) {
      kLogger.trace("Error loading form data: $e \n $stack");
      state = FormModel(title: 'Error Loading Form', questions: []);
    }
  }

  void updateAnswer(String questionId, String newAnswer) {
    final updatedQuestions = state.questions.map((question) {
      if (question.id == questionId) {
        return question.copyWith(answer: newAnswer);
      }
      return question;
    }).toList();

    state = state.copyWith(questions: updatedQuestions);
  }

  TextEditingController? getControllerForQuestion(String questionId) {
    return textControllers[questionId];
  }

  List<Question> getQuestionsWithAnswers() {
    return state.questions;
  }

  bool validateForm() {
    return !state.questions.any((question) => question.isMandatory && question.answer.isEmpty);
  }

  String? getMandatoryQuestionWithoutAnswer() {
    kLogger.trace("checking for unanswered mandatory questions : $state");
    for (final question in state.questions) {
      if (question.isMandatory && question.answer.isEmpty) {
        return question.questionText;
      }
    }
    return null;
  }

  String? validateQuestionAnswersFormat() {
    kLogger.trace("checking format of question answers: $state");
    for (final question in state.questions) {
      // Skip empty answers for non-mandatory questions
      if (question.answer.isEmpty && !question.isMandatory) {
        continue;
      }

      // Validate based on question type
      switch (question.questionType) {
        case 'email':
          // Email validation
          if (question.answer.isNotEmpty) {
            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            if (!emailRegex.hasMatch(question.answer)) {
              return "Invalid email format for question: \n${question.questionText}";
            }
          }
          break;

        case 'number':
          // Number validation
          if (question.answer.isNotEmpty) {
            final numberRegex = RegExp(r'^\d+$');
            if (!numberRegex.hasMatch(question.answer)) {
              return "Invalid number format for question: \n${question.questionText}";
            }
          }
          break;

        case 'url':
          // URL validation
          if (question.answer.isNotEmpty) {
            // Uri? uri = Uri.tryParse(question.answer);
            if (!_isValidUrl(question.answer)) {
              return "Invalid URL format for question: \n${question.questionText}";
            }
          }
          break;

        case 'date':
          // Date validation
          if (question.answer.isNotEmpty) {
            try {
              DateTime.parse(question.answer);
            } catch (e) {
              return "Invalid date format for question: \n${question.questionText}";
            }
          }
          break;

        case 'file':
          // File validation - check if URL is not empty
          if (question.answer.isEmpty && question.isMandatory) {
            return "File upload required for question: \n${question.questionText}";
          }
          break;

        case 'multiple-choice':
          // Multiple choice validation - check if answer is one of the options
          if (question.answer.isNotEmpty && !question.options.contains(question.answer)) {
            return "Invalid selection for question: \n${question.questionText}";
          }
          break;
      }
    }
    return null;
  }

  Future<void> reloadFormData(List<String> selectedTicketIds) async {
    state = FormModel(title: '', questions: []);
    await ref.refresh(lobbyFormAutofillProvider((lobbyId: lobbyId, selectedTicketIds: selectedTicketIds)).future).then((
      data,
    ) {
      print("autofill refreshed");
    });
    loadFormData(selectedTicketIds);
  }

  void resetForm() {
    // Clear all answers
    final clearedQuestions = state.questions.map((question) {
      return question.copyWith(answer: '');
    }).toList();

    // Update state
    state = state.copyWith(questions: clearedQuestions);

    // Clear all text controllers
    textControllers.forEach((id, controller) {
      controller.clear();
    });
  }

  @override
  void dispose() {
    // Dispose all text controllers
    for (var controller in textControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  bool _isValidUrl(String url) {
    if (url.isEmpty || url.trim().isEmpty) return false;

    String cleanUrl = url.trim();

    // Basic sanity checks
    if (cleanUrl.length < 3 ||
        cleanUrl.contains(' ') ||
        cleanUrl.contains('\n') ||
        cleanUrl.contains('\t') ||
        cleanUrl.contains('\r')) {
      return false;
    }

    // Remove protocol if present to check the domain part
    String domainPart = cleanUrl;
    bool hasProtocol = false;

    if (cleanUrl.startsWith('http://')) {
      domainPart = cleanUrl.substring(7);
      hasProtocol = true;
    } else if (cleanUrl.startsWith('https://')) {
      domainPart = cleanUrl.substring(8);
      hasProtocol = true;
    }

    // Remove path, query, and fragment to isolate domain
    domainPart = domainPart.split('/')[0].split('?')[0].split('#')[0];

    // Handle port
    String domain = domainPart.split(':')[0];

    // Domain must not be empty after all parsing
    if (domain.isEmpty) return false;

    // Validate the domain structure BEFORE trying Uri.parse
    if (!_isValidDomainStructure(domain)) {
      return false;
    }

    // Now try to parse with https if no protocol
    String urlToParse = hasProtocol ? cleanUrl : 'https://$cleanUrl';

    // Additional attempt with www if needed
    if (!hasProtocol && !cleanUrl.startsWith('www.') && !_isIpAddress(domain)) {
      String urlWithWww = 'https://www.$cleanUrl';
      Uri? uriWithWww = Uri.tryParse(urlWithWww);
      if (uriWithWww != null && _isValidParsedUri(uriWithWww)) {
        return true;
      }
    }

    Uri? uri = Uri.tryParse(urlToParse);
    return uri != null && _isValidParsedUri(uri);
  }

  bool _isValidDomainStructure(String domain) {
    if (domain.isEmpty || domain.length > 253) return false;

    // Handle localhost
    if (domain == 'localhost') return true;

    // Check if it's an IP address
    if (_isIpAddress(domain)) {
      return _isValidIpAddress(domain);
    }

    // For domain names, must contain at least one dot
    if (!domain.contains('.')) return false;

    // Cannot start or end with dot or hyphen
    if (domain.startsWith('.') || domain.endsWith('.') || domain.startsWith('-') || domain.endsWith('-')) {
      return false;
    }

    // Cannot contain consecutive dots
    if (domain.contains('..')) return false;

    // Split into labels and validate each
    final labels = domain.split('.');
    if (labels.length < 2) return false;

    for (int i = 0; i < labels.length; i++) {
      final label = labels[i];
      if (!_isValidDomainLabel(label, i == labels.length - 1)) {
        return false;
      }
    }

    return true;
  }

  bool _isValidDomainLabel(String label, bool isTLD) {
    if (label.isEmpty || label.length > 63) return false;

    // Cannot start or end with hyphen
    if (label.startsWith('-') || label.endsWith('-')) return false;

    // Must contain only alphanumeric characters and hyphens
    if (!RegExp(r'^[a-zA-Z0-9-]+$').hasMatch(label)) return false;

    // If it's a TLD (last label), additional validation
    if (isTLD) {
      // TLD must be at least 2 characters
      if (label.length < 2) return false;

      // TLD should contain at least one letter
      if (!RegExp(r'[a-zA-Z]').hasMatch(label)) return false;

      // Common valid TLD patterns - reject obvious random strings
      if (!_isValidTLD(label)) return false;
    } else {
      // Non-TLD labels cannot be all hyphens or have weird patterns
      if (RegExp(r'^-+$').hasMatch(label)) return false;
    }

    return true;
  }

  bool _isValidTLD(String tld) {
    // Convert to lowercase for checking
    String lowerTLD = tld.toLowerCase();

    // List of definitely invalid TLDs (random letter combinations)
    final obviouslyInvalid = {
      'aa',
      'bb',
      'cc',
      'dd',
      'ee',
      'ff',
      'gg',
      'hh',
      'ii',
      'jj',
      'kk',
      'll',
      'mm',
      'nn',
      'oo',
      'pp',
      'qq',
      'rr',
      'ss',
      'tt',
      'uu',
      'vv',
      'ww',
      'xx',
      'yy',
      'zz',
      'aaa',
      'bbb',
      'ccc',
      'ddd',
      'eee',
      'fff',
      'ggg',
      'hhh',
      'iii',
      'jjj',
      'kkk',
      'lll',
      'mmm',
      'nnn',
      'ooo',
      'ppp',
      'qqq',
      'rrr',
      'sss',
      'ttt',
      'uuu',
      'vvv',
      'www',
      'xxx',
      'yyy',
      'zzz',
    };

    if (obviouslyInvalid.contains(lowerTLD)) return false;

    // Check for common valid TLD patterns
    // Real TLDs usually have meaningful patterns
    final commonValidTLDs = {
      'com',
      'org',
      'net',
      'gov',
      'edu',
      'mil',
      'int',
      'co',
      'io',
      'ai',
      'me',
      'uk',
      'us',
      'ca',
      'au',
      'de',
      'fr',
      'jp',
      'cn',
      'in',
      'br',
      'mx',
      'ru',
      'info',
      'biz',
      'name',
      'pro',
      'aero',
      'asia',
      'cat',
      'coop',
      'jobs',
      'mobi',
      'museum',
      'post',
      'tel',
      'travel',
      'xxx',
      'app',
      'dev',
      'tech',
      'online',
      'site',
      'website',
      'store',
      'blog',
      'news',
      'today',
      'world',
    };

    // If it's a common valid TLD, accept it
    if (commonValidTLDs.contains(lowerTLD)) return true;

    // For other TLDs, check if they look reasonable
    // Real TLDs typically:
    // 1. Are not random character sequences
    // 2. Have vowels and consonants mixed reasonably
    // 3. Don't have repeating patterns

    // Check for reasonable letter distribution
    if (lowerTLD.length >= 3) {
      // Count vowels
      int vowels = 0;
      for (int i = 0; i < lowerTLD.length; i++) {
        if ('aeiou'.contains(lowerTLD[i])) vowels++;
      }

      // Should have at least one vowel for longer TLDs
      if (vowels == 0 && lowerTLD.length > 3) return false;

      // Check for excessive repetition
      if (RegExp(r'(.)\1{2,}').hasMatch(lowerTLD)) return false;
    }

    // If it passes basic checks and isn't obviously invalid, accept it
    return true;
  }

  bool _isIpAddress(String host) {
    // IPv4 pattern
    if (RegExp(r'^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$').hasMatch(host)) {
      return true;
    }

    // Basic IPv6 pattern (simplified)
    if (host.contains(':') && RegExp(r'^[0-9a-fA-F:]+$').hasMatch(host)) {
      return true;
    }

    return false;
  }

  bool _isValidIpAddress(String host) {
    // IPv4 validation
    final ipv4Pattern = RegExp(r'^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$');
    final match = ipv4Pattern.firstMatch(host);

    if (match != null) {
      for (int i = 1; i <= 4; i++) {
        final octet = int.tryParse(match.group(i)!);
        if (octet == null || octet < 0 || octet > 255) {
          return false;
        }
      }
      return true;
    }

    // IPv6 basic validation
    if (host.contains(':')) {
      final parts = host.split(':');
      if (parts.length > 8) return false;

      for (final part in parts) {
        if (part.isNotEmpty && (part.length > 4 || !RegExp(r'^[0-9a-fA-F]+$').hasMatch(part))) {
          return false;
        }
      }
      return true;
    }

    return false;
  }

  bool _isValidParsedUri(Uri uri) {
    // Must be http or https
    if (uri.scheme != 'http' && uri.scheme != 'https') return false;

    // Must have a valid host
    if (uri.host.isEmpty) return false;

    // Final validation of the host
    return _isValidDomainStructure(uri.host);
  }
}

Future<dynamic> getFormQuestions(String lobbyId, {List<String> selectedTicketIds = const []}) async {
  try {
    Map<String, dynamic> query = {};
    if (selectedTicketIds.isNotEmpty) {
      query['ticketIds'] = selectedTicketIds;
    }
    final response = await ApiService().get(
      'match/lobby/$lobbyId/form',
      queryParameters: query,
    );

    kLogger.trace("get form called : $response");

    if (response.statusCode == 200) {
      print(response.data);
      // final data = (response.data as List)
      //     .map((json) => MyAuraModel.fromJson(json))
      //     .toList();
      return response.data;
    } else {
      throw Exception('Failed to load case History data');
    }
  } catch (error, stack) {
    print("Error fetching case History data: $error \n $stack");
    rethrow;
  }
}

final requestTextProvider = StateProvider<String>((ref) => '');

class AnswerFormScreen extends ConsumerWidget {
  final Lobby lobby;
  final String groupId;

  const AnswerFormScreen({super.key, required this.lobby, required this.groupId});

  void _submitResponses(BuildContext context, WidgetRef ref) async {
    final formNotifier = ref.read(formStateProvider(lobby.id).notifier);
    final requestText = ref.read(requestTextProvider);

    // Check if the message is empty
    if (requestText.isEmpty) {
      Get.snackbar("Error", "Message cannot be empty");
      return;
    }

    // Check if all mandatory questions have been answered
    final missingQuestion = formNotifier.getMandatoryQuestionWithoutAnswer();
    if (missingQuestion != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Incomplete Form"),
          content: Text("Please answer the mandatory question: $missingQuestion"),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))],
        ),
      );
      return;
    }

    try {
      // Get final list of questions with their answers
      final finalQuestions = formNotifier.getQuestionsWithAnswers();

      // Convert to JSON for submission
      final formModel = FormModel(title: ref.read(formStateProvider(lobby.id)).title, questions: finalQuestions);

      // Submit the form
      await ref.read(
        handleLobbyAccessProvider(
          lobby.id,
          lobby.isPrivate,
          friends: [],
          groupId: [groupId],
          text: requestText,
          form: formModel.toJson(),
          hasForm: true,
        ).future,
      );

      ref.invalidate(LobbyProviderUtil.getProvider(LobbyType.joined));

      // Close the bottom sheet after successful submission
      Navigator.pop(context);
    } catch (e) {
      // Handle submission errors
      Get.snackbar("Error", "Failed to submit form: ${e.toString()}", snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(formStateProvider(lobby.id));
    final formNotifier = ref.watch(formStateProvider(lobby.id).notifier);

    return Column(
      children: [
        // Request message section
        Align(
          alignment: Alignment.centerLeft,
          child: DesignText(
            text: "Send the Admin a message with your request",
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: DesignColors.secondary,
          ),
        ),
        const Space.h(height: 8),

        // Request text field
        TextField(
          onChanged: (value) {
            ref.read(requestTextProvider.notifier).state = value;
          },
          maxLines: 5,
          decoration: const InputDecoration(
            alignLabelWithHint: true,
            labelText: 'Enter Request Message',
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6.0))),
          ),
        ),
        const Space.h(height: 16),

        // Form title
        Align(
          alignment: Alignment.centerLeft,
          child: DesignText(text: formState.title, fontSize: 16, fontWeight: FontWeight.w500),
        ),

        // Form questions
        SizedBox(
          height: 0.4,
          child: formState.questions.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: formState.questions.length,
                  itemBuilder: (context, index) {
                    final question = formState.questions[index];

                    // Text question
                    if (question.questionType == 'text') {
                      final controller = formNotifier.getControllerForQuestion(question.id);

                      if (controller == null) {
                        return const SizedBox.shrink();
                      }

                      // Make sure controller has the latest value
                      if (controller.text != question.answer) {
                        controller.text = question.answer;
                      }

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(child: DesignText(text: question.questionText, fontSize: 14)),
                                if (question.isMandatory) DesignText(text: ' *', fontSize: 14, color: Colors.red),
                              ],
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: controller,
                              decoration: const InputDecoration(labelText: "Answer", border: OutlineInputBorder()),
                              onChanged: (val) => formNotifier.updateAnswer(question.id, val),
                            ),
                          ],
                        ),
                      );
                    }
                    // Multiple choice question
                    else if (question.questionType == 'multiple-choice') {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(child: DesignText(text: question.questionText, fontSize: 14)),
                                if (question.isMandatory) DesignText(text: ' *', fontSize: 14, color: Colors.red),
                              ],
                            ),
                            const SizedBox(height: 4),
                            ...question.options.map((option) {
                              return RadioListTile<String>(
                                title: Text(option),
                                value: option,
                                groupValue: question.answer,
                                onChanged: (val) {
                                  if (val != null) {
                                    formNotifier.updateAnswer(question.id, val);
                                  }
                                },
                                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                              );
                            }).toList(),
                          ],
                        ),
                      );
                    }

                    // Default fallback for unsupported question types
                    return Container();
                  },
                ),
        ),

        // Submit button
        const Space.h(height: 16),
        DesignButton(
          onPress: () => _submitResponses(context, ref),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          title: 'Request Access',
          titleSize: 12,
        ),
      ],
    );
  }
}
