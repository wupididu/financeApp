import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const ID = 'id';
  static const EMAIL = 'email';
  static const TOTAL_SCORE = 'totalScore';
  static const LIST_OF_SPENDING_MODEL = 'listOfSpendingModel';

  late String id;
  late String email;
  UserModel.empty();

  UserModel(this.id, this.email);

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot[ID];
    email = snapshot[EMAIL];
  }

  @override
  String toString() {
    return super.toString() + id + email;
  }
}
