import 'package:finance/controllers/list_of_spending_controller.dart';
import 'package:finance/controllers/user_controller.dart';
import 'package:finance/services/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void getDialogDeleteSpend(int index) {
  Get.defaultDialog(
    title: "Warning!!",
    content: Column(
      children: [
        Center(
          child: Text(
            "Do you realy want to delete this spend?",
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: Text("Delete"),
                onPressed: () {
                  Database().removeSpending(
                      Get.find<UserController>().user!.id,
                      Get.find<ListOfSpendingController>()
                          .listOfSpending![index]
                          .id);
                  Get.back();
                },
              ),
              TextButton(
                child: Text("Cancel"),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
