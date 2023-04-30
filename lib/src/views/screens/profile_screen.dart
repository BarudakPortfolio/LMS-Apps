import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.white10,
          elevation: 0.0,
          centerTitle: true,
          title: const Text(
            'Profile',
            style: TextStyle(
                color: Color(0xff06283D),
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => {},
            color: const Color(0xff06283D),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              color: const Color(0xff06283D),
              onPressed: () => {},
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              color: const Color(0xff06283D),
              onPressed: () => {},
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  child: Container(
                    height: 200,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xff256D85),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 50,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Dimas wahyudi',
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Mahasiswa',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'NIM',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '2006132',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
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
                                    Text(
                                      'TAHUN AJARAN',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '2022/2023',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
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
                                    Text(
                                      'KELAS',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'IF-2020-D',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
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
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                    backgroundColor: Color(0xff256D85),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Color(0xff256D85),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                verticalDirection: VerticalDirection.down,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'Profile Detail',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    // leading: Icon(Icons.person),
                    title: Text('Email'),
                    subtitle: Text(
                      'Dimas.wahyudi@example.com',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                  ListTile(
                    // leading: Icon(Icons.person),
                    title: Text('Email'),
                    subtitle: Text(
                      'Dimas.wahyudi@example.com',
                      style: TextStyle(color: Colors.black),
                    ),
                    isThreeLine: false,
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                  ListTile(
                    // leading: Icon(Icons.person),
                    title: Text('Email'),
                    subtitle: Text(
                      'Dimas.wahyudi@example.com',
                      style: TextStyle(color: Colors.black),
                    ),
                    isThreeLine: false,
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
