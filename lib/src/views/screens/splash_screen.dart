import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/src/features/storage/service/storage.dart';

import 'package:lms/src/features/injection/provider/injection_provider.dart';

import '../../core/style/theme.dart';
import '../../features/auth/provider/auth_provider.dart';

final percentProvider = StateProvider<double>((ref) => 0);

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    Future.microtask(() {
      progressStream();
      final getIt = ref.watch(getItProvider);
      final auth = ref.watch(authNotifierProvider.notifier);
      final storage = getIt<SecureStorage>();
      Future.delayed(
        const Duration(seconds: 2),
        () {
          storage.read("token").then(
            (value) {
              if (value != null) {
                storage.readAll().then((user) {
                  auth.login(user['username'], user['password']);
                });
                context.goNamed('main');
              } else {
                context.goNamed('login');
              }
            },
          );
        },
      );
    });
    super.initState();
  }

  void progressStream() {
    Timer.periodic(const Duration(milliseconds: 18), (timer) {
      ref.watch(percentProvider.notifier).state = (timer.tick / 100);
      if (timer.tick >= 100) {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/images/splash.svg',
              width: size.width,
            ),
            SizedBox(
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Text(
                    "E-learning",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                  ),
                  const Text(
                    "For Student Edition",
                    style: TextStyle(fontSize: 16, color: Color(0xFF06283D)),
                  ),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50.0),
                    width: size.width,
                    child: LinearProgressIndicator(
                      backgroundColor: kWhiteBg,
                      value: ref.watch(percentProvider),
                    ),
                  ),
                  Text("${ref.watch(percentProvider)} %"),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
