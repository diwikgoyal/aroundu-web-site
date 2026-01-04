import 'package:aroundu/utils/logger.utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/lobby.dart';

/// Provider that manages a list of forms
final formsListProvider = StateNotifierProvider<FormsListNotifier, List<FormModel>>((ref) => FormsListNotifier());

/// Notifier class for managing a list of forms
class FormsListNotifier extends StateNotifier<List<FormModel>> {
  // Map to store text controllers for each form's text questions
  final Map<String, Map<String, TextEditingController>> formTextControllers = {};

  FormsListNotifier() : super([]);

  /// Add a new form to the list
  void addForm(FormModel form) {
    // Generate a unique ID for the form if it doesn't have one
    final String formId = form.title.isNotEmpty ? form.title : 'Form ${state.length + 1}';

    // Initialize text controllers for this form's text questions
    formTextControllers[formId] = {};
    for (var question in form.questions) {
      kLogger.trace("message question provider : $question");

      if (question.questionType != 'multiple-choice') {
        formTextControllers[formId]![question.id] = TextEditingController(text: question.answer.toString());
      }
    }

    state = [...state, form];
  }

  /// Update an existing form in the list
  void updateForm(int index, FormModel updatedForm) {
    if (index >= 0 && index < state.length) {
      final newList = [...state];
      newList[index] = updatedForm;
      state = newList;

      // Update text controllers for this form
      final String formId = updatedForm.title.isNotEmpty ? updatedForm.title : 'Form ${index + 1}';

      // Create controllers for new text questions
      for (var question in updatedForm.questions) {
        if (question.questionType == 'text' && !formTextControllers[formId]!.containsKey(question.id)) {
          formTextControllers[formId]![question.id] = TextEditingController(text: question.answer);
        }
      }
    }
  }

  /// Remove a form from the list
  void removeForm(int index) {
    if (index >= 0 && index < state.length) {
      final formToRemove = state[index];
      final String formId = formToRemove.title.isNotEmpty ? formToRemove.title : 'Form ${index + 1}';

      // Dispose text controllers for this form
      if (formTextControllers.containsKey(formId)) {
        for (var controller in formTextControllers[formId]!.values) {
          controller.dispose();
        }
        formTextControllers.remove(formId);
      }

      final newList = [...state];
      newList.removeAt(index);
      state = newList;
    }
  }

  /// Get a form by index
  FormModel? getForm(int index) {
    if (index >= 0 && index < state.length) {
      return state[index];
    }
    return null;
  }

  /// Get a form by title
  FormModel? getFormByTitle(String title) {
    return state.firstWhere(
      (form) => form.title == title,
      orElse: () => const FormModel(title: '', questions: []),
    );
  }

  /// Update an answer in a specific form
  void updateAnswer(int formIndex, String questionId, String newAnswer) {
    if (formIndex >= 0 && formIndex < state.length) {
      final form = state[formIndex];
      final updatedQuestions = form.questions.map((question) {
        if (question.id == questionId) {
          return question.copyWith(answer: newAnswer);
        }
        return question;
      }).toList();

      final updatedForm = form.copyWith(questions: updatedQuestions);
      updateForm(formIndex, updatedForm);
    }
  }

  /// Get a text controller for a specific question in a form
  TextEditingController? getControllerForQuestion(int formIndex, String questionId) {
    if (formIndex >= 0 && formIndex < state.length) {
      final form = state[formIndex];

      final String formId = form.title.isNotEmpty ? form.title : 'Form ${formIndex + 1}';

      return formTextControllers[formId]?[questionId];
    }
    return null;
  }

  /// Check if all mandatory questions are answered in all forms
  String? validateAllForms() {
    if (state.isEmpty) return null; // Handle empty forms case

    for (var form in state) {
      for (var question in form.questions) {
        // Check mandatory questions have answers
        if (question.isMandatory && question.answer.trim().isEmpty) {
          return "Required field missing for question (form : ${state.indexOf(form) + 1}): \n${question.questionText}";
        }

        // Skip empty answers for non-mandatory questions
        if (question.answer.isEmpty && !question.isMandatory) {
          continue;
        }

        // Validate based on question type
        switch (question.questionType) {
          case 'email':
            if (question.answer.isNotEmpty) {
              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegex.hasMatch(question.answer)) {
                return "The provided email address format is invalid for the question: \n${question.questionText}\nPlease enter a valid email address (e.g., example@domain.com)";
              }
            }
            break;

          case 'number':
            if (question.answer.isNotEmpty) {
              final numberRegex = RegExp(r'^\d+$');
              if (!numberRegex.hasMatch(question.answer)) {
                return "The provided number format is invalid for the question: \n${question.questionText}\nPlease enter a valid numeric value without any special characters or decimals";
              }
            }
            break;

          case 'url':
            if (question.answer.isNotEmpty) {
              if (!_isValidUrl(question.answer)) {
                if (question.questionText.toLowerCase().contains("insta")) {
                  return null;
                } else {
                  return "The provided URL format is invalid for the question: \n${question.questionText}\nPlease enter a valid URL starting with http:// or https:// (e.g., https://www.example.com)";
                }
              }
            }
            break;

          case 'date':
            if (question.answer.isNotEmpty) {
              try {
                DateTime.parse(question.answer);
              } catch (e) {
                return "The provided date format is invalid for the question: \n${question.questionText}\nPlease enter a valid date in the format YYYY-MM-DD";
              }
            }
            break;

          case 'file':
            if (question.answer.isEmpty && question.isMandatory) {
              return "A file upload is required for the question: \n${question.questionText}\nPlease select and upload an appropriate file to continue";
            }
            break;

          case 'multiple-choice':
            if (question.answer.isNotEmpty && !question.options.contains(question.answer)) {
              return "The selected option is invalid for the multiple choice question: \n${question.questionText}\nPlease select one of the provided options";
            }
            break;
        }
      }
    }
    return null; // All validations passed
  }

  void makeUrlInstaUrl() {
    if (state.isEmpty) return; // Handle empty forms case

    for (var form in state) {
      for (var question in form.questions) {
        if (question.questionType == 'url' && question.answer.isNotEmpty) {
          final userResponse = question.answer.contains("@") ? question.answer.replaceAll("@", "") : question.answer;
          updateAnswer(state.indexOf(form), question.id, "https://www.instagram.com/$userResponse");
        }
      }
    }
    return;
  }

  /// Get the first mandatory question without an answer across all forms
  Map<String, String>? getMandatoryQuestionWithoutAnswer() {
    for (int i = 0; i < state.length; i++) {
      final form = state[i];
      for (final question in form.questions) {
        if (question.isMandatory && question.answer.isEmpty) {
          return {'formTitle': form.title, 'formIndex': i.toString(), 'questionText': question.questionText};
        }
      }
    }
    return null;
  }

  /// Reset all forms (clear all answers)
  void resetAllForms() {
    final updatedForms = state.map((form) {
      final clearedQuestions = form.questions.map((question) {
        return question.copyWith(answer: '');
      }).toList();
      return form.copyWith(questions: clearedQuestions);
    }).toList();

    // Clear all text controllers
    formTextControllers.forEach((formId, controllers) {
      controllers.forEach((id, controller) {
        controller.clear();
      });
    });

    state = updatedForms;
  }

  void resetFormsList() {
    // Dispose all text controllers
    formTextControllers.forEach((formId, controllers) {
      controllers.forEach((id, controller) {
        controller.dispose();
      });
    });
    formTextControllers.clear();
    state = [];
  }

  /// Get all forms data for submission
  List<Map<String, dynamic>> getAllFormsData() {
    return state.map((form) => form.toJson()).toList();
  }

  @override
  void dispose() {
    // Dispose all text controllers
    // formTextControllers.forEach((formId, controllers) {
    //   controllers.forEach((id, controller) {
    //     controller.dispose();
    //   });
    // });

    resetFormsList();

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
