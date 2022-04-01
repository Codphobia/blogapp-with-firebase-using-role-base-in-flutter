import 'package:blogapp/screens%20for%20Admin/widgets/update_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/post_model.dart';
import '../../services/databasemanager.dart';

class PostDetailScreen extends StatefulWidget {
  PostModel postModel;

  PostDetailScreen({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Description Screen'),
        backgroundColor: const Color(0xdfe38d2c),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(AdminUpdatetScreen(postModel: widget.postModel));
              },
              icon: Icon(Icons.edit_attributes_outlined)),
          SizedBox(width: 3),
          IconButton(
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: const Color(0xdfe38d2c),
                    content: Text(
                      'Are You sure want to delete..?',
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
                              onPressed: ()  {
                                DatabaseManager().deletePost(widget.postModel.id);
                                Get.back();
                                Get.back();
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
                            onPressed: () {
                              Navigator.of(context).pop();
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
              },
              icon: Icon(Icons.remove_circle_outline_rounded)),
          SizedBox(width: 3),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(widget.postModel.url),
                fit: BoxFit.cover,
              )),
            ),
            Text(
              widget.postModel.title,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.postModel.description,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
