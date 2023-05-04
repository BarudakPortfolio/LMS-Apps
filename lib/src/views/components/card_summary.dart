import 'package:flutter/material.dart';

class CardSummary extends StatelessWidget {
  const CardSummary(this.title, this.value, {super.key, required this.onTap});
  final String title;
  final int value;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(value.toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
