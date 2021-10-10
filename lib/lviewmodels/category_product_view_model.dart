import 'package:admin_grad_pro/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class CategoryProductViewModel extends GetxController {
  FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;

  List<ProductModel> _productCategoryModels = [];
  List<ProductModel> get productCategoryModels => _productCategoryModels;

  CategoryProductViewModel(String id) {
    getCategoryProducts(id);
  }

  getCategoryProducts(String id) async {
    _loading.value = true;
    QuerySnapshot<Map<String, dynamic>> value = await _firebaseFireStore
        .collection('Categories')
        .doc(id)
        .collection(id)
        .get();

    for (int i = 0; i < value.docs.length; i++) {
      _productCategoryModels.add(ProductModel.fromJson(value.docs[i].data()));
      _loading.value = false;
    }

    update();
  }
}
