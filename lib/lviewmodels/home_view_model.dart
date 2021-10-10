import 'dart:io';

import 'package:admin_grad_pro/helpers/admin_firestore_helper.dart';
import 'package:admin_grad_pro/helpers/firestorage_helper.dart';
import 'package:admin_grad_pro/helpers/home_helper.dart';
import 'package:admin_grad_pro/model/category_model.dart';
import 'package:admin_grad_pro/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeViewModel extends GetxController {
  ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;

  List<CategoryModel> _categoryModels = [];
  List<CategoryModel> get categoryModels => _categoryModels;

  List<ProductModel> _productModels = [];
  List<ProductModel> get productModels => _productModels;

  CategoryModel selectedCategory;

  TextEditingController nameController = TextEditingController();

  selectCategory(CategoryModel categoryModel) {
    this.selectedCategory = categoryModel;
    update();
  }

  HomeViewModel() {
    getCategory();
    getAllProducts();
  }

  getCategory() async {
    _loading.value = true;
    await HomeHelper.homeHelper.getCategory().then((value) {
      for (int i = 0; i < value.length; i++) {
        _categoryModels.add(CategoryModel.fromJson(value[i].data()));
        _loading.value = false;
      }
    });
    selectedCategory = _categoryModels.first;
    update();
  }

  getAllProducts() async {
    _loading.value = true;
    _productModels = [];
    await HomeHelper.homeHelper.getAllProducts().then((value) {
      for (int i = 0; i < value.length; i++) {
        _productModels.add(ProductModel.fromJson(value[i].data()));
        _loading.value = false;
      }
    });
    update();
  }

  addCategoryToFireStore() async {
    String imageUrl = await FirebaseStorageHelper.firebaseStorageHelper
        .uploadCategoryImage(file);

    await AdminFireStoreHelper.adminFireStoreHelper.addCategory(
      name: nameController.text,
      //TODO: add image backup
      image: imageUrl,
    );

    Get.defaultDialog(
      title: 'Category added to firebase',
      titleStyle: TextStyle(fontSize: 25),
      middleText: 'The Category was added successfully',
      middleTextStyle: TextStyle(fontSize: 20),
      radius: 30,
      textConfirm: 'OK',
      onConfirm: () {
        resetControllers();
        file = null;
        _categoryModels.clear();
        getCategory();
        Get.back();
      },
    );
  }

  editCategoryInFireStore() async {
    String imageUrl;
    if (updatedFile != null) {
      imageUrl = await FirebaseStorageHelper.firebaseStorageHelper
          .uploadCategoryImage(updatedFile);
    }

    await AdminFireStoreHelper.adminFireStoreHelper.updateCategory(
      name: nameController.text,
      id: selectedCategory.id,
      image: imageUrl ?? selectedCategory.image,
    );

    Get.defaultDialog(
      title: 'Editing Category ',
      titleStyle: TextStyle(fontSize: 25),
      middleText: 'The Category was edited successfully',
      middleTextStyle: TextStyle(fontSize: 20),
      radius: 30,
      textConfirm: 'OK',
      onConfirm: () {
        _categoryModels.clear();
        getCategory();
        Get.back();
      },
    );
  }

  deleteCategory({@required String id}) async {
    await AdminFireStoreHelper.adminFireStoreHelper.deleteCategory(id: id);
    _categoryModels.clear();
    getCategory();
    getAllProducts();
  }

  fillControllers() {
    nameController.text = selectedCategory.name;
  }

  resetControllers() {
    nameController.clear();
  }

  File file;
  selectFile() async {
    XFile imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    this.file = File(imageFile.path);
    update();
  }

  File updatedFile;
  captureUpdateCategoryImage() async {
    XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
    this.updatedFile = File(file.path);
    update();
  }
}
