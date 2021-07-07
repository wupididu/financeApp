import 'package:finance/constants/controller.dart';
import 'package:finance/constants/list_type_of_spending.dart';
import 'package:finance/controllers/authController.dart';
import 'package:finance/services/database.dart';
import 'package:get/get.dart';

class TotalScoreController extends GetxController {
  static TotalScoreController instance = Get.find();
  Rx<double> _totalScore = 0.0.obs;

  List<Rx<double>> _list =
      List.generate(listTypeOfSpending.length, (index) => 0.0.obs);

  double get totalScore => _totalScore.value;
  double getTotalScoreOfProducts(int index) =>
      index < listTypeOfSpending.length ? _list[index].value : 0.0;

  @override
  void onInit() {
    _totalScore.bindStream(
        Database().totalScoreStream(Get.find<AuthContoller>().user));
    int i = 0;
    _list.forEach((element) {
      print(listTypeOfSpending[i]);
      element.bindStream(Database().totalScoreStreamOf(
          Get.find<AuthContoller>().user, listTypeOfSpending[i]));
      i++;
    });

    super.onInit();
  }
}
