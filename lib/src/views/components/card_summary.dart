import 'package:flutter/material.dart';

class CardSummary extends StatelessWidget {
  CardSummary(this.title, this.value, {super.key});
  String title;
  String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
            Text(title),
          ],
        ),
      ),
    );
  }
}
