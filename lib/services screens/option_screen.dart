import 'package:blogapp/services%20screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';

import '../screens for users/register_screen_user.dart';
import '../widgets/mybutton.dart';

class OptionScreen extends StatefulWidget {
  const OptionScreen({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OptionScreenState createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Option Screen',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xdfe38d2c),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  child: Lottie.asset('assets/json_images/blog.json'),
                ),
                MyButton(
                  title: 'login',
                  onPressed: () => Get.to(const LoginScreen(),
                      transition: Transition.rightToLeft,
                      duration: const Duration(seconds: 1)),
                ),
                Row(children: const [
                  Expanded(child: Divider()),
                  Text("OR"),
                  Expanded(child: Divider()),
                ]),
                MyButton(
                  title: 'sign up',
                  onPressed: () => Get.to(const RegisterScreen(),
                      transition: Transition.leftToRight,
                      duration: const Duration(seconds: 1)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
