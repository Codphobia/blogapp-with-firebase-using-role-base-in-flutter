 import 'package:blogapp/services/authmanager.dart';
import 'package:flutter/material.dart';
 import 'package:lottie/lottie.dart';


import '../widgets/mybutton.dart';


class ForgotScreen extends StatefulWidget {

  const ForgotScreen({Key? key, }) : super(key: key);

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final _formkey = GlobalKey<FormState>();
  AuthServices authServices=AuthServices();
  var emailEditingController = TextEditingController();


  String email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xdfe38d2c),
        title: const Text(
          'Forgot Screen',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  child: Lottie.asset('assets/json_images/blog.json'),
                ),
                const SizedBox(
                  height: 20,
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
                MyButton(
                    title: 'Reset',
                    onPressed: () async {

                      if (_formkey.currentState!.validate()) {

                        authServices.sendPasswordResetEmail(emailEditingController.text.toString().trim());

                      }

                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
