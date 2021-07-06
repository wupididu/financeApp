import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance/constants/controller.dart';
import 'package:finance/models/spending.dart';
import 'package:finance/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
          .collection('listOfSpending')
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
          .collection('listOfSpending')
          .doc(spendingModelId)
          .delete();
    } catch (e) {
      print(e);
    }
  }

  Stream<List<SpendingModel>> spendingStream(User? _user) => _firestore
      .collection('user')
      .doc(_user?.uid)
      .collection('listOfSpending')
      .snapshots()
      .map((query) => List.generate(query.docs.length,
          (index) => SpendingModel.fromDocumentSnapshot(query.docs[index])));

  Future<UserModel> getUser(String uid) async => UserModel.fromSnapshot(
      await _firestore.collection('user').doc(uid).get());
}
