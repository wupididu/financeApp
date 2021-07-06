import 'package:finance/constants/controller.dart';
import 'package:finance/controllers/authController.dart';
import 'package:finance/screens/signup/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        child: Column(
          children: [
            TextFormField(
              controller: authContoller.email,
              decoration: InputDecoration(labelText: 'email'),
            ),
            TextFormField(
              controller: authContoller.password,
              decoration: InputDecoration(labelText: 'password'),
              obscureText: true,
            ),
            TextButton(
              onPressed: () {
                authContoller.signIn();
              },
              child: Text("Sign In"),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Get.to(SignUpPage());
              },
              child: Text("Registraition"),
            ),
          ],
        ),
      ),
    );
  }
}
