import 'package:blogapp/services/authmanager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
 import '../widgets/mybutton.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    Key? key,
  }) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  AuthServices authServices = AuthServices();

  final _formkey = GlobalKey<FormState>();
  var emailEditingController = TextEditingController();
  var passwordEditingController = TextEditingController();
  var nameEditingController = TextEditingController();

  String email = '', name = '', password = '';
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xdfe38d2c),
        title: const Text(
          'Register Screen',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                    controller: nameEditingController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Name',
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(Icons.person),
                    ),
                    onChanged: (String value) {
                      name = value;
                    },
                    validator: (value) {
                      return value!.isEmpty ? 'please enter your name' : null;
                    },
                  ),
                  const SizedBox(
                    height: 14,
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
                      return value!.isEmpty ? 'please enter your email' : null;
                    },
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                    controller: passwordEditingController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: Colors.black),
                      prefixIcon: const Icon(Icons.lock),
                      border: const OutlineInputBorder(),
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
                    height: 10,
                  ),
                  MyButton(
                    title: 'Register',
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        Get.back();
                        createUser();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void createUser() async {
    try {
     final result= await authServices.signUpWithEmail(emailEditingController.text,
          passwordEditingController.text, nameEditingController.text);
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
