import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/core/routes/app_routes.dart';
import 'package:lms/src/core/style/theme.dart';

import '../../core/common/constants.dart';
import '../../features/assigment/provider/assigment_detail/assigment_detail_provider.dart';
import '../components/jumbotron_assignment.dart';

class AssignmentDetailScreen extends ConsumerStatefulWidget {
  final String id;
  const AssignmentDetailScreen(this.id, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AssignmentDetailScreenState();
}

class _AssignmentDetailScreenState
    extends ConsumerState<AssignmentDetailScreen> {
  @override
  void initState() {
    Future.microtask(() async {
      await ref
          .watch(detailAssignmentNotifierProvider.notifier)
          .getDetailAssignment(
            widget.id,
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(detailAssignmentNotifierProvider);
    final assignment = state.data;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
        foregroundColor: Colors.black,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: const Text("Foto Autorisasi"),
                        content: Image.network(
                          "https://elearning.itg.ac.id/${assignment!.foto}",
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox(
                              height: 100,
                              child: Center(child: Text("Gagal memuat foto")),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return SizedBox(
                              height: 100,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: kGreenPrimary,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Tutup"))
                        ],
                      ));
            },
            icon: const Icon(FluentIcons.video_person_12_regular),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(FluentIcons.info_12_regular),
          )
        ],
      ),
      body: state.isLoading && state.data == null
          ? const Center(
              child: CircularProgressIndicator(
                color: kGreenPrimary,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      JumbotronAssignment(assignment: assignment),
                    ],
                  )),
            ),
    );
  }
}
