import 'package:finance/constants/controller.dart';
import 'package:finance/constants/firebase.dart';
import 'package:finance/controllers/list_of_spending_controller.dart';
import 'package:finance/controllers/total_score_controller.dart';
import 'package:finance/controllers/user_controller.dart';
import 'package:finance/models/user.dart';
import 'package:finance/screens/LogIn/login.dart';
import 'package:finance/screens/home/homePage.dart';
import 'package:finance/screens/loaded_page.dart';
import 'package:finance/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthContoller extends GetxController {
  static AuthContoller instance = Get.find();
  Rxn<User> _firebaseUser = Rxn<User>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repeatPassword = TextEditingController();
  Rxn<String> errorMatchPasswordText = Rxn<String>(null);
  Rxn<String> errorIncorrectPassword = Rxn<String>(null);

  set firebaseUser(User? user) => _firebaseUser.value = user;
  User? get user => _firebaseUser.value;

  @override
  void onInit() {
    super.onInit();
    repeatPassword.addListener(_correctMatchPasswordsListner);
    password.addListener(_correctPasswordListner);
    _firebaseUser.bindStream(auth.userChanges());
    auth.userChanges().listen(_userChangeListner);
  }

  void signIn() async {
    try {
      await auth
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) async {
        Get.find<UserController>().user =
            await Database().getUser(result.user!.uid);
        _clearControllers();
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Sign In Failed", "Try again ",
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      print("hello");
      print(e);
    }
  }

  void signUp() async {
    try {
      if (isCorrectPassword()) {
        await auth
            .createUserWithEmailAndPassword(
                email: email.text.trim(), password: password.text.trim())
            .then((result) async {
          String _userId = result.user!.uid;
          Database().createNewUser(UserModel(_userId, email.text.trim()));
          _clearControllers();
        });
      } else {
        Get.snackbar("Sign In Failed", "Dont match a passwards",
            snackPosition: SnackPosition.BOTTOM);
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Sign In Failed", "Try again",
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      print(e);
    }
  }

  void singOut() => auth.signOut();

  void _clearControllers() {
    email.clear();
    password.clear();
    repeatPassword.clear();
  }

  void _correctMatchPasswordsListner() {
    if (repeatPassword.text != password.text &&
        repeatPassword.text.length != 0) {
      errorMatchPasswordText.value = 'Not Match';
    } else {
      errorMatchPasswordText.value = null;
    }
  }

  void _correctPasswordListner() {
    if (password.text.length < 8 && password.text.length != 0) {
      errorIncorrectPassword.value = 'Password should have 8 and more symdol';
    } else {
      errorIncorrectPassword.value = null;
    }
  }

  void _userChangeListner(User? user) {
    if (user != null) {
      Get.find<UserController>().user =
          UserModel(user.uid.toString(), user.email.toString());

      Get.find<TotalScoreController>().refresh();
      Get.find<ListOfSpendingController>().refresh();
    } else {
      Get.find<UserController>().user = null;
    }
  }

  bool isCorrectPassword() =>
      password.text == repeatPassword.text && password.text.length >= 8;
}
