import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance/constants/controller.dart';
import 'package:finance/models/spending.dart';
import 'package:finance/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection('user').doc(user.id).set({
        UserModel.ID: user.id.trim(),
        UserModel.EMAIL: user.email.trim(),
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> addSpending(String uid, SpendingModel spendingModel) async {
    try {
      await _firestore
          .collection('user')
          .doc(uid)
          .collection(SpendingModel.COLLECTTION)
          .add(spendingModel.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<void> removeSpending(String uid, String spendingModelId) async {
    try {
      await _firestore
          .collection('user')
          .doc(uid)
          .collection(SpendingModel.COLLECTTION)
          .doc(spendingModelId)
          .delete();
    } catch (e) {
      print(e);
    }
  }

  Stream<List<SpendingModel>> spendingStream(User? _user) => _firestore
      .collection('user')
      .doc(_user?.uid)
      .collection(SpendingModel.COLLECTTION)
      .orderBy(SpendingModel.DATE, descending: true)
      .snapshots()
      .map((query) => List.generate(query.docs.length,
          (index) => SpendingModel.fromDocumentSnapshot(query.docs[index])));

  Stream<double> totalScoreStream(User? _user) async* {
    double score = 0.0;
    await for (var chunck in spendingStream(_user)) {
      score = chunck.fold(
          0, (previousValue, element) => previousValue += element.expense);
      yield score;
    }
  }

  Stream<double> totalScoreStreamOf(User? _user, String typeOfSpending) async* {
    double score = 0.0;
    await for (var chunck in spendingStreamOf(_user, typeOfSpending)) {
      score = chunck.fold(
          0, (previousValue, element) => previousValue += element.expense);
      yield score;
    }
  }

  Stream<List<SpendingModel>> spendingStreamOf(
          User? _user, String typeOfSpending) =>
      _firestore
          .collection('user')
          .doc(_user?.uid)
          .collection(SpendingModel.COLLECTTION)
          .where(SpendingModel.TYPE_OF_SPENDING, isEqualTo: typeOfSpending)
          .snapshots()
          .map((query) => List.generate(query.docs.length,
              (index) => SpendingModel.fromDocumentSnapshot(query.docs[index])))
          .handleError((e) {
        Get.snackbar('title', e.toString());
      });

  Future<UserModel> getUser(String uid) async => UserModel.fromSnapshot(
      await _firestore.collection('user').doc(uid).get());
}
