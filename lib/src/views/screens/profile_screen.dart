import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/src/core/utils/extentions/format_date.dart';
import 'package:lms/src/core/utils/extentions/remove_scroll_grow.dart';
import 'package:lms/src/features/collect_user/data/collect_user_api.dart';
import 'package:lms/src/features/user/provider/user_state.dart';
import 'package:lms/src/views/screens/main_screen.dart';

import '../../core/style/theme.dart';
import '../../features/auth/provider/auth_provider.dart';
import '../../features/user/provider/user_provider.dart';
import '../../models/user.dart';

final reviewNotifierProvider =
    StateNotifierProvider<ReviewsNotifier, int>((ref) {
  return ReviewsNotifier();
});

class ReviewsNotifier extends StateNotifier<int> {
  ReviewsNotifier() : super(0);

  changeStar(int newIndex) => state = newIndex;
}

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController pesanCtrl;
  @override
  void initState() {
    pesanCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    pesanCtrl.dispose();
    super.dispose();
  }

  clearHistory(WidgetRef ref) async {
    await Future.delayed(const Duration(milliseconds: 300));
    ref.watch(reviewNotifierProvider.notifier).changeStar(0);
    pesanCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userNotifierProvider);
    final auth = ref.watch(authNotifierProvider.notifier);
    final navIndex = ref.watch(navProvider.notifier);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      endDrawer: Drawer(
        width: size.width * 0.6,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const DrawerHeader(
                  child: ListTile(
                title: Text("E-Learning",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )),
                subtitle: Text("Layanan digitalisasi sekolah"),
              )),
              const ListTile(
                leading: Icon(FluentIcons.info_12_regular),
                title: Text("Tentang"),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                    isScrollControlled: true,
                    isDismissible: false,
                    context: context,
                    builder: (context) => builModalBottomReviews(context, user),
                  );
                },
                leading: const Icon(FluentIcons.star_16_regular),
                title: const Text("Reviews"),
              ),
              const ListTile(
                leading: Icon(FluentIcons.layer_20_regular),
                title: Text("Versi 1.0.2-Alpha"),
              ),
              const Spacer(),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                tileColor: Colors.red,
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("Anda yakin keluar?"),
                            content: const Text(
                                "Akun anda akan keluar dari E-Learning apps ini"),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Kembali"),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: () {
                                  Future.delayed(const Duration(seconds: 1),
                                      () {
                                    Navigator.pop(context);
                                    navIndex.changeIndex(0);
                                    auth.logout();
                                    context.goNamed('login');
                                  });
                                },
                                child: const Text("Keluar"),
                              ),
                            ],
                          ));
                },
                leading: const Icon(
                  FluentIcons.sign_out_20_regular,
                  color: Colors.white,
                ),
                title:
                    const Text("Logout", style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0.0,
        title: const Text(
          'Profil',
          style: TextStyle(
            color: Color(0xff06283D),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            color: const Color(0xff06283D),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            color: const Color(0xff06283D),
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
          )
        ],
      ),
      body: user.user == null
          ? const Center(child: CircularProgressIndicator())
          : ScrollConfiguration(
              behavior: RemoveScrollGlow(),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 30, horizontal: 10),
                          child: Container(
                            height: 200,
                            width: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xff256D85),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 50,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    user.user?.name ?? 'Tanpa Nama',
                                    style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    user.user?.type == 'siswa'
                                        ? 'Mahasiswa'
                                        : 'Dosen',
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            const Text(
                                              'NIM',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "${user.user?.nim}",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            )
                                          ],
                                        ),
                                        Container(
                                          color: Colors.white,
                                          height: 50,
                                          width: 1,
                                        ),
                                        Column(
                                          children: [
                                            const Text(
                                              'SEMESTER',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "${user.user?.semester}",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            )
                                          ],
                                        ),
                                        Container(
                                          color: Colors.white,
                                          height: 50,
                                          width: 1,
                                        ),
                                        Column(
                                          children: [
                                            const Text(
                                              'KELAS',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              user.user!.kelas ?? '-',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // bottom: 90,
                          child: user.user == null
                              ? const CircleAvatar()
                              : avatarBuilder(user.user!),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            'Detail Profil',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          isThreeLine: false,
                          title: const Text('Program Studi'),
                          subtitle: Text(
                            user.user!.prodi ?? '-',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        ListTile(
                          title: const Text('Email'),
                          subtitle: Text(
                            user.user!.email ?? '-',
                            style: const TextStyle(color: Colors.black),
                          ),
                          isThreeLine: false,
                        ),
                        ListTile(
                          // leading: Icon(Icons.person),
                          title: const Text('Tempat, Tanggal Lahir'),
                          subtitle: Text(
                            "${user.user!.tempatLahir}, ${formatBornDate(user.user!.tanggalLahir!) ?? '-'}",
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        ListTile(
                          // leading: Icon(Icons.person),
                          title: const Text('No Hp'),
                          subtitle: Text(
                            user.user!.noTelp ?? '-',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        ListTile(
                          // leading: Icon(Icons.person),
                          title: const Text('Alamat'),
                          subtitle: Text(
                            user.user!.alamat ?? '-',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Padding builModalBottomReviews(BuildContext context, UserState user) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Consumer(builder: (context, watch, child) {
        final star = watch.watch(reviewNotifierProvider);
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const Text("Berikan Review Aplikasi",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    if (star > index) {
                      return IconButton(
                          onPressed: () {
                            watch
                                .watch(reviewNotifierProvider.notifier)
                                .changeStar(index + 1);
                          },
                          icon: const Icon(
                            Icons.star_rate,
                            size: 45,
                            color: Colors.yellow,
                          ));
                    }
                    return IconButton(
                        onPressed: () {
                          watch
                              .watch(reviewNotifierProvider.notifier)
                              .changeStar(index + 1);
                        },
                        icon: const Icon(
                          Icons.star_outline,
                          size: 45,
                        ));
                  }),
                ),
              ),
              TextFormField(
                controller: pesanCtrl,
                maxLines: 5,
                decoration: InputDecoration(
                    hintText: "Masukkan Pesan Review",
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kGreenPrimary),
                      onPressed: () {
                        Navigator.pop(context);
                        clearHistory(watch);
                      },
                      child: const Text("kembali")),
                  const SizedBox(width: 10),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kGreenPrimary),
                      onPressed: () {
                        watch
                            .watch(collectdataProvider)
                            .sendReviewUser(user.user!, star, pesanCtrl.text);
                        clearHistory(watch);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(
                                    "Terimakasih telah review aplikasi :)")));
                      },
                      child: const Text("Kirm")),
                ],
              )
            ],
          ),
        );
      }),
    );
  }

  Widget avatarBuilder(UserModel? user) {
    if (user!.avatar == null) {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 4,
            color: Colors.white,
          ),
        ),
        child: const CircleAvatar(
          radius: 35,
          backgroundColor: Color(0xff256D85),
          child: Icon(
            FluentIcons.person_20_regular,
            color: Colors.white,
          ),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 4,
          color: Colors.white,
        ),
      ),
      child: CircleAvatar(
        radius: 35,
        backgroundImage: NetworkImage(
            'https://elearning.itg.ac.id/upload/avatar/${user.avatar!}'),
      ),
    );
  }
}
