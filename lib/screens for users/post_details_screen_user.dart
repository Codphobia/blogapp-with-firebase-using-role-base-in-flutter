import 'package:blogapp/models/post_model.dart';
 import 'package:flutter/material.dart';

class PostDetailScreenUser extends StatefulWidget {
  PostModel postModel;

  PostDetailScreenUser({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  @override
  State<PostDetailScreenUser> createState() => _PostDetailScreenUserState();
}

class _PostDetailScreenUserState extends State<PostDetailScreenUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Description Screen'),
        backgroundColor: const Color(0xdfe38d2c),
        centerTitle: true,
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 20),
              child: Column(children: [
                Text(
                  widget.postModel.title,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.postModel.description,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
