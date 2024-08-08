
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'SignUp/Login/login_screen.dart';
import 'SignUp/signUp_screen.dart';
import 'firebase_auth_controller/auth_controller.dart';
import 'firebase_options.dart';
import 'home_screen.dart';
// import 'auth_controller.dart';
// import 'home_screen.dart';
// import 'login_page.dart';
// import 'signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SignupPage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/home', page: () => HomeScreen2()),
      ],
    );
  }
}
