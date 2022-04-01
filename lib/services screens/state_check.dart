import 'package:blogapp/consts/my_const.dart';
import 'package:blogapp/services/authmanager.dart';
 import 'package:flutter/material.dart';

import '../screens for Admin/home_screen_admin.dart';
import '../screens for users/home_screen_user.dart';
import 'email_verification_screen.dart';
import 'option_screen.dart';

class StateCheck extends StatefulWidget {
  StateCheck({
    Key? key,
  }) : super(key: key);

  @override
  State<StateCheck> createState() => _StateCheckState();
}

class _StateCheckState extends State<StateCheck> {
  AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Users?>(
      stream: authServices.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          Users? user = snapshot.data;
          if (user == null) {
            return const OptionScreen();
          } else {
            String uid = authServices.auth.currentUser!.uid;
            return authServices.getAccountStatus() == false
                ? EmailVerificationScreen(
                    uid: uid,
                  )
                : Myconst.userEnterEmail == 'jamalkhanii691@gmail.com'
                    ? AdminHomeScreen()
                    : UserHomeScreen();
          }
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
