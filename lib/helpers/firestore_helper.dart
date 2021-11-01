import 'package:admin_grad_pro/lviewmodels/auth_view_model.dart';
import 'package:admin_grad_pro/model/city_model.dart';
import 'package:admin_grad_pro/model/register_request.dart';
import 'package:admin_grad_pro/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FireStoreHelper {
  FireStoreHelper._();

  static FireStoreHelper fireStoreHelper = FireStoreHelper._();

  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  Future<UserModel> getUserFromFireStore(String userId) async {
    DocumentSnapshot documentSnapshot =
        await firebaseFireStore.collection('Users').doc(userId).get();

    return UserModel.fromMap(documentSnapshot.data());
  }

  Future<List<CityModel>> getAllCities() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firebaseFireStore.collection('Cities').get();
      List<CityModel> cities = querySnapshot.docs.map((e) {
        Map map = e.data();
        return CityModel.fromJson(map);
      }).toList();
      return cities;
    } on Exception catch (e) {
      //TODO: errrorororoorro
      Get.defaultDialog(
          title: 'Error',
          titleStyle: TextStyle(fontSize: 25),
          middleText: e.toString(),
          middleTextStyle: TextStyle(fontSize: 20),
          textConfirm: 'OK',
          onConfirm: () {
            Get.back();
          });
      return null;
    }
  }

  addUserToFireStore(RegisterRequest registerRequest) async {
    try {
      await firebaseFireStore
          .collection('Users')
          .doc(registerRequest.id)
          .set(registerRequest.toMap());
    } on Exception catch (e) {
      //TODO: errrorororoorro
      Get.defaultDialog(
          title: 'Error',
          titleStyle: TextStyle(fontSize: 25),
          middleText: e.toString(),
          middleTextStyle: TextStyle(fontSize: 20),
          textConfirm: 'OK',
          onConfirm: () {
            Get.back();
          });
    }
  }

  updateProfile(UserModel userModel) async {
    await firebaseFireStore
        .collection('Users')
        .doc(userModel.id)
        .update(userModel.toMap());
  }
}
