import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../main.dart';
import '../../core/style/theme.dart';

class AuthorizationCameraScreen extends ConsumerStatefulWidget {
  const AuthorizationCameraScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AuthorizationCameraScreenState();
}

class _AuthorizationCameraScreenState
    extends ConsumerState<AuthorizationCameraScreen> {
  late CameraController _cameraCtrl;
  late Future<void> _initializeControllerFuture;
  @override
  void initState() {
    _cameraCtrl = CameraController(
      cameras!.last,
      ResolutionPreset.low,
      enableAudio: false,
    );
    _initializeControllerFuture = _cameraCtrl.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _cameraCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text("Autorisasi"),
      ),
      body: Center(
        child: FutureBuilder(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi),
                  child: Center(child: CameraPreview(_cameraCtrl)),
                );
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kGreenPrimary,
        onPressed: () async {},
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
