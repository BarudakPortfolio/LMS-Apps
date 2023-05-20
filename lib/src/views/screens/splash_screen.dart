import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/src/core/routes/app_routes.dart';
import 'package:vector_math/vector_math.dart' as vector;
import 'dart:math' as math;
import 'package:lms/src/features/storage/service/storage.dart';

import 'package:lms/src/features/injection/provider/injection_provider.dart';

import '../../core/style/theme.dart';
import '../../features/auth/provider/auth_provider.dart';

const Color kTopColor = Color.fromARGB(255, 37, 116, 143);
const Color kBottomColor = Color.fromARGB(255, 44, 145, 179);
const int kWaveLength = 320;
const Size kSize = Size(500, 500);

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    // ANIMATION
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      lowerBound: 0,
      upperBound: 360,
    );
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.ease);
    animationController.repeat();

    // GET DATA
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        final getIt = ref.watch(getItProvider);
        final auth = ref.watch(authNotifierProvider.notifier);
        final storage = getIt<SecureStorage>();
        Future.delayed(
          const Duration(seconds: 3),
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
      },
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    animationController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/images/splash.svg',
              width: size.width,
            ),
            Column(
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
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedBuilder(
                animation: animationController,
                builder: (context, child) {
                  return Stack(
                    children: [
                      Positioned(
                        top: size.height * 0.75,
                        left: size.width / 2,
                        child: CustomPaint(
                          size: kSize,
                          painter: WavePainter(
                              animationController: animationController,
                              isRightDirection: true),
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.75,
                        left: size.width / 2,
                        child: CustomPaint(
                          size: kSize,
                          painter: WavePainter(
                              animationController: animationController,
                              isRightDirection: false),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => Path()
    ..addOval(Rect.fromCenter(
        center: const Offset(0, 0),
        width: size.width - 20,
        height: size.height - 20));

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class WavePainter extends CustomPainter {
  AnimationController animationController;
  final bool isRightDirection;
  WavePainter(
      {required this.isRightDirection, required this.animationController});
  //static const int kWaveLength = 180;
  @override
  void paint(Canvas canvas, Size size) {
    double xOffset = size.width / 2;
    List<Offset> polygonOffsets = [];

    for (int i = -xOffset.toInt(); i <= xOffset; i++) {
      polygonOffsets.add(Offset(
          i.toDouble(),
          isRightDirection
              ? math.sin(vector.radians(i.toDouble() * 360 / kWaveLength) -
                          vector.radians(animationController.value)) *
                      20 -
                  25
              : math.sin(vector.radians(i.toDouble() * 360 / kWaveLength) +
                          vector.radians(animationController.value)) *
                      20 -
                  20));
    }

    final Gradient gradient = LinearGradient(
        begin: const Alignment(-1.0, -1.0), //top
        end: const Alignment(-1.0, 1.0), //center
        colors: const <Color>[
          kBottomColor,
          kTopColor,
        ],
        stops: [
          isRightDirection ? 0.1 : 0.4,
          isRightDirection ? 0.9 : 1
        ]);
    final wave = Path();
    wave.addPolygon(polygonOffsets, false);
    wave.lineTo(xOffset, size.height);
    wave.lineTo(-xOffset, size.height);
    wave.close();

    final rect = Rect.fromLTWH(
        0.0,
        isRightDirection ? -size.height / 5 - 25 : -size.height / 5 - 22,
        size.width,
        size.height / 2);
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill;
    //  canvas.drawRect(rect, paint);
    canvas.drawPath(wave, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
