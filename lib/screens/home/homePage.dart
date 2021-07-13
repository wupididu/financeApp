import 'package:finance/constants/list_type_of_spending.dart';
import 'package:finance/controllers/authController.dart';
import 'package:finance/controllers/list_of_spending_controller.dart';
import 'package:finance/controllers/total_score_controller.dart';
import 'package:finance/controllers/user_controller.dart';
import 'package:finance/screens/createSpend/PageForCreateSpend.dart';
import 'package:finance/services/database.dart';
import 'package:finance/screens/home/widgets/card_of_spending.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              child: GetX<UserController>(
                initState: (_) async {
                  Get.find<UserController>().user = await Database()
                      .getUser(Get.find<AuthContoller>().user!.uid);
                },
                init: Get.find<UserController>(),
                builder: (userController) {
                  if (userController.user != null) {
                    return Text(userController.user!.email);
                  } else {
                    return Text(
                        "Loading" + Get.find<AuthContoller>().user.toString());
                  }
                },
              ),
            ),
            SizedBox(width: 20),
            Container(
              child: GetX<TotalScoreController>(
                  init: Get.put<TotalScoreController>(TotalScoreController()),
                  builder: (TotalScoreController totalScoreController) {
                    totalScoreController.bind();
                    return Text(totalScoreController.totalScore.toString());
                  }),
            )
          ],
        ),
        actions: [
          Container(
            child: Center(
              child: IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  Get.find<AuthContoller>().singOut();
                },
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                scrollDirection: Axis.vertical,
                itemCount: listTypeOfSpending.length,
                itemBuilder: (_, index) => Container(
                  color: Colors.green[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(listTypeOfSpending[index]),
                      GetX(
                        init: Get.put<TotalScoreController>(
                            TotalScoreController()),
                        builder: (TotalScoreController totalScoreController) {
                          totalScoreController.bind();
                          return Text(totalScoreController
                              .getTotalScoreOfProducts(index)
                              .toString());
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: GetX<ListOfSpendingController>(
                init: Get.put<ListOfSpendingController>(
                    ListOfSpendingController()),
                builder: (ListOfSpendingController listOfSpendingController) {
                  listOfSpendingController.bind();
                  if (listOfSpendingController.listOfSpending != null) {
                    if (listOfSpendingController.listOfSpending!.length > 0) {
                      return ListView.builder(
                          itemCount:
                              listOfSpendingController.listOfSpending!.length,
                          itemBuilder: (_, index) {
                            return CardOfSpending(
                                listOfSpendingController:
                                    listOfSpendingController,
                                index: index);
                          });
                    } else
                      return Center(
                        child: Text('Nothing'),
                      );
                  } else {
                    return Text("Loading...");
                  }
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(PageForCreateSpend());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
