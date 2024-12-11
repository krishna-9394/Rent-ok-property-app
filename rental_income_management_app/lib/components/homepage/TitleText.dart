import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  TitleText({super.key, required this.title});
  String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.start,
      style: const TextStyle(
          color: Color.fromARGB(255, 13, 2, 216),
          fontWeight: FontWeight.bold,
          fontSize: 22.0),
    );
  }
}
