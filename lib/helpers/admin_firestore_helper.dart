import 'package:admin_grad_pro/model/order_model.dart';
import 'package:admin_grad_pro/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AdminFireStoreHelper {
  AdminFireStoreHelper._();
  static AdminFireStoreHelper adminFireStoreHelper = AdminFireStoreHelper._();

  FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  addProduct({
    @required String name,
    @required String description,
    @required String image,
    @required String colorString,
    @required String price,
    @required String size,
    @required String brand,
    @required String categoryId,
  }) async {
    var newProductRef = _firebaseFireStore.collection('Products').doc();
    await newProductRef.set({
      'productId': newProductRef.id,
      'name': name,
      'image': image,
      'description': description,
      'colorString': colorString,
      'size': size,
      'price': price,
      'brand': brand,
      'categoryId': categoryId,
    });
    await _firebaseFireStore
        .collection('Categories')
        .doc(categoryId)
        .collection(categoryId)
        .doc(newProductRef.id)
        .set({
      'productId': newProductRef.id,
      'name': name,
      'image': image,
      'description': description,
      'colorString': colorString,
      'size': size,
      'price': price,
      'brand': brand,
      'categoryId': categoryId,
    });
  }

  addCategory({
    @required String name,
    @required String image,
  }) async {
    var newProductRef = _firebaseFireStore.collection('Categories').doc();
    await newProductRef.set({
      'id': newProductRef.id,
      'name': name,
      'image': image,
    });
  }

  updateCategory({
    @required String id,
    @required String name,
    @required String image,
  }) {
    _firebaseFireStore.collection('Categories').doc(id).set({
      'id': id,
      'name': name,
      'image': image,
    });
  }

  deleteCategory({@required String id}) async {
    await _firebaseFireStore
        .collection('Categories')
        .doc(id)
        .collection(id)
        .get()
        .then((snapshot) {
      List<DocumentSnapshot> allDocs = snapshot.docs;
      for (int i = 0; i < allDocs.length; i++) {
        _firebaseFireStore
            .collection('Categories')
            .doc(id)
            .collection(id)
            .doc(allDocs[i].id)
            .delete();
        _firebaseFireStore.collection('Products').doc(allDocs[i].id).delete();
      }
    });
    await _firebaseFireStore.collection('Categories').doc(id).delete();
  }

  getAllProducts() async {
    QuerySnapshot value = await _firebaseFireStore.collection('Products').get();
    return value.docs;
  }

  getProduct(String productId) async {
    DocumentSnapshot value =
        await _firebaseFireStore.collection('Products').doc(productId).get();
    return value;
  }

  updateProduct({ProductModel productModel, String categoryId}) async {
    await _firebaseFireStore
        .collection('Products')
        .doc(productModel.productId)
        .set({
      'productId': productModel.productId,
      'categoryId': categoryId,
      'name': productModel.name,
      'image': productModel.image,
      'description': productModel.description,
      'colorString': productModel.colorString,
      'size': productModel.size,
      'price': productModel.price,
      'brand': productModel.brand,
    });

    await deleteCollectionProduct(
      categoryId: productModel.categoryId,
      productId: productModel.productId,
    );

    await _firebaseFireStore
        .collection('Categories')
        .doc(categoryId)
        .collection(categoryId)
        .doc(productModel.productId)
        .set({
      'productId': productModel.productId,
      'name': productModel.name,
      'image': productModel.image,
      'description': productModel.description,
      'colorString': productModel.colorString,
      'size': productModel.size,
      'price': productModel.price,
      'brand': productModel.brand,
      'categoryId': categoryId,
    });
  }

  deleteProduct(String productId) async {
    _firebaseFireStore.collection('Products').doc(productId).delete();
  }

  deleteCollectionProduct({String categoryId, String productId}) async {
    _firebaseFireStore
        .collection('Categories')
        .doc(categoryId)
        .collection(categoryId)
        .doc(productId)
        .delete();
  }

  addAddressToFirebase({
    @required String name,
    @required List neighborhoods,
  }) async {
    var newProductRef = _firebaseFireStore.collection('Cities').doc();
    await newProductRef.set({
      'id': newProductRef.id,
      'name': name,
      'neighborhoods': neighborhoods,
    });
  }

  editAddressInFireStore({
    @required String id,
    @required String name,
    @required List neighborhoods,
  }) async {
    await _firebaseFireStore.collection('Cities').doc(id).set({
      'id': id,
      'name': name,
      'neighborhoods': neighborhoods,
    });
  }

  deleteAddressFromFirebase(String id) async {
    await _firebaseFireStore.collection('Cities').doc(id).delete();
  }

  /// ORDERS SECTION

  Future<QuerySnapshot> getAllOrdersFromFireStore(String collectionName) async {
    return await _firebaseFireStore.collection(collectionName).get();
  }

  Future<void> addOrderToDoneOrdersFireStore(OrderModel orderModel) async {
    await _firebaseFireStore
        .collection('DoneOrders')
        .doc(orderModel.orderId)
        .set(orderModel.toJson());
  }

  deleteOrder(String orderId) async {
    _firebaseFireStore.collection('NewOrders').doc(orderId).delete();
  }

  getAllUsers() async {
    QuerySnapshot users = await _firebaseFireStore.collection('Users').get();
    return users.docs;
  }

  // deleteUser(String id) async {
  //   await _firebaseFireStore.collection('Users').doc(id).delete();
  // }
}
