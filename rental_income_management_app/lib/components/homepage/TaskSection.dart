import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'TaskCard.dart';
import 'TitleText.dart';

class TaskSection extends StatelessWidget {
  const TaskSection({super.key});

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
          itemCount: 3,
          itemBuilder: (BuildContext context, int itemIndex, int PageViewIndex) =>
                  TaskCard(
            title: 'View Tenant Profile',
            description: "Now check address proof,"
                " \nID Proof & Joining form "
                "\nof your tenant at one place",
            buttonTitle: 'Check Tenant Profile',
          ),
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
      ],
    );
  }
}
