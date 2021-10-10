import 'package:admin_grad_pro/helpers/database/favorite_database_helper.dart';
import 'package:admin_grad_pro/model/favorite_product_model.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class FavoritesViewModel extends GetxController {
  ValueNotifier<bool> get loading => _loading;

  ValueNotifier<bool> _loading = ValueNotifier(false);

  List<FavoriteProductModel> _favoritesProducts = [];

  List<FavoriteProductModel> get favoritesProducts => _favoritesProducts;

  var dbHelper = FavoriteDatabaseHelper.cartDatabaseHelper;

  FavoritesViewModel() {
    getAllFavoriteProducts();
  }

  addProductToFavorite(FavoriteProductModel favoriteProductModel) async {
    for (int i = 0; i < _favoritesProducts.length; i++) {
      if (_favoritesProducts[i].productId == favoriteProductModel.productId) {
        Get.defaultDialog(
          title: 'The Product Was Added To Favorites',
          titleStyle: TextStyle(fontSize: 25),
          middleText: 'The product was added To favorite successfully',
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
    await dbHelper.insert(favoriteProductModel);
    _favoritesProducts.add(favoriteProductModel);
    update();
  }

  getAllFavoriteProducts() async {
    _loading = ValueNotifier(true);
    _favoritesProducts = await dbHelper.getAllProducts();
    _loading = ValueNotifier(false);
    update();
  }

  deleteFavoriteProduct(int index) async {
    dbHelper.deleteProduct(_favoritesProducts[index]);
    getAllFavoriteProducts();
  }

  clearDataBase() {
    dbHelper.clearDataBase();
    getAllFavoriteProducts();
    update();
  }
}
