import 'dart:math';
import 'dart:ui';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms/src/core/utils/extentions/format_date.dart';
import 'package:lms/src/models/kelas.dart';

class CardClass extends StatelessWidget {
  Kelas classModel;
   CardClass({
    super.key,
    required this.classModel
  });

  @override
  Widget build(BuildContext context) {
    int indexPicture = Random().nextInt(3);
    return Column(
      children: [
        Container(
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
                child: SvgPicture.asset("assets/images/kelas/kelas$indexPicture.svg")
              ),
              ListTile(
                title: Text(classModel.nama!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      FluentIcons.clock_12_regular,
                      size: 14,
                    ),
                    const SizedBox(width: 10),
                    Text(formatTimeClass(classModel),
                        style: const TextStyle(fontSize: 10)),

                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Ruangan : ${classModel.ruangan!}",
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 10)),
              ),
              const SizedBox(height: 5),
            ],
          ),
        )
      ],
    );
  }
}
