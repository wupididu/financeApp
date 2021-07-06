import 'package:finance/controllers/authController.dart';
import 'package:finance/controllers/list_of_spending_controller.dart';
import 'package:finance/controllers/user_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthContoller());
    Get.put(UserController());
    Get.put(ListOfSpendingController());
  }
}
