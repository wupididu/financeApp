import 'package:finance/constants/controller.dart';
import 'package:finance/controllers/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends GetView<AuthContoller> {
  final AuthContoller _authContoller = Get.find();

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
                controller: _authContoller.email,
                decoration: InputDecoration(labelText: 'email'),
              ),
              TextFormField(
                controller: _authContoller.password,
                decoration: InputDecoration(
                    labelText: 'password',
                    errorText: _authContoller.errorIncorrectPassword.value),
              ),
              TextFormField(
                controller: _authContoller.repeatPassword,
                decoration: InputDecoration(
                    labelText: 'repeat password',
                    errorText: _authContoller.errorMatchPasswordText.value),
              ),
              TextButton(
                onPressed: () {
                  _authContoller.signUp();
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
