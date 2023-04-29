import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/routes/app_routes.dart';
import '../../core/style/theme.dart';
import '../services/storaged.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var storage = SecureStorage();
  var userProvider = UserProvider();

  Future<bool> loginCheck() async {
    bool isLogin = false;
    String? token = await storage.read('token');
    if (token != null) {
      String username = await storage.read('username');
      String password = await storage.read('password');
      bool result = await userProvider.login(username, password);
      isLogin = result;
    }
    return isLogin;
  }

  @override
  // void initState() {
  //   loginCheck().then((value) {
  //     if (value) {
  //       Navigator.pushNamedAndRemoveUntil(
  //           context, AppRoutes.main, (route) => false);
  //     } else {
  //       Navigator.pushNamedAndRemoveUntil(
  //           context, AppRoutes.login, (route) => false);
  //     }
  //   });

  //   super.initState();
  // }
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) {
      loginCheck().then((value) {
        if (value) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.main, (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.login, (route) => false);
        }
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

class SecureStorage {
  read(String s) {}
}

class UserProvider {
  login(String username, String password) {}
}
