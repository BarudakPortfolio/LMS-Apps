import 'package:flutter/material.dart';

class CardSummary extends StatelessWidget {
  const CardSummary(this.title, this.value,
      {super.key, required this.onTap, required this.icon});
  final String title;
  final int value;
  final void Function()? onTap;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          // width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(value.toString(),
                  style: const TextStyle(
                    fontSize: 30,
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
