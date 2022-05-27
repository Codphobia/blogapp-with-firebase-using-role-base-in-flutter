import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/authmanager.dart';
import '../../services/databasemanager.dart';
import '../../widgets/mybutton.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AdminAddPostScreen extends StatefulWidget {
  const AdminAddPostScreen({Key? key}) : super(key: key);

  @override
  State<AdminAddPostScreen> createState() => _AdminAddPostScreenState();
}

class _AdminAddPostScreenState extends State<AdminAddPostScreen> {
  File? image;

  DatabaseManager databaseManager = DatabaseManager();
  final _formkey = GlobalKey<FormState>();
  var titleEditingController = TextEditingController();
  var descriptionEditingController = TextEditingController();
  String? title, description;
  AuthServices authServices = AuthServices();
  User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Post'),
        backgroundColor: const Color(0xdfe38d2c),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (ctx) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                                // imagesPicker(ImageSource.camera);
                                imagesPicker(ImageSource.camera);
                              },
                              child: const ListTile(
                                leading: Icon(Icons.camera_alt),
                                title: Text('With Camera'),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                                // imagesPicker(ImageSource.gallery);
                                imagesPicker(ImageSource.gallery);
                              },
                              child: const ListTile(
                                leading: Icon(Icons.photo_library),
                                title: Text('From Gallery'),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * .2,
                      width: MediaQuery.of(context).size.width * 1,
                      child: image != null
                          ? ClipRRect(
                              child: Image.file(
                                image!.absolute,
                                width: 100,
                                height: 100,
                                fit: BoxFit.fill,
                              ),
                            )
                          : Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.camera_alt),
                            ),
                    ),
                  ),
                ),
                Form(
                  key: _formkey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: titleEditingController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: 'Title',
                            hintStyle: TextStyle(color: Colors.black),
                            prefixIcon: Icon(Icons.book),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String value) {
                            title = value;
                          },
                          validator: (value) {
                            return value!.isEmpty
                                ? 'please enter your Title'
                                : null;
                          },
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: descriptionEditingController,
                          maxLines: 10,
                          decoration: const InputDecoration(
                            hintText: 'Descrition ',
                            hintStyle: TextStyle(
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String value) {
                            description = value;
                          },
                          validator: (value) {
                            return value!.isEmpty
                                ? 'please enter your Descrition'
                                : null;
                          },
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        MyButton(
                          title: 'Upload',
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              try {
                                addPost();
                                Get.back();
                              } catch (e) {
                                // ignore: avoid_print
                                print(e.toString());
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  imagesPicker(ImageSource source) async {
    final XFile? photo = await ImagePicker().pickImage(source: source);
    setState(() {
      if (photo == null) {
        return;
      } else {
        image = File(photo.path);
        uploadImage();
      }
    });
  }

  addPost() async {
    final imageUrl = await uploadImage();
    dynamic res = await databaseManager.createPost(titleEditingController.text,
        descriptionEditingController.text, imageUrl);
    if (res == null) {
    } else {}
  }

  Future uploadImage() async {
    String postId = DateTime.now().millisecondsSinceEpoch.toString();

    Reference reference = FirebaseStorage.instance
        .ref()
        .child('postsImages')
        .child("$postId.jpg");
    await reference.putFile(image!);
    String downloadsUrlImage = await reference.getDownloadURL();
    return downloadsUrlImage;
  }
}
