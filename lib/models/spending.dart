import 'package:cloud_firestore/cloud_firestore.dart';

class SpendingModel {
  static const ID = 'id';
  static const TYPE_OF_SPENDING = 'typeOfSending';
  static const EXPENCE = 'expence';
  static const DATE = 'date';

  late String id;
  late String typeOfSpending;
  late double expense;
  late Timestamp date;

  SpendingModel(String typeOfSpending, double expense, Timestamp date) {
    this.typeOfSpending = typeOfSpending;
    this.expense = expense;
    this.date = date;
  }

  SpendingModel.fromMap(Map<String, dynamic> data) {
    this.id = data[ID];
    this.typeOfSpending = data[TYPE_OF_SPENDING].toString();
    this.expense = data[EXPENCE].toDouble();
    this.date = data[DATE];
  }

  SpendingModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    this.id = documentSnapshot.id;
    this.expense = documentSnapshot[EXPENCE];
    this.date = documentSnapshot[DATE];
    this.typeOfSpending = documentSnapshot[TYPE_OF_SPENDING];
  }

  Map<String, dynamic> toJson() => {
        TYPE_OF_SPENDING: typeOfSpending,
        EXPENCE: expense,
        DATE: date,
      };
}
