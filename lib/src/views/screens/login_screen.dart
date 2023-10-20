import 'dart:ui';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  @override
  void initState() {
    usernameCtrl = TextEditingController();
    passCtrl = TextEditingController();
    _formKey = GlobalKey<FormState>();

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
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 24,
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
    );
  }

  Column buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "E-learning",
          style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
        ),
        Text(
          "for Student Edition",
          style: TextStyle(fontSize: 16, color: Color(0xFF06283D)),
        ),
      ],
    );
  }

  Widget buildFormLogin() {
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
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text(
          "Masuk",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            TextForm(
              usernameCtrl,
              "Masukkan NIM",
              maxLength: 7,
              textInputType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Harap Isi NIM";
                }
                return null;
              },
              prefix: const Icon(Icons.numbers_rounded, size: 20),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            TextForm(
              passCtrl,
              'Masukkan Password',
              prefix: const Icon(Icons.lock_rounded, size: 20),
              isObsecure: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Harap Isi Password";
                } else if (value.length < 6) {
                  return "Password minimal 6 karakter";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: FilledButton(
                onPressed: loginHandle,
                child: isLoading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: LoadingAnimationWidget.waveDots(
                          size: 30,
                          color: Colors.white,
                        ),
                      )
                    : const Text("Masuk"),
              ),
            )
          ]),
        ),
      ],
    );
  }
}
