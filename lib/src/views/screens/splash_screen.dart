import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/core/routes/app_routes.dart';
import 'package:lms/src/features/auth/provider/auth_notifier.dart';
import 'package:lms/src/features/storage/storage_provider.dart';

import '../../core/style/theme.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    Future.microtask(
      () {
        ref.watch(secureStorage).read('token').then((value) {
          if (value == null) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.login);
          } else {
            ref.watch(secureStorage).readAll().then((value) {
              ref
                  .watch(authNotifierProvider)
                  .login(value['username'], value['password']);
              Navigator.of(context).pushReplacementNamed(AppRoutes.main);
            });
          }
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bg.png"),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "E-learning",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
              ),
              const Text(
                "Layanan Digitalisasi Sekolah",
                style: TextStyle(fontSize: 16, color: Color(0xFF06283D)),
              ),
              Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: MediaQuery.of(context).size.width / 3),
                  child: const LinearProgressIndicator(
                    color: kGreenPrimary,
                    backgroundColor: kWhiteBg,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
