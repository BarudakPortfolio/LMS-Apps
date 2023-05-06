import 'package:flutter/material.dart';

class BannerGrade extends StatelessWidget {
  const BannerGrade(
    this.text,
    this.color, {
    super.key,
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white,
          )),
    );
  }
}
