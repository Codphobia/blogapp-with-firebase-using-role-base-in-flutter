import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'databasemanager.dart';

class Users {
  Users({required this.uid});

  final String uid;
}

class AuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseManager databaseManager = DatabaseManager();

  Users? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    }
    return Users(uid: user.uid);
  }

  Stream<Users?> get onAuthStateChanged {
    return auth.authStateChanges().map(_userFromFirebase);
  }

  Future signInWithEmail(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseException catch (e) {
      Get.snackbar("error", e.message!,
          borderRadius: 15, snackPosition: SnackPosition.BOTTOM);
    }
  }

  bool getAccountStatus() {
    var isVerified = auth.currentUser!.emailVerified;

    return isVerified;
  }

  Future signUpWithEmail(String email, String password, String name) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      await databaseManager.createUserData(name, 'user', user!.uid, email);
      return user;
    } on FirebaseException catch (e) {
      Get.snackbar(
        "error",
        e.message!,
        borderRadius: 15,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<Users?> currentUser() async {
    final user = auth.currentUser;
    return _userFromFirebase(user);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email).then((value) {
        // ignore: avoid_print
        print('link send');
        Get.back();
      });
    } on FirebaseException catch (e) {
      Get.snackbar("error", e.message!,
          borderRadius: 15, snackPosition: SnackPosition.BOTTOM);
      Timer(const Duration(seconds: 2), () {});
    }
  }

  // 8 no function
  Future sendEmailForVerification() async {
    await auth.currentUser!.sendEmailVerification();
  }

  bool emailVerification() {
    User? user = auth.currentUser;
    user!.reload();
    return user.emailVerified;
  }

  void logout() async {
    await auth.signOut().then((value) => Get.back());
  }
}
