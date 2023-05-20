import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/src/features/collect_user/data/collect_user_api.dart';
import 'package:lms/src/features/user/provider/user_provider.dart';
import 'package:lms/src/views/components/snackbar_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../core/style/theme.dart';
import '../../features/auth/provider/auth_provider.dart';
import '../components/form_input.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController usernameCtrl;
  late TextEditingController passCtrl;
  late GlobalKey<FormState> _formKey;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    usernameCtrl = TextEditingController();
    passCtrl = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _controller = AnimationController(
      duration: const Duration(seconds: 1), // Set the animation duration
      vsync: this,
    );

    // Define the opacity transition from 0.0 to 1.0
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);

    // Start the animation
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    usernameCtrl.dispose();
    passCtrl.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        SizedBox(
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                'assets/images/splash.svg',
                width: size.width,
              ),
              Container(
                width: size.width,
                height: size.height * 0.3,
                decoration: BoxDecoration(
                    color: kGreenPrimary,
                    borderRadius: BorderRadius.circular(_animation.value * 5)),
              )
            ],
          ),
        ),
        AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Opacity(
                opacity: _animation.value,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                  child: Container(
                    width: 100,
                  ),
                ),
              );
            }),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(),
              const SizedBox(height: 15),
              buildFormLogin(),
            ],
          ),
        ),
      ]),
    );
  }

  Column buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "E-learning",
          style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
        ),
        Text(
          "Layanan Digitalisasi Sekolah",
          style: TextStyle(fontSize: 16, color: Color(0xFF06283D)),
        ),
      ],
    );
  }

  Card buildFormLogin() {
    final auth = ref.read(authNotifierProvider.notifier);
    final userNotifier = ref.watch(userNotifierProvider.notifier);
    final collect = ref.watch(collectdataProvider);
    final isLoading = ref.watch(authNotifierProvider).isLoading;
    loginHandle() async {
      FocusManager.instance.primaryFocus?.unfocus();
      if (_formKey.currentState!.validate()) {
        auth.login(usernameCtrl.text, passCtrl.text).then((value) async {
          if (value) {
            GoRouter.of(context).goNamed('main');
            await userNotifier.getUser().then(
                  (value) => collect.sendDataUser(value),
                );
          } else {
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
                buildSnackBar("NIM atau password salah", Colors.red));
          }
        });
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(buildSnackBar("Gagal Login", Colors.red));
      }
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Selamat Datang",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 18,
              color: Color(0xff256D85),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextForm(
                      usernameCtrl,
                      "Masukkan Nim",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Harap Isi Username";
                        }
                        return null;
                      },
                    ),
                    TextForm(
                      passCtrl,
                      'Masukkan Password',
                      isObsecure: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Harap Isi Password";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(15),
                            backgroundColor: kGreenPrimary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                              10,
                            ))),
                        onPressed: loginHandle,
                        child: isLoading
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: LoadingAnimationWidget.waveDots(
                                    size: 30, color: Colors.white),
                              )
                            : const Text("Masuk"))
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
