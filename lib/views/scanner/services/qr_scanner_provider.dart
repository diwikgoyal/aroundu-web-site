import 'dart:convert';
import 'package:aroundu/utils/api_service/api.service.dart';
import 'package:aroundu/utils/logger.utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/qr_scanner_model.dart';
import 'package:http/http.dart' as http;

final qrScannerProvider =
    StateNotifierProvider<QrScannerNotifier, AsyncValue<List<QrScannerModel>>>(
  (ref) => QrScannerNotifier(),
);

class QrScannerNotifier
    extends StateNotifier<AsyncValue<List<QrScannerModel>>> {
  QrScannerNotifier() : super(const AsyncValue.loading());

  Future<void> fetchQrScannerData(String lobbyId) async {
    final url = 'match/qr/fetch?lobbyId=$lobbyId';

    try {
      state = const AsyncValue.loading();
      final response = await ApiService().get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        final List<QrScannerModel> qrList =
            jsonList.map((json) => QrScannerModel.fromJson(json)).toList();
        state = AsyncValue.data(qrList);
      } else {
        state = AsyncValue.error(
          'Failed to fetch data: ${response.statusCode}',
          StackTrace.current,
        );
      }
    } catch (e, stack) {
      print("$e \n $stack");
      state = AsyncValue.error('Error: $e', StackTrace.current);
    }
  }

  Future<void> fetchQrScannedData({required String url, required String lobbyId}) async {
    final String dynamicUrl = url;
    // const headers = {
    //   'SOURCE': 'internal',
    //   'USERID': '674470e8ed7ced400fd67d95',
    //   'X-AUTH-KEY': 'XAZjipXlVWUKWfw',
    //   'X-API-KEY': 'uFXdTQKuQfzyMnw',
    // };

    try {
      state = const AsyncValue.loading();
      // final response = await http.post(Uri.parse(dynamicUrl), headers: headers);
      final response = await ApiService().post("$dynamicUrl?lobbyId=$lobbyId", body: {
        'lobbyId' : lobbyId,
      });
      print(url);

      if (response.statusCode == 200) {
        print(response.statusCode);
        print(response.data);

      kLogger.trace(response.data.toString());
        // Parse response body
        final dynamic jsonResponse = [response.data];

        // Check if the response is an array or an object
        List<dynamic> jsonList;
        if (jsonResponse is List) {
          jsonList = jsonResponse; // If it's already a list, use it
        } else if (jsonResponse is Map) {
          jsonList = [
            jsonResponse
          ]; // If it's a single object, wrap it in a list
        } else {
          throw Exception('Unexpected response format');
        }

        // Convert JSON data into a list of QrScannerModel objects
        final List<QrScannerModel> qrList =
            jsonList.map((json) => QrScannerModel.fromJson(json)).toList();

        // Update state with the parsed data
        state = AsyncValue.data(qrList);
      } else {
        state = AsyncValue.error(
          'Failed to fetch data: ${response.statusCode}',
          StackTrace.current,
        );
      }
    } catch (e, stack) {
      kLogger.error("error in qr scan",error: e, stackTrace: stack);
      state = AsyncValue.error('Error: $e \n $stack', StackTrace.current);
    }
  }
}

// Provider for single QR code details by qrId
final qrDetailsProvider = StateNotifierProvider.family<QrDetailsNotifier, AsyncValue<QrScannerModel?>, String>(
  (ref, qrId) {
    final notifier = QrDetailsNotifier();
    notifier.fetchQrDetails(qrId);
    return notifier;
  },
);

class QrDetailsNotifier extends StateNotifier<AsyncValue<QrScannerModel?>> {
  QrDetailsNotifier() : super(const AsyncValue.loading());

  Future<void> fetchQrDetails(String qrId) async {
    state = const AsyncValue.loading();
    
    try {
      final response = await ApiService().get('match/qr?qrId=$qrId');
      
      if (response.statusCode == 200 && response.data != null) {
        final qrData = QrScannerModel.fromJson(response.data);
        state = AsyncValue.data(qrData);
      } else {
        state = AsyncValue.error(
          'Failed to fetch QR details: ${response.statusCode}',
          StackTrace.current,
        );
      }
    } catch (e, stack) {
      kLogger.error('Error fetching QR details', error: e, stackTrace: stack);
      state = AsyncValue.error('Error: $e', stack);
    }
  }
}
