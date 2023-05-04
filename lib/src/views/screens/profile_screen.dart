import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/src/views/screens/main_screen.dart';

import '../../core/routes/app_routes.dart';
import '../../features/auth/provider/auth_provider.dart';
import '../../features/user/provider/user_provider.dart';
import '../../models/user.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.login, (route) => false);
                    Future.delayed(const Duration(seconds: 1), () {
                      navIndex.changeIndex(0);
                      auth.logout();
                    });
                  },
                  icon: const Icon(FluentIcons.sign_out_20_regular),
                  label: const Text('Logout'),
                ),
              )
            ],
          ),
        ),
      ),
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 100,
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
            icon: const Icon(Icons.settings),
            color: const Color(0xff06283D),
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
          )
        ],
      ),
      body: user.user == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                                        children: const [
                                          Text(
                                            'KELAS',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'IF-2020-D',
                                            style: TextStyle(
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
                  SingleChildScrollView(
                    child: Column(
                      verticalDirection: VerticalDirection.down,
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
                          title: const Text('Program Studi'),
                          subtitle: Text(
                            user.user!.prodi ?? 'Tidak ada prodi',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                          indent: 16,
                          endIndent: 16,
                        ),
                        ListTile(
                          // leading: Icon(Icons.person),
                          title: const Text('Email'),
                          subtitle: Text(
                            user.user!.email ?? 'Email tidak ada',
                            style: const TextStyle(color: Colors.black),
                          ),
                          isThreeLine: false,
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                          indent: 16,
                          endIndent: 16,
                        ),
                        ListTile(
                          // leading: Icon(Icons.person),
                          title: const Text('No Hp'),
                          subtitle: Text(
                            user.user!.noTelp ?? 'No Hp tidak ada',
                            style: const TextStyle(color: Colors.black),
                          ),
                          isThreeLine: false,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
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
