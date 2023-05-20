import 'dart:ui';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class CardClass extends StatelessWidget {
  const CardClass({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
          child: Container(
            height: 200,
            width: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    "assets/images/kelas/kelas0.png",
                    fit: BoxFit.cover,
                  ),
                ),
                ListTile(
                  title: const Text("Praktikum Pemrograman Mobile",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(
                        FluentIcons.clock_12_regular,
                        size: 14,
                      ),
                      SizedBox(width: 10),
                      Text("Selasa, 12:00-13:00",
                          style: TextStyle(fontSize: 12)),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
