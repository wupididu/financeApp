import 'package:finance/controllers/authController.dart';
import 'package:finance/controllers/user_controller.dart';
import 'package:finance/utils/root.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthContoller());
    Get.put(UserController());
    //Get.put(ListOfSpendingController());
    //Get.put(CreateSpendController());
    //Get.put(TotalScoreController());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Root(),
    );
  }
}
