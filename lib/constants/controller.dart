import 'package:finance/controllers/authController.dart';
import 'package:finance/controllers/create_spend_controller.dart';
import 'package:finance/controllers/list_of_spending_controller.dart';
import 'package:finance/controllers/total_score_controller.dart';
import 'package:finance/controllers/user_controller.dart';

AuthContoller authContoller = AuthContoller.instance;
UserController userController = UserController.instance;
ListOfSpendingController listOfSpendingController =
    ListOfSpendingController.instance;
CreateSpendController createSpendController = CreateSpendController.instance;
TotalScoreController totalScoreController = TotalScoreController.instance;
