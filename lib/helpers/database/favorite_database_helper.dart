import '../../utils/constance.dart';
import 'package:admin_grad_pro/model/cart_product_model.dart';
import 'package:admin_grad_pro/model/favorite_product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteDatabaseHelper {
  FavoriteDatabaseHelper._();
  static FavoriteDatabaseHelper cartDatabaseHelper = FavoriteDatabaseHelper._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDb();
    return _database;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'FavoriteProduct.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE $tableFavoriteProduct ($fColumnName TEXT NOT NULL, $fColumnImage TEXT NOT NULL, $fColumnPrice TEXT NOT NULL, $fColumnBrand TEXT NOT NULL, $fColumnQuantity INTEGER NOT NULL, $fColumnProductId TEXT NOT NULL)');
    });
  }

  insert(FavoriteProductModel model) async {
    Database dbClient = await database;

    await dbClient
        .insert(
          tableFavoriteProduct,
          model.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        )
        .then(
          (value) => {
            Get.defaultDialog(
              title: 'Adding to Favorite',
              titleStyle: TextStyle(fontSize: 25),
              middleText: 'The product was added successfully',
              middleTextStyle: TextStyle(fontSize: 20),
              radius: 30,
              textConfirm: 'OK',
              onConfirm: () {
                Get.back();
              },
            ),
          },
        );
  }

  Future<List<FavoriteProductModel>> getAllProducts() async {
    Database dbClient = await database;
    List<Map> maps = await dbClient.query(tableFavoriteProduct);
    List<FavoriteProductModel> list = maps.isNotEmpty
        ? maps.map((product) => FavoriteProductModel.fromJson(product)).toList()
        : [];
    return list;
  }

  // updateProduct(FavoriteProductModel model) async {
  //   Database dbClient = await database;
  //   return await dbClient.update(tableFavoriteProduct, model.toJson(),
  //       where: '$fColumnProductId = ?', whereArgs: [model.productId]);
  // }

  deleteProduct(FavoriteProductModel model) async {
    Database dbClient = await database;
    await dbClient.delete(tableFavoriteProduct,
        where: '$fColumnProductId = ?', whereArgs: [model.productId]);
  }

  clearDataBase() async {
    Database dbClient = await database;
    await dbClient.delete(tableCartProduct);
  }
}
