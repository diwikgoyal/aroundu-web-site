import 'dart:convert';
import 'dart:html' as html;
import 'package:aroundu/designs/colors.designs.dart';
import 'package:aroundu/designs/widgets/text.widget.designs.dart';
import 'package:aroundu/views/scanner/model/qr_scanner_model.dart';
import 'package:aroundu/views/scanner/services/qr_scanner_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class SharedQrScreen extends ConsumerStatefulWidget {
  const SharedQrScreen({super.key, required this.qrId});
  final String qrId;

  @override
  ConsumerState<SharedQrScreen> createState() => _SharedQrScreenState();
}

class _SharedQrScreenState extends ConsumerState<SharedQrScreen> {
  @override
  Widget build(BuildContext context) {
    final qrDetailsAsync = ref.watch(qrDetailsProvider(widget.qrId));

    return Scaffold(
      backgroundColor: DesignColors.bg,
      body: qrDetailsAsync.when(
        loading: () => _buildLoadingState(),
        error: (error, stack) => _buildErrorState(error.toString()),
        data: (qrData) => _buildDataState(qrData),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(DesignColors.accent)),
          SizedBox(height: 16),
          DesignText(
            text: 'Loading QR details...',
            fontSize: 16,
            color: DesignColors.secondary,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: DesignColors.accent),
            SizedBox(height: 16),
            DesignText(
              text: 'Failed to load QR details',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: DesignColors.primary,
            ),
            // SizedBox(height: 8),
            // DesignText(
            //   text: error,
            //   fontSize: 14,
            //   color: DesignColors.secondary,
            //   textAlign: TextAlign.center,
            // ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                ref.read(qrDetailsProvider(widget.qrId).notifier).fetchQrDetails(widget.qrId);
              },
              icon: Icon(Icons.refresh),
              label: DesignText(text: 'Retry', fontSize: 14, color: Colors.white),
              style: ElevatedButton.styleFrom(
                backgroundColor: DesignColors.accent,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataState(QrScannerModel? qrData) {
    if (qrData == null) {
      return _buildErrorState('No QR data found');
    }

    return SingleChildScrollView(
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),

            // Header
            DesignText(text: "Event Check-in", fontSize: 28, fontWeight: FontWeight.bold, color: DesignColors.primary),
            SizedBox(height: 8),
            DesignText(text: "Scan this QR code at the entrance", fontSize: 15, color: DesignColors.secondary),
            SizedBox(height: 8),
            DesignText(text: widget.qrId, fontSize: 15, color: DesignColors.secondary),

            SizedBox(height: 40),

            // QR Code Card
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: DesignColors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: DesignColors.primary.withOpacity(0.08), blurRadius: 20, offset: Offset(0, 4)),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(color: DesignColors.bg, borderRadius: BorderRadius.circular(16)),
                    child: SizedBox(width: 220, height: 220, child: _buildQrImage(qrData)),
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: DesignColors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.verified_user, color: DesignColors.blue, size: 18),
                        SizedBox(width: 8),
                        DesignText(
                          text: _getStatusText(qrData.status),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: DesignColors.blue,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40),

            // Event Details Card
            _buildEventDetailsCard(qrData),

            SizedBox(height: 24),

            // Info Card
            if (qrData.message != null && qrData.message!.isNotEmpty)
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: DesignColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: DesignColors.border),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: DesignColors.accent, size: 22),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DesignText(
                            text: "Please show this QR code at the entrance",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: DesignColors.primary,
                            maxLines: null,
                            overflow: TextOverflow.visible,
                          ),
                          DesignText(
                            text: qrData.message!,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: DesignColors.primary,
                            maxLines: null,
                            overflow: TextOverflow.visible,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildQrImage(QrScannerModel qrData) {
    // First priority: Try QR image URL
    if (qrData.qrImageUrl != null && qrData.qrImageUrl!.isNotEmpty) {
      return Image.network(
        qrData.qrImageUrl!,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          // If URL fails, try base64 as fallback
          return _buildBase64Image(qrData.qrImageBase64);
        },
      );
    }

    // Second priority: Try base64 image
    return _buildBase64Image(qrData.qrImageBase64);
  }

  Widget _buildBase64Image(dynamic qrImageBase64) {
    if (qrImageBase64 is String && qrImageBase64.isNotEmpty) {
      try {
        // Remove data URL prefix if present
        String base64String = qrImageBase64;
        if (base64String.contains(',')) {
          base64String = base64String.split(',').last;
        }

        return Image.memory(
          base64Decode(base64String),
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset("assets/images/aroundu-qr-code.png", fit: BoxFit.contain);
          },
        );
      } catch (e) {
        return Image.asset("assets/images/aroundu-qr-code.png", fit: BoxFit.contain);
      }
    }

    // Final fallback: Default asset image
    return Image.asset("assets/images/aroundu-qr-code.png", fit: BoxFit.contain);
  }

  Widget _buildEventDetailsCard(QrScannerModel qrData) {
    final lobbyDetail = qrData.lobbyDetail;
    final userSummary = qrData.userSummary;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [DesignColors.primary, DesignColors.secondaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: DesignColors.primary.withOpacity(0.3), blurRadius: 20, offset: Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: DesignColors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.event, color: DesignColors.white, size: 24),
              ),
              SizedBox(width: 12),
              Expanded(
                child: DesignText(
                  text: lobbyDetail?.title ?? "Event Details",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: DesignColors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Divider(color: DesignColors.white.withOpacity(0.3), thickness: 1),
          SizedBox(height: 20),
          if (lobbyDetail?.locationDetail != null)
            GestureDetector(onTap: (){
               html.window.open(lobbyDetail!.locationDetail!['link'], 'location');
            },child: _buildDetailRow(Icons.location_on_outlined, "Location", lobbyDetail!.locationDetail!['name'])),

          if (lobbyDetail?.formattedDate != null) ...[
            SizedBox(height: 16),
            _buildDetailRow(Icons.calendar_today, "Date & Time", lobbyDetail!.formattedDate!),
          ],

          if (userSummary?.name != null) ...[
            SizedBox(height: 16),
            _buildDetailRow(Icons.person, "Attendee", userSummary!.name!),
          ],
          if (qrData.qrId != null) ...[
            SizedBox(height: 16),
            _buildDetailRow(Icons.confirmation_number, "QR ID", qrData.qrId!),
          ],
          if (qrData.slots != null) ...[
            SizedBox(height: 16),
            _buildDetailRow(Icons.people, "Slots", qrData.slots!.toString()),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: DesignColors.white.withOpacity(0.9), size: 20),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DesignText(
                text: label,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: DesignColors.white.withOpacity(0.8),
              ),
              SizedBox(height: 2),
              DesignText(text: value, fontSize: 15, fontWeight: FontWeight.w600, color: DesignColors.white),
            ],
          ),
        ),
      ],
    );
  }

  String _getStatusText(String? status) {
    switch (status?.toLowerCase()) {
      case 'active':
      case 'valid':
        return 'Valid Entry Pass';
      case 'used':
      case 'scanned':
        return 'Already Used';
      case 'expired':
        return 'Expired';
      default:
        return 'Entry Pass';
    }
  }
}
