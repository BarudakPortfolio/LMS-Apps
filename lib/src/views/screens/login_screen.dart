import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/features/auth/provider/auth_notifier.dart';
import 'package:lms/src/features/auth/provider/auth_state.dart';
import 'package:lms/src/features/collect_user/data/collect_user_api.dart';
import 'package:lms/src/features/user/provider/user_notifier.dart';
import 'package:lms/src/features/user/provider/user_provider.dart';
import 'package:lms/src/features/user/provider/user_state.dart';
import 'package:lms/src/views/components/snackbar_widget.dart';

import '../../core/routes/app_routes.dart';
import '../../core/style/theme.dart';
import '../../features/auth/provider/auth_provider.dart';
import '../../models/user.dart';
import '../components/form_input.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authNotifierProvider.notifier);
    final state = ref.watch(authNotifierProvider);
    final userNotifier = ref.watch(userNotifierProvider.notifier);
    final user = ref.watch(userNotifierProvider);
    final collectData = ref.watch(collectdataProvider);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              "assets/images/bg.png",
            ),
            fit: BoxFit.cover,
          )),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildHeader(),
                  const SizedBox(height: 15),
                  buildFormLogin(auth, state, userNotifier, user, collectData),
                ],
              ),
            ),
          ),
        )
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

  Card buildFormLogin(
    AuthNotifier auth,
    AuthState state,
    UserNotifier userNotifier,
    UserState user,
    CollectUserApi collect,
  ) {
    loginHandle() async {
      FocusManager.instance.primaryFocus?.unfocus();
      if (_formKey.currentState!.validate()) {
        await auth.login(usernameCtrl.text, passCtrl.text);
        if (state.isAuthenticated) {
          await userNotifier.getUser();
          collect.sendDataUser(user.user!);
          if (!mounted) return;
          Navigator.of(context).pushReplacementNamed(AppRoutes.main);
        } else {
          if (!mounted) return;
          ScaffoldMessenger.of(context)
              .showSnackBar(buildSnackBar("Gagal Login", Colors.red));
        }
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
                    Consumer(builder: (context, watch, child) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(15),
                            backgroundColor: kGreenPrimary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                              10,
                            ))),
                        onPressed: loginHandle,
                        child: Consumer(builder: (context, watch, child) {
                          final isLoading =
                              watch.watch(authNotifierProvider).isLoading;
                          if (isLoading) {
                            return const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          }
                          return const Text("Masuk");
                        }),
                      );
                    })
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
