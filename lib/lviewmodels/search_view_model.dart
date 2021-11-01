import 'package:admin_grad_pro/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchViewModel extends GetxController {
  TextEditingController searchTextController = TextEditingController();

  FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;

  List<ProductModel> _productModels = [];
  List<ProductModel> get productModels => _productModels;

  queryData() async {
    _loading.value = true;
    productModels.clear();
    await _firebaseFireStore
        .collection('Products')
        .where(
          'name',
          isGreaterThanOrEqualTo: searchTextController.text,
        )
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        _productModels.add(ProductModel.fromJson(value.docs[i].data()));
        _loading.value = false;
      }
    });
    update();
  }

  clearing() {
    searchTextController.clear();
    productModels.clear();
    update();
  }
}
