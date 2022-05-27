import 'dart:async';
import 'package:blogapp/services%20screens/state_check.dart';
import 'package:blogapp/services/authmanager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String uid;

  const EmailVerificationScreen({Key? key, required this.uid})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  late Timer timer;
  bool? verified;
  AuthServices authServices = AuthServices();
  @override
  void initState() {
    authServices.sendEmailForVerification();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      verified = authServices.emailVerification();

      verified == true ? checkEmailVerified(true) : checkEmailVerified(false);
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
            child: const Center(
              child: Text(
                "We have sent an Email. Please check your Email to verify this account.",
                style: TextStyle(
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Spacer(),
          Center(
            child: TextButton(
                onPressed: () {
                  authServices.logout();
                },
                child: const Text(
                  "Already have an Account?",
                )),
          )
        ],
      ),
    );
  }

  Future<void> checkEmailVerified(bool isVerified) async {
    if (isVerified) {
      timer.cancel();
      Get.offAll(
        () => const StateCheck(),
      );
    }
  }
}
