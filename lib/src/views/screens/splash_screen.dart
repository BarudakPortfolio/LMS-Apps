import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/core/routes/app_routes.dart';
import 'package:lms/src/core/utils/storage.dart';
import 'package:lms/src/features/auth/provider/auth_notifier.dart';
import 'package:lms/src/features/auth/provider/auth_state.dart';
import 'package:lms/src/features/injection/injection_provider.dart';
import 'package:lms/src/features/storage/storage_provider.dart';

import '../../core/style/theme.dart';
import '../../features/auth/provider/auth_state.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final getIt = ref.watch(getItProvider);
      final auth = ref.watch(authNotifierProvider.notifier);
      final storage = getIt<SecureStorage>();
      Future.delayed(const Duration(seconds: 3), () {
        storage.read("token").then((value) {
          if (value != null) {
            storage.readAll().then((user) {
              auth.login(user['username'], user['password']);
            });

            Navigator.pushReplacementNamed(context, AppRoutes.main);
          } else {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          }
        });
      });
    });
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
