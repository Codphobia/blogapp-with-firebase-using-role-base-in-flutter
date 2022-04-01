
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
 import 'package:url_launcher/url_launcher.dart';

import '../services/authmanager.dart';

class MyDarwer extends StatefulWidget {
  const MyDarwer({Key? key}) : super(key: key);

  @override
  State<MyDarwer> createState() => _MyDarwerState();
}

class _MyDarwerState extends State<MyDarwer> {
  String email = '', name = '';
  AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                  child: const Text('Data Loading Please wait...'));
            } else {
              return ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: const Color(0xdfe38d2c),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            right: 140,
                          ),
                          child: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://previews.123rf.com/images/apoev/apoev1903/'
                                'apoev190300009/124806570-%E7%81%B0%E8%89%B2%E3%81%AE%'
                                'E8%83%8C%E6%99%AF%E3%81%ABt%E3%82%B7%E3%83%A3%E3%83%84%'
                                'E3%82%92%E7%9D%80%E3%81%9F%E4%BA%BA%E7%81%B0%E8%89%B2%E3'
                                '%81%AE%E5%86%99%E7%9C%9F%E3%83%97%E3%83%AC%E3%83%BC%E3%8'
                                '2%B9%E3%83%9B%E3%83%AB%E3%83%80%E3%83%BC%E3%83%9E%E3%83%B3.jpg'),
                            radius: 40,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Expanded(child: Text(name)),
                        const SizedBox(height: 5),
                        Expanded(child: Text(email)),
                      ],
                    ),
                  ),
                  ListTile(
                    title: const Text('Email'),
                    trailing: const Icon(Icons.email),
                    onTap: () async {
                      String url = 'https://web.facebook.com/photo/?fbid=147793234393593&set=a.110151301491120';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        print('can not  lauch url');
                      }
                    },
                  ),
                  ListTile(
                    title: const Text('Contact Us '),
                    trailing: const Icon(Icons.phone),
                    onTap: ()async {
                      final phoneNumber='+923101186261';
                      String url = 'tel:$phoneNumber';
                      if (await canLaunch(url)) {
                      await launch(url);
                      } else {
                      print('can not  lauch url');
                      }
                    },
                  ),
                  ListTile(
                    title: const Text('LogOut '),
                    trailing: const Icon(Icons.logout),
                    onTap: ()async {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            AlertDialog(
                              backgroundColor: const Color(0xdfe38d2c),
                              content: Text(
                                'Are You sure want to Logout..?',
                                style: GoogleFonts.alike(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              title: Text(
                                'Confirmation..!',
                                style: GoogleFonts.alike(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          authServices.logout();

                                        },
                                        child: Text(
                                          'Yes',
                                          style: GoogleFonts.alike(
                                            textStyle: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        )),
                                    TextButton(
                                      onPressed: () async {

                                        Get.back();
                                      },
                                      child: Text(
                                        'No',
                                        style: GoogleFonts.alike(
                                          textStyle: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                      );
                    }
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  getData() async {
    User? user = await FirebaseAuth.instance.currentUser;

    var getDocuments = await FirebaseFirestore.instance
        .collection('profileInfo')
        .doc(user!.uid)
        .get();
    email = getDocuments.data()!['email'];
    name = getDocuments.data()!['name'];
  }
}
