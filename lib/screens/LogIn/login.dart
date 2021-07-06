import 'package:finance/constants/controller.dart';
import 'package:finance/controllers/authController.dart';
import 'package:finance/screens/signup/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final AuthContoller _authContoller = Get.find();

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
              controller: _authContoller.email,
              decoration: InputDecoration(labelText: 'email'),
            ),
            TextFormField(
              controller: _authContoller.password,
              decoration: InputDecoration(labelText: 'password'),
            ),
            TextButton(
              onPressed: () {
                _authContoller.signIn();
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
