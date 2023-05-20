import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/features/assigment/provider/assigment/assigment_provider.dart';
import 'package:lms/src/features/autorisasi/data/autorisasi_api.dart';
import 'package:lms/src/features/autorisasi/provider/autorisasi_notifier.dart';
import 'package:lms/src/features/materi/provider/materi/materi_provider.dart';
import 'package:lms/src/views/screens/assignment_screen.dart';
import 'package:lms/src/views/screens/materi_screen.dart' as materi;

import '../../../main.dart';
import '../../core/style/theme.dart';

class AuthorizationCameraScreen extends ConsumerStatefulWidget {
  final String id;
  final bool isTugas;
  const AuthorizationCameraScreen(this.id, {required this.isTugas, super.key});

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
    Future.microtask(() => ref
        .watch(autorisasiNotifierProvider.notifier)
        .saveReviewAutorisasi(File('')));
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
    final foto = ref.watch(autorisasiNotifierProvider);
    final status = ref.watch(dropdownStatusNotifierProvider);
    final idKelas = ref.watch(dropdownClassNotifierProvider);
    final idKelasMateri = ref.watch(materi.dropdownClassNotifierProvider);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text("Autorisasi"),
        centerTitle: true,
      ),
      body: foto.path == ''
          ? FutureBuilder(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: kGreenPrimary,
                  ));
                } else {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    child: CameraPreview(_cameraCtrl),
                  );
                }
              })
          : Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              child: Image.file(
                foto,
                fit: BoxFit.cover,
              )),
      floatingActionButton: foto.path == ''
          ? FloatingActionButton(
              heroTag: "1",
              backgroundColor: kGreenPrimary,
              onPressed: () async {
                final resultTakeCamera = await _cameraCtrl.takePicture();
                ref
                    .watch(autorisasiNotifierProvider.notifier)
                    .saveReviewAutorisasi(File(resultTakeCamera.path));
                print(resultTakeCamera.name);
                print(resultTakeCamera.path);
              },
              child: const Icon(Icons.camera_alt),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  heroTag: "2",
                  backgroundColor: kGreenPrimary,
                  onPressed: () {
                    ref
                        .watch(autorisasiNotifierProvider.notifier)
                        .saveReviewAutorisasi(File(''));
                  },
                  child: const Icon(Icons.replay),
                ),
                FloatingActionButton(
                  heroTag: "3",
                  backgroundColor: kGreenPrimary,
                  onPressed: () {
                    final autorisasiApi = ref.watch(autorisasiProvider);
                    final type = widget.isTugas ? 'tugas' : "materi";
                    autorisasiApi
                        .sendAutorisasi(
                      id: widget.id,
                      foto: ref.watch(autorisasiNotifierProvider),
                      type: type,
                    )
                        .then((value) {
                      if (value) {
                        if (type == 'materi') {
                          ref
                              .watch(materiNotifierProvider.notifier)
                              .getMateri(newClassId: idKelasMateri);
                          // Navigator.pushReplacementNamed(
                          //   context,
                          //   AppRoutes.detailMateri,
                          //   arguments: int.parse(widget.id),
                          // );
                        } else {
                          ref
                              .watch(assigmentNotifierProvider.notifier)
                              .getAssigment(
                                newStatus: status,
                                newMapelId: idKelas,
                              );
                          // Navigator.pushReplacementNamed(
                          //   context,
                          //   AppRoutes.detailTugas,
                          //   arguments: widget.id,
                          // );
                        }
                      }
                    });
                  },
                  child: const Icon(Icons.check),
                ),
              ],
            ),
    );
  }
}
