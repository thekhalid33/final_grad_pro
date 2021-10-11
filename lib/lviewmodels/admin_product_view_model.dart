import 'dart:io';

import 'package:admin_grad_pro/helpers/admin_firestore_helper.dart';
import 'package:admin_grad_pro/helpers/firestorage_helper.dart';
import 'package:admin_grad_pro/lviewmodels/home_view_model.dart';
import 'package:admin_grad_pro/model/category_model.dart';
import 'package:admin_grad_pro/model/product_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdminProductViewModel extends GetxController {
  AdminProductViewModel() {
    getAllProducts();
  }
  ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController brandController = TextEditingController();

  ProductModel productToEdit;

  List<ProductModel> _products = [];
  get products => _products;

  addProductToFireStore({@required CategoryModel categoryModel}) async {
    _loading.value = true;
    String imageUrl = await FirebaseStorageHelper.firebaseStorageHelper
        .uploadProductsImage(file);

    await AdminFireStoreHelper.adminFireStoreHelper.addProduct(
      name: nameController.text,
      description: descriptionController.text,
      //TODO: add image backup
      image: imageUrl,
      colorString: colorController.text,
      price: priceController.text,
      size: sizeController.text,
      brand: brandController.text,
      categoryId: categoryModel.id,
    );

    await Get.find<HomeViewModel>().getAllProducts();
    Get.defaultDialog(
      title: 'Product added to firebase',
      titleStyle: TextStyle(fontSize: 25),
      middleText: 'The product was added successfully',
      middleTextStyle: TextStyle(fontSize: 20),
      radius: 30,
      textConfirm: 'OK',
      onConfirm: () {
        resetControllers();
        getAllProducts();
        Get.back();
      },
    );
    _loading.value = false;

    update();
  }

  getProductFromFireStore(String productId) async {
    _loading.value = true;

    productToEdit =
        await AdminFireStoreHelper.adminFireStoreHelper.getProduct(productId);
    _loading.value = false;

    update();
  }

  getAllProducts() async {
    _loading.value = true;
    _products = [];
    List list =
        await AdminFireStoreHelper.adminFireStoreHelper.getAllProducts();
    for (int i = 0; i < list.length; i++) {
      _products.add(ProductModel.fromJson(list[i].data()));
    }
    _loading.value = false;
    update();
  }

  updateProduct({@required CategoryModel categoryModel}) async {
    _loading.value = true;

    String imageUrl;
    if (updatedFile != null) {
      imageUrl = await FirebaseStorageHelper.firebaseStorageHelper
          .uploadProductsImage(updatedFile);
    }
    String c = colorController.text.substring(10, 16);

    ProductModel productModel = ProductModel(
      productId: productToEdit.productId,
      categoryId: productToEdit.categoryId,
      name: nameController.text,
      image: imageUrl ?? productToEdit.image,
      description: descriptionController.text,
      colorString: c,
      size: sizeController.text,
      price: priceController.text,
      brand: brandController.text,
    );
    AdminFireStoreHelper.adminFireStoreHelper.updateProduct(
        productModel: productModel, categoryId: categoryModel.id);
    await getAllProducts();
    await Get.find<HomeViewModel>().getAllProducts();
    _loading.value = false;
    Get.back();
    Get.snackbar('Editing Product', 'The product was edited successfully');
    update();
  }

  fillControllers(ProductModel productModel) {
    nameController.text = productModel.name;
    descriptionController.text = productModel.description;
    colorController.text = productModel.color.toString();
    sizeController.text = productModel.size;
    priceController.text = productModel.price;
    brandController.text = productModel.brand;
  }

  resetControllers() {
    nameController.clear();
    descriptionController.clear();
    colorController.clear();
    sizeController.clear();
    priceController.clear();
    brandController.clear();
  }

  deleteProduct({String categoryId, String productId}) async {
    _loading.value = true;

    await AdminFireStoreHelper.adminFireStoreHelper.deleteProduct(productId);
    await AdminFireStoreHelper.adminFireStoreHelper
        .deleteCollectionProduct(categoryId: categoryId, productId: productId);
    await getAllProducts();
    await Get.find<HomeViewModel>().getAllProducts();
    _loading.value = false;

    update();
  }

  File file;
  selectFile() async {
    XFile imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    this.file = File(imageFile.path);
    update();
  }

  File updatedFile;
  captureUpdateProductImage() async {
    XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
    this.updatedFile = File(file.path);
    update();
  }
}
