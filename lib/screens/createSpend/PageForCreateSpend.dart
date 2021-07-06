import 'package:finance/constants/controller.dart';
import 'package:finance/constants/list_type_of_spending.dart';
import 'package:finance/controllers/create_spend_controller.dart';
import 'package:finance/models/spending.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PageForCreateSpend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create spend"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GetX<CreateSpendController>(
                builder: (_) => Column(
                  children: [
                    InputDecorator(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            onChanged: (value) {
                              createSpendController
                                  .onChangedTypeOfSpending(value.toString());
                            },
                            value: createSpendController.typeOfSpending.value,
                            isDense: true,
                            items: listTypeOfSpending
                                .map((e) =>
                                    DropdownMenuItem(value: e, child: Text(e)))
                                .toList()),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      controller: createSpendController.expense,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    TextButton(
                        onPressed: () {
                          createSpendController.addToDb();
                          Get.back();
                        },
                        child: Text("Create"))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
