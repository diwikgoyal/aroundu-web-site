import 'package:aroundu/utils/api_service/api.service.dart';
import 'package:aroundu/views/lobby/provider/selected_tickets_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Model class for pricing response
class PricingResponse {
  final int? code;
  final String? status;
  final String? message;
  final String? lobbyId;
  final int? currentMembers;
  final int? remainingSlots;
  final double? currentPricePerSlot;
  final String? currentTierRange;
  final String? nextTierInfo;
  final double? total;
  final String? pricingModel;
  final String? priceBreakdown;
  final bool? isTieredPriced;
  final int? lockedSlots;
  final int? currentPosition;
  final String? currentProvider;
  final List<Map<String, dynamic>> ticketSelections;

  PricingResponse({
    this.code,
    this.status,
    this.message,
    this.lobbyId,
    this.currentMembers,
    this.remainingSlots,
    this.currentPricePerSlot,
    this.currentTierRange,
    this.nextTierInfo,
    this.total,
    this.pricingModel,
    this.priceBreakdown,
    this.isTieredPriced,
    this.lockedSlots,
    this.currentPosition,
    this.currentProvider,
    this.ticketSelections = const [],
  });

  // Factory constructor to create a PricingResponse from JSON
  factory PricingResponse.fromJson(Map<String, dynamic> json) {
    return PricingResponse(
      code: json['code'],
      status: json['status'],
      message: json['message'],
      lobbyId: json['lobbyId'],
      currentMembers: json['currentMembers'],
      remainingSlots: json['remainingSlots'],
      currentPricePerSlot: json['currentPricePerSlot']?.toDouble(),
      currentTierRange: json['currentTierRange'],
      nextTierInfo: json['nextTierInfo'],
      total: json['total']?.toDouble() ,
      pricingModel: json['pricingModel'],
      priceBreakdown: json['priceBreakdown'],
      isTieredPriced: json['isTieredPriced'],
      lockedSlots: json['lockedSlots'],
      currentPosition: json['currentPosition'],
      currentProvider: json['currentProvider'],
      ticketSelections:
          (json['ticketSelections'] as List<dynamic>?)?.map((e) => Map<String, dynamic>.from(e)).toList() ?? [],
    );
  }

  // Method to convert PricingResponse to JSON
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'message': message,
      'lobbyId': lobbyId,
      'currentMembers': currentMembers,
      'remainingSlots': remainingSlots,
      'currentPricePerSlot': currentPricePerSlot,
      'currentTierRange': currentTierRange,
      'nextTierInfo': nextTierInfo,
      'total': total,
      'pricingModel': pricingModel,
      'priceBreakdown': priceBreakdown,
      'isTieredPriced': isTieredPriced ?? false,
      'lockedSlots': lockedSlots,
      'currentPosition': currentPosition,
      'currentProvider': currentProvider,
      'ticketSelections': ticketSelections,
    };
  }

  // Create a copy of PricingResponse with some fields updated
  PricingResponse copyWith({
    int? code,
    String? status,
    String? message,
    String? lobbyId,
    int? currentMembers,
    int? remainingSlots,
    double? currentPricePerSlot,
    String? currentTierRange,
    String? nextTierInfo,
    double? total,
    String? pricingModel,
    String? priceBreakdown,
    bool? isTieredPriced,
    int? lockedSlots,
    int? currentPosition,
    String? currentProvider,
    // List<Map<String, dynamic>>? ticketSelections,
  }) {
    return PricingResponse(
      code: code ?? this.code,
      status: status ?? this.status,
      message: message ?? this.message,
      lobbyId: lobbyId ?? this.lobbyId,
      currentMembers: currentMembers ?? this.currentMembers,
      remainingSlots: remainingSlots,
      currentPricePerSlot: currentPricePerSlot ?? this.currentPricePerSlot,
      currentTierRange: currentTierRange ?? this.currentTierRange,
      nextTierInfo: nextTierInfo ?? this.nextTierInfo,
      total: total ?? this.total,
      pricingModel: pricingModel ?? this.pricingModel,
      priceBreakdown: priceBreakdown ?? this.priceBreakdown,
      isTieredPriced: isTieredPriced ?? this.isTieredPriced,
      lockedSlots: lockedSlots ?? this.lockedSlots,
      currentPosition: currentPosition ?? this.currentPosition,
      currentProvider: currentProvider ?? this.currentProvider,
      ticketSelections: ticketSelections,
    );
  }
}

// State class for the pricing provider
class PricingState {
  final PricingResponse? pricingData;
  final bool isLoading;
  final String? error;

  PricingState({this.pricingData, this.isLoading = false, this.error});

  // Create a copy of PricingState with some fields updated
  PricingState copyWith({PricingResponse? pricingData, bool? isLoading, String? error}) {
    return PricingState(
      pricingData: pricingData ?? this.pricingData,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  // Initial state
  factory PricingState.initial() {
    return PricingState(pricingData: null, isLoading: false, error: null);
  }
}

// Notifier class for the pricing provider
class PricingNotifier extends StateNotifier<PricingState> {
  final ApiService _apiService;

  PricingNotifier(this._apiService) : super(PricingState.initial());

  // Fetch pricing data from API
  Future<void> fetchPricing(
    String lobbyId, {
    int? groupSize,
    List<SelectedTicket>? selectedTickets,
    bool isPublic = false,
  }) async {
    try {
      // Set loading state
      state = state.copyWith(isLoading: true, error: null);

      // Prepare query parameters
      Map<String, dynamic> body = {};
      if (groupSize != null) {
        if (selectedTickets != null && selectedTickets.isNotEmpty) {
          body['groupSize'] = selectedTickets.fold<int>(0, (sum, ticket) => sum + ticket.slots).toString();
        } else {
          body['groupSize'] = groupSize.toString();
        }
      }
      if (selectedTickets != null && selectedTickets.isNotEmpty) {
        body['ticketOptionsDTOS'] = selectedTickets.map((e) => e.toJson()).toList();
      }

      // Make API call
      Response response;
      if (isPublic) {
        response = await ApiService().post(
          'match/lobby/$lobbyId/pricing',
          body: body,
          // queryParameters: queryParams,
        );
      } else {
        response = await _apiService.post(
          'match/lobby/$lobbyId/pricing',
          body: body,
          // queryParameters: queryParams,
        );
      }

      // Parse response
      if (response.statusCode == 200) {
        final pricingResponse = PricingResponse.fromJson(response.data);
        state = state.copyWith(pricingData: pricingResponse, isLoading: false);
      } else {
        state = state.copyWith(isLoading: false, error: 'Failed to fetch pricing data: ${response.statusMessage}');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Error fetching pricing data: $e');
    }
  }

  // Reset pricing data
  void reset() {
    state = PricingState.initial();
  }

  // Update group size and refetch pricing
  Future<void> updateGroupSize(String lobbyId, int groupSize) async {
    await fetchPricing(lobbyId, groupSize: groupSize);
  }

  void updatePricingDataInState(PricingResponse pricingData) {
    state = state.copyWith(pricingData: pricingData);
  }
}

// Provider for the pricing state
final pricingProvider = StateNotifierProvider.family<PricingNotifier, PricingState, String>(
  (ref, lobbyId) => PricingNotifier(ApiService()),
);

// Provider to get the pricing data
final pricingDataProvider = Provider.family<PricingResponse?, String>(
  (ref, lobbyId) => ref.watch(pricingProvider(lobbyId)).pricingData,
);

// Provider to check if pricing is loading
final pricingLoadingProvider = Provider.family<bool, String>(
  (ref, lobbyId) => ref.watch(pricingProvider(lobbyId)).isLoading,
);

// Provider to get any pricing error
final pricingErrorProvider = Provider.family<String?, String>(
  (ref, lobbyId) => ref.watch(pricingProvider(lobbyId)).error,
);
