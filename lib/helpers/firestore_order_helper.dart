import 'package:admin_grad_pro/lviewmodels/cart_view_model.dart';
import 'package:admin_grad_pro/model/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FireStoreOrderHelper {
  FireStoreOrderHelper._();
  static FireStoreOrderHelper fireStoreOrderHelper = FireStoreOrderHelper._();

  FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  CartViewModel _cartViewModel = Get.find<CartViewModel>();

  Future<void> addOrderToFireStore(OrderModel orderModel) async {
    await _firebaseFireStore
        .collection('Orders')
        .doc(_firebaseAuth.currentUser.uid.toString())
        .collection('UserOrders')
        .add(orderModel.toJson());
    _cartViewModel.clearDataBase();

    var newProductRef = _firebaseFireStore.collection('NewOrders').doc();
    newProductRef.set({
      'orderId': newProductRef.id,
      'dateTime': orderModel.dateTime,
      'mapAddress': orderModel.mapAddress,
      'mapProducts': orderModel.mapProducts,
      'totalPrice': orderModel.totalPrice,
    });
  }

  Future<QuerySnapshot> getUserOrdersFromFireStore(String uid) async {
    return await _firebaseFireStore
        .collection('Orders')
        .doc(uid)
        .collection('UserOrders')
        .get();
  }
}
