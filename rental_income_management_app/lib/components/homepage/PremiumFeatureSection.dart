import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'TaskCard.dart';
import 'TitleText.dart';

class PremiumFeatureSection extends StatelessWidget {
  PremiumFeatureSection({super.key});

  final features = [
    TaskCard(
      title: 'View Tenant Profile',
      description: "Now check address proof,"
          " \nID Proof & Joining form "
          "\nof your tenant at one place",
      buttonTitle: 'Check Tenant Profile',
    ),
    TaskCard(
      title: 'My Website',
      description: "Your world class website"
          " \nLess calls; More conversion",
      buttonTitle: 'I\'m interested',
    ),
    TaskCard(
      title: 'My Notice Board',
      description: "Start sending announcements "
          "\nto all tenants",
      buttonTitle: 'Send Announcements',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TitleText(title: 'Complete these tasks'),
        ),
        CarouselSlider.builder(
          itemCount: features.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) {
            return features[itemIndex];
          },
          options: CarouselOptions(
            height: 200.0,
            autoPlay: true,
            viewportFraction: 1.0,
            initialPage: 0,
            enableInfiniteScroll: true,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              // Handle page change if needed
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(features.length, (index) {
            return Container(
              width: 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue, // Change indicator color for active page
              ),
            );
          }),
        ),
      ],
    );
  }
}
