import 'package:finance/constants/controller.dart';
import 'package:finance/controllers/list_of_spending_controller.dart';
import 'package:finance/screens/home/widgets/dialog_delete_spend.dart';
import 'package:finance/services/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/dialog/dialog_route.dart';

class CardOfSpending extends StatelessWidget {
  final ListOfSpendingController listOfSpendingController;
  final int index;

  CardOfSpending(
      {Key? key, required this.listOfSpendingController, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        getDialogDeleteSpend(index);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 80,
          decoration: BoxDecoration(color: Colors.green[100]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(listOfSpendingController
                        .listOfSpending?[index].typeOfSpending ??
                    ''),
                Text(listOfSpendingController.listOfSpending?[index].expense
                        .toString() ??
                    ''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
