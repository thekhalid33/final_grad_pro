import 'package:admin_grad_pro/helpers/database/cart_database_helper.dart';
import 'package:admin_grad_pro/model/cart_product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CartViewModel extends GetxController {
  ValueNotifier<bool> get loading => _loading;

  ValueNotifier<bool> _loading = ValueNotifier(false);

  List<CartProductModel> _cartProducts = [];

  List<CartProductModel> get cartProducts => _cartProducts;

  double _totalPrice = 0;

  double get totalPrice => _totalPrice;

  var dbHelper = CartDatabaseHelper.cartDatabaseHelper;

  CartViewModel() {
    getAllProducts();
  }

  addProduct(CartProductModel cartProductModel) async {
    for (int i = 0; i < _cartProducts.length; i++) {
      if (_cartProducts[i].productId == cartProductModel.productId) {
        Get.defaultDialog(
          title: 'The Product Was Added To Cart',
          titleStyle: TextStyle(fontSize: 25),
          middleText: 'The product was added To Cart successfully',
          middleTextStyle: TextStyle(fontSize: 20),
          radius: 30,
          textConfirm: 'OK',
          onConfirm: () {
            Get.back();
          },
        );

        return;
      }
    }
    await dbHelper.insert(cartProductModel);
    _cartProducts.add(cartProductModel);
    _totalPrice +=
        (double.parse(cartProductModel.price) * (cartProductModel.quantity));

    update();
  }

  getAllProducts() async {
    _loading = ValueNotifier(true);
    _cartProducts = [];
    _cartProducts = await dbHelper.getAllProducts();
    _loading = ValueNotifier(false);
    await getTotalPrice();
    update();
  }

  deleteCartProduct(int index) async {
    dbHelper.deleteProduct(_cartProducts[index]);
    getAllProducts();
  }

  adminDeleteCartProduct({@required String proId}) async {
    for (int index = 0; index < _cartProducts.length; index++) {
      if (_cartProducts[index].productId == proId) {
        dbHelper.deleteProduct(_cartProducts[index]);
      }
    }
    //TODO add favorite code
    getAllProducts();
    update();
  }

  getTotalPrice() {
    if (_cartProducts.length == 0) {
      _totalPrice = 0;
    } else {
      _totalPrice = 0;
      for (int i = 0; i < _cartProducts.length; i++) {
        _totalPrice += (double.parse(_cartProducts[i].price) *
            (_cartProducts[i].quantity));
      }
    }
    update();
  }

  increaseQuantity(int index) async {
    _cartProducts[index].quantity++;
    _totalPrice += (double.parse(_cartProducts[index].price));
    await dbHelper.updateProduct(_cartProducts[index]);
    update();
  }

  decreaseQuantity(int index) async {
    _cartProducts[index].quantity--;
    _totalPrice -= (double.parse(_cartProducts[index].price));
    await dbHelper.updateProduct(_cartProducts[index]);
    update();
  }

  clearDataBase() {
    dbHelper.clearDataBase();
    getAllProducts();
    update();
  }
}
