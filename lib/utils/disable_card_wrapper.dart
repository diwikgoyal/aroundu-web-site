import 'package:aroundu/designs/colors.designs.dart';
import 'package:flutter/material.dart';

class DisabledCardWrapper extends StatelessWidget {
  final Widget child;
  final bool isDisabled;
  final EdgeInsetsGeometry? margin;

  const DisabledCardWrapper({super.key, required this.child, required this.isDisabled, this.margin});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Your original card
        Opacity(opacity: isDisabled ? 0.6 : 1, child: child),
        // Overlay for disabled state
        if (isDisabled)
          Positioned.fill(
            child: Container(
              margin: margin,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12), // Adjust based on your card's border radius
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => _showComingSoonDialog(context),
                  child: Container(), // Empty container to capture taps
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _showComingSoonDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(32),
            constraints: BoxConstraints(maxWidth: 350),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: DesignColors.accent.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.confirmation_num_outlined, size: 40, color: DesignColors.accent),
                ),
                const SizedBox(height: 24),

                // Title
                Text(
                  'Tickets Are Almost Here!',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[850],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),

                // Description
                Text(
                  'The wait is almost over—your next unforgettable experience is just around the corner. Get ready to secure your spot.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                // const SizedBox(height: 32),

                // // Close button
                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: () => Navigator.of(context).pop(),
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: DesignColors.accent,
                //       foregroundColor: Colors.white,
                //       elevation: 0,
                //       padding: const EdgeInsets.symmetric(vertical: 16),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(12),
                //       ),
                //     ),
                //     child: const Text(
                //       'Count me in',
                //       style: TextStyle(
                //         fontFamily: 'Poppins',
                //         fontSize: 16,
                //         fontWeight: FontWeight.w600,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
