import 'package:finance/constants/controller.dart';
import 'package:finance/constants/firebase.dart';
import 'package:finance/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  Rxn<UserModel> _userModel = Rxn<UserModel>(null);
  String collection = 'user';

  UserModel? get user => _userModel.value;

  set user(UserModel? value) => this._userModel.value = value;

  void clear() {
    _userModel.value = UserModel.empty();
  }
}
