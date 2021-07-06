import 'package:finance/constants/controller.dart';
import 'package:finance/controllers/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends GetView<AuthContoller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
      ),
      body: Container(
        child: Obx(
          () => Column(
            children: [
              TextFormField(
                controller: authContoller.email,
                decoration: InputDecoration(labelText: 'email'),
              ),
              TextFormField(
                controller: authContoller.password,
                decoration: InputDecoration(
                    labelText: 'password',
                    errorText: authContoller.errorIncorrectPassword.value),
                obscureText: true,
              ),
              TextFormField(
                controller: authContoller.repeatPassword,
                decoration: InputDecoration(
                    labelText: 'repeat password',
                    errorText: authContoller.errorMatchPasswordText.value),
                obscureText: true,
              ),
              TextButton(
                onPressed: () {
                  authContoller.signUp();
                },
                child: Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
