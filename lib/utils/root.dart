import 'package:finance/constants/controller.dart';
import 'package:finance/controllers/authController.dart';
import 'package:finance/controllers/user_controller.dart';
import 'package:finance/screens/LogIn/login.dart';
import 'package:finance/screens/home/homePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Root extends GetWidget<AuthContoller> {
  @override
  Widget build(BuildContext context) {
    return GetX(
      initState: (_) async {
        Get.put<UserController>(UserController());
      },
      builder: (UserController userController) {
        if (userController.user != null) {
          return HomePage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
