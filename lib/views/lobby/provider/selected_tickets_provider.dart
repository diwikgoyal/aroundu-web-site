import 'package:aroundu/models/lobby.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SelectedTicket {
  final String ticketId;
  final String name;
  final int slots;

  SelectedTicket({required this.ticketId, required this.name, required this.slots});

  SelectedTicket copyWith({String? ticketId, String? name, int? slots}) {
    return SelectedTicket(ticketId: ticketId ?? this.ticketId, name: name ?? this.name, slots: slots ?? this.slots);
  }

  Map<String, dynamic> toJson() {
    return {'ticketId': ticketId, 'name': name, 'slots': slots};
  }

  @override
  String toString() {
    return "SelectedTicket(ticketId: $ticketId, name: $name, slots: $slots)";
  }
}

class SelectedTicketsNotifier extends StateNotifier<Map<String, List<SelectedTicket>>> {
  SelectedTicketsNotifier() : super({});

  void addTicket({
    required String lobbyId,
    required bool isMultiplePricing,
    required LobbyTicketOption ticketOption,
    int slots = 1,
  }) {
    final maxSlots = ticketOption.maxQuantity;
    final clampedSlots = slots.clamp(0, maxSlots);

    if (ticketOption.totalSlots == ticketOption.bookedSlots) {
      Fluttertoast.showToast(msg: "Sorry, this ticket is currently sold out.");
      removeTicket(lobbyId: lobbyId, ticketId: ticketOption.id);
      return;
    }

    if (clampedSlots == 0) {
      removeTicket(lobbyId: lobbyId, ticketId: ticketOption.id);
      return;
    }

    final currentTickets = state[lobbyId] ?? [];
    final existingTicketIndex = currentTickets.indexWhere((t) => t.ticketId == ticketOption.id);

    final updatedTicket = SelectedTicket(ticketId: ticketOption.id, name: ticketOption.name, slots: clampedSlots);

    List<SelectedTicket> newTickets;
    if (existingTicketIndex >= 0) {
      // Update existing ticket
      newTickets = List.from(currentTickets);
      newTickets[existingTicketIndex] = updatedTicket;
    } else {
      // Add new ticket
      if (isMultiplePricing) {
        newTickets = [...currentTickets, updatedTicket];
      } else {
        // For single pricing, replace all tickets with the new one
        newTickets = [updatedTicket];
      }
    }

    state = {...state, lobbyId: newTickets};
  }

  void removeTicket({required String lobbyId, required String ticketId}) {
    final currentTickets = state[lobbyId] ?? [];
    final updatedTickets = currentTickets.where((ticket) => ticket.ticketId != ticketId).toList();

    state = {...state, lobbyId: updatedTickets};
  }

  void clearTickets(String lobbyId) {
    state = {...state, lobbyId: []};
  }

  List<SelectedTicket> getTickets(String lobbyId) {
    return state[lobbyId] ?? [];
  }

  bool hasTicket(String lobbyId, String ticketId) {
    return (state[lobbyId] ?? []).any((ticket) => ticket.ticketId == ticketId);
  }

  int getTotalSlots(String lobbyId) {
    return (state[lobbyId] ?? []).fold(0, (sum, ticket) => sum + ticket.slots);
  }

  void clearAll() {
    state = {};
  }
}

final selectedTicketsProvider = StateNotifierProvider<SelectedTicketsNotifier, Map<String, List<SelectedTicket>>>(
  (ref) => SelectedTicketsNotifier(),
);
