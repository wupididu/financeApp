import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance/constants/controller.dart';
import 'package:finance/controllers/authController.dart';
import 'package:finance/controllers/list_of_spending_controller.dart';
import 'package:finance/controllers/user_controller.dart';
import 'package:finance/models/spending.dart';
import 'package:finance/services/database.dart';
import 'package:finance/widgets/card_of_spending.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetWidget<AuthContoller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetX<UserController>(
          init: Get.put(UserController()),
          builder: (_userController) {
            if (_userController.user != null) {
              return Text(_userController.user!.email);
            } else {
              return Text("Loading" + authContoller.user.toString());
            }
          },
        ),
        actions: [
          Container(
            child: Center(
              child: IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  authContoller.singOut();
                },
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: GetX<ListOfSpendingController>(
          init: Get.put(ListOfSpendingController()),
          builder: (listOfSpendingController) {
            if (listOfSpendingController.listOfSpending != null) {
              return ListView.builder(
                  itemCount: listOfSpendingController.listOfSpending!.length,
                  itemBuilder: (_, index) {
                    return CardOfSpending(
                        listOfSpendingController: listOfSpendingController,
                        index: index);
                  });
            } else {
              return Text("Loading...");
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (authContoller.user != null) {
            Database().addSpending(authContoller.user!.uid,
                SpendingModel(TypeOfSpending.products, 1.0, Timestamp.now()));
          }
        },
      ),
    );
  }
}
