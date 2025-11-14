import 'package:aroundu/designs/colors.designs.dart';
import 'package:aroundu/designs/widgets/text.widget.designs.dart';
import 'package:flutter/material.dart';

class InfoCard {
  final IconData icon;
  final String title;
  final String subtitle;

  InfoCard({required this.icon, required this.title, required this.subtitle});
}

class ScrollableInfoCards extends StatelessWidget {
  final List<InfoCard> cards;

  const ScrollableInfoCards({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 132, // Adjusted height for responsiveness
      child: StatefulBuilder(
        builder: (context, setState) {
          // ScrollController _scrollController = ScrollController();
          // bool _isForward = true;

          // void _autoScroll(double maxExtent, ScrollController controller) {
          //   if (!controller.hasClients) return;
            
          //   if (_isForward) {
          //     controller.animateTo(
          //       maxExtent,
          //       duration: Duration(seconds: 3),
          //       curve: Curves.linear
          //     ).then((_) {
          //       _isForward = false;
          //       _autoScroll(maxExtent, controller);
          //     });
          //   } else {
          //     controller.animateTo(
          //       0,
          //       duration: Duration(seconds: 3),
          //       curve: Curves.linear
          //     ).then((_) {
          //       _isForward = true;
          //       _autoScroll(maxExtent, controller);
          //     });
          //   }
          // }

          // // Auto scroll animation
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   if (_scrollController.hasClients) {
          //     double maxScrollExtent = _scrollController.position.maxScrollExtent;
              
          //     Future.delayed(Duration(milliseconds: 500), () {
          //       _autoScroll(maxScrollExtent, _scrollController);
          //     });
          //   }
          // });

          return ListView.builder(
            // controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: cards.length,
            // padding: EdgeInsets.only(right: 16.w),
            itemBuilder: (context, index) {
              return _buildCard(cards[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildCard(InfoCard card) {
    return Container(
      width: 124, // Adjust width based on screen size
      // margin: EdgeInsets.only(right: 12.w),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(12.r),
        
        // gradient: LinearGradient(
        //   colors: [Colors.white, Colors.pink.shade50], // Subtle gradient effect
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: DesignColors.secondary,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(8),
            child: Icon(
              card.icon,
              color: DesignColors.accent,
              size: 24,
            ),
          ),
          SizedBox(height: 8),
          DesignText(
            text: card.title,
            // fontWeight: FontWeight.bold,
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: DesignColors.secondaryFontDark,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          DesignText(
            text: card.subtitle,
            fontSize: 8,
            fontWeight: FontWeight.w400,
            color: DesignColors.accent,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
