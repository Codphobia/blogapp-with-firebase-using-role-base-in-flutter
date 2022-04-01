import 'package:blogapp/services%20screens/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();

 return runApp(  MyApp( ));

}

class MyApp extends StatelessWidget {

    MyApp({Key? key, }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   GetMaterialApp(
      title: 'my blog App',
      debugShowCheckedModeBanner: false,
theme: ThemeData(brightness: Brightness.dark),
      home:SplashScreen(),

    );
  }
}