import 'package:blogapp/models/post_model.dart';
import 'package:blogapp/screens%20for%20users/post_details_screen_user.dart';
import 'package:blogapp/services/authmanager.dart';
import 'package:blogapp/widgets/myDrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

 
class UserHomeScreen extends StatefulWidget {
  
  const UserHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  AuthServices authServices = AuthServices();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xdfe38d2c),

        centerTitle: true,
        title: const Text('User Home Screen'),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('postsList').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    PostModel postModel = PostModel.fromMap(snapshot.data!.docs[index]);
                    return InkWell(
                      onTap: () {
                        Get.to(PostDetailScreenUser(postModel: postModel),
                            transition: Transition.circularReveal,
                            duration: const Duration(seconds: 1));

                        print(postModel);
                      },
                      child: Padding(
                        padding: const  EdgeInsets.symmetric(vertical: 7,horizontal: 8),
                        child: Stack(
                          children: [
                            ClipRRect(
                              clipBehavior: Clip.antiAlias,
                              borderRadius: BorderRadius.circular(40),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 2),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    image: DecorationImage(
                                      image: NetworkImage(postModel.url),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      postModel.title,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
          },
        )
        ,
      )
      ,
      drawer: const MyDarwer(),
    );
  }


}
