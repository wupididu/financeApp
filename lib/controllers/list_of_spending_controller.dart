import 'package:finance/controllers/authController.dart';
import 'package:finance/models/spending.dart';
import 'package:finance/services/database.dart';
import 'package:get/get.dart';

class ListOfSpendingController extends GetxController {
  static ListOfSpendingController instance = Get.find();
  Rxn<List<SpendingModel>> _listOfSpending = Rxn<List<SpendingModel>>();

  List<SpendingModel>? get listOfSpending => _listOfSpending.value;

  set listOfSpending(List<SpendingModel>? value) => listOfSpending = value;

  @override
  void onInit() {
    bind();
    super.onInit();
  }

  void bind() => _listOfSpending
      .bindStream(Database().spendingStream(Get.find<AuthContoller>().user));

  @override
  void refresh() {
    _listOfSpending.refresh();
    super.refresh();
  }
}
