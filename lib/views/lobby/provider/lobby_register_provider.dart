import 'package:aroundu/constants/urls.dart';
import 'package:aroundu/utils/api_service/api_service.dart';
import 'package:aroundu/utils/logger.utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// Response model for the lobby registration API
class LobbyRegistrationResponse {
  final String? id;
  final String? createdDate;
  final String? lastModifiedDate;
  final String? linkId;
  final String? paymentUrl;
  final String? transactionId;
  final double? amount;
  final String? currency;
  final String? status;
  final String? expiryDate;
  final String? customerName;
  final String? customerPhone;
  final String? customerEmail;

  LobbyRegistrationResponse({
    this.id,
    this.createdDate,
    this.lastModifiedDate,
    this.linkId,
    this.paymentUrl,
    this.transactionId,
    this.amount,
    this.currency,
    this.status,
    this.expiryDate,
    this.customerName,
    this.customerPhone,
    this.customerEmail,
  });

  factory LobbyRegistrationResponse.fromJson(Map<String, dynamic> json) {
    return LobbyRegistrationResponse(
      id: json['id'],
      createdDate: json['createdDate'],
      lastModifiedDate: json['lastModifiedDate'],
      linkId: json['linkId'],
      paymentUrl: json['paymentUrl'],
      transactionId: json['transactionId'],
      amount: json['amount']?.toDouble(),
      currency: json['currency'],
      status: json['status'],
      expiryDate: json['expiryDate'],
      customerName: json['customerName'],
      customerPhone: json['customerPhone'],
      customerEmail: json['customerEmail'],
    );
  }
}

// State class for the lobby registration
class LobbyRegistrationState {
  final bool isLoading;
  final String? error;
  final LobbyRegistrationResponse? response;

  const LobbyRegistrationState({this.isLoading = false, this.error, this.response});

  LobbyRegistrationState copyWith({bool? isLoading, String? error, LobbyRegistrationResponse? response}) {
    return LobbyRegistrationState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      response: response ?? this.response,
    );
  }
}

// Notifier class for the lobby registration
class LobbyRegistrationNotifier extends StateNotifier<LobbyRegistrationState> {
  LobbyRegistrationNotifier() : super(const LobbyRegistrationState());

  Future<LobbyRegistrationResponse?> registerGuest({
    required String lobbyId,
    required String name,
    required String mobile,
    required String email,
    required int slots,
    required String userId,
    Map<String, dynamic>? form,
    List<Map<String, dynamic>>? formList,
    List<Map<String, dynamic>>? selectedTickets,
    String? offerId,
    String? referralSource,
  }) async {
    kLogger.trace("in register tickets selected : $selectedTickets");
    try {
      // Set loading state
      state = state.copyWith(isLoading: true, error: null, response: null);

      // Create a custom Dio instance for this specific request
      final dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.arounduBaseUrl,
          headers: {
            'Authorization': 'dUZYZFRRS3VRZnp5TW53OlhBWmppcFhsVldVS1dmdw==',
            'source': 'internal',
            'Content-Type': 'application/json',
          },
        ),
      );

      dio.interceptors.add(PrettyDioLogger(requestBody: true));
      Map<String, dynamic> data = {'name': name, 'mobile': mobile, 'email': email, 'slots': slots, 'randomId': userId};
      if (form != null) {
        data['form'] = form;
      }
      if (formList != null && formList.isNotEmpty) {
        data['forms'] = formList;
      }
      if (selectedTickets != null && selectedTickets.isNotEmpty) {
        data['slots'] = selectedTickets.fold<int>(0, (sum, e) => sum + (e['slots'] as int));
        data['ticketOptionsDTOS'] = selectedTickets;
      }
      if (offerId != null) {
        data['offerId'] = offerId;
      }
      if (referralSource != null && referralSource.isNotEmpty) {
        data['referralSource'] = referralSource;
      }

      // Make the API call
      final response = await dio.post('payment/api/v1/guest/lobby/$lobbyId/register', data: data);

      kLogger.debug('Lobby registration response: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final registrationResponse = LobbyRegistrationResponse.fromJson(response.data);

        // Update state with response
        state = state.copyWith(isLoading: false, response: registrationResponse);

        return registrationResponse;
      } else {
        // Update state with error
        state = state.copyWith(isLoading: false, error: 'Failed to register for lobby: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Update state with error
      state = state.copyWith(isLoading: false, error: e.toString());
      kLogger.error('Error registering for lobby: $e');
      return null;
    }
  }
}

// Provider for the lobby registration state
final lobbyRegistrationProvider =
    StateNotifierProvider.family<LobbyRegistrationNotifier, LobbyRegistrationState, String>(
      (ref, lobbyId) => LobbyRegistrationNotifier(),
    );
