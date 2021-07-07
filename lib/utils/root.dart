import 'package:finance/constants/controller.dart';
import 'package:finance/controllers/authController.dart';
import 'package:finance/controllers/user_controller.dart';
import 'package:finance/screens/LogIn/login.dart';
import 'package:finance/screens/home/homePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<AuthContoller>(
      init: Get.find<AuthContoller>(),
      builder: (authContoller) {
        if (authContoller.user != null) {
          return HomePage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
