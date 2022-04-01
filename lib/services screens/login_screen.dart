 import 'package:blogapp/services/authmanager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/databasemanager.dart';
import '../widgets/mybutton.dart';
import 'forgot_screen_user.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthServices authServices = AuthServices();
  DatabaseManager databaseManager = DatabaseManager();
  final _formkey = GlobalKey<FormState>();
  var emailEditingController = TextEditingController();
  var passwordEditingController = TextEditingController();
  bool _obscureText = true;
  String email = "", password = "";
  late SharedPreferences storeData;

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();

demo();

  }
  Future<void> demo()async {
    storeData =await  SharedPreferences.getInstance();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xdfe38d2c),
        title: const Text(
          'Login Screen',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('profileInfo').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formkey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width,
                          child: Lottie.asset('assets/json_images/blog.json'),
                        ),
                        TextFormField(
                          controller: emailEditingController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.black),
                            prefixIcon: Icon(Icons.email),
                          ),
                          onChanged: (String value) {
                            email = value;
                          },
                          validator: (value) {
                            return value!.isEmpty
                                ? 'please enter your email'
                                : null;
                          },
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        TextFormField(
                          controller: passwordEditingController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'Password',
                            hintStyle: const TextStyle(color: Colors.black),
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          onChanged: (String value) {
                            password = value;
                          },
                          validator: (value) {
                            return value!.isEmpty
                                ? 'please enter your password'
                                : null;
                          },
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        MyButton(
                          title: 'Login',
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              storeData.setString(
                                  'enterEmail', emailEditingController.text.toString());

                              Get.back();
                              login();
                            }
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () async {
                                  Get.to(const ForgotScreen(),
                                      transition: Transition.leftToRight,
                                      duration: Duration(seconds: 2));
                                },
                                child: const Text('Forgot Password..?')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  void login() async {
    try {
      dynamic result = await authServices.signInWithEmail(
          emailEditingController.text, passwordEditingController.text);

      if (result == null) {
        Fluttertoast.showToast(
            msg: 'sign in error, could not be able to login');
      } else {
        Get.back();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
