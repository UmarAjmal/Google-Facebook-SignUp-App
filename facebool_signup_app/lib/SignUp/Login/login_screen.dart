import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../firebase_auth_controller/auth_controller.dart';
// import '../Firebase_Auth_Implementation/controler/firebase_auth_controler.dart';
// import 'auth_controller.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        backgroundColor: Colors.deepOrange,
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 50,
              color: Colors.deepOrange,
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 50,
              color: Colors.deepOrange,
              child: TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _authController.loginWithEmail(_emailController.text.trim(), _passwordController.text.trim()),
              child: Text("Login",style: TextStyle(color: Colors.black,),),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.toNamed('/signup'),
              child: Text("Sign Up",style: TextStyle(color: Colors.black,),),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
            ),
          ],
        ),
      ),
    );
  }
}
