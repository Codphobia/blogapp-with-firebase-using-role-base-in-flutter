import 'package:blogapp/screens%20for%20Admin/widgets/user_lists_screen.dart';
import 'package:blogapp/widgets/myDrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/add_post_screen_admin.dart';
import 'widgets/posts_list_screen.dart';



class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  String email = '', name = '';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          backgroundColor: const Color(0xdfe38d2c),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(AdminAddPostScreen(),
                      transition: Transition.leftToRight,
                      duration: Duration(seconds: 1));
                },
                icon: Icon(Icons.add)),
          ],
          bottom: const TabBar(tabs: [
            Tab(
              text: 'Users Lists',
            ),
            Tab(
              text: 'Posts Lists',
            ),
          ]),
        ),
        body: const TabBarView(children: [
          UsersListScreen(),
          PostListScreen(),
        ]),
        drawer: SafeArea(
          child:MyDarwer(),
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
