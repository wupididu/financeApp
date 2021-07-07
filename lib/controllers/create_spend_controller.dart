import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance/constants/controller.dart';
import 'package:finance/constants/list_type_of_spending.dart';
import 'package:finance/models/spending.dart';
import 'package:finance/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateSpendController extends GetxController {
  static CreateSpendController instance = Get.find();
  Rx<String> typeOfSpending = Rx<String>(listTypeOfSpending[0]);
  TextEditingController expense = TextEditingController();

  void onChangedTypeOfSpending(String value) {
    typeOfSpending.value = value;
  }

  void addToDb() {
    if (expense.text.isNotEmpty) {
      Database().addSpending(
          userController.user!.id,
          SpendingModel(typeOfSpending.value, double.parse(expense.value.text),
              Timestamp.now()));
      _clearController();
    }
  }

  void _clearController() {
    expense.clear();
    typeOfSpending.value = listTypeOfSpending[0];
  }
}
