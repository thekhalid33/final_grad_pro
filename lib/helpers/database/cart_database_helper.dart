import '../../utils/constance.dart';
import 'package:admin_grad_pro/model/cart_product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartDatabaseHelper {
  CartDatabaseHelper._();
  static CartDatabaseHelper cartDatabaseHelper = CartDatabaseHelper._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDb();
    return _database;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'CartProduct.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE $tableCartProduct ($columnName TEXT NOT NULL, $columnImage TEXT NOT NULL, $columnPrice TEXT NOT NULL, $columnBrand TEXT NOT NULL, $columnQuantity INTEGER NOT NULL, $columnProductId TEXT NOT NULL)');
    });
  }

  insert(CartProductModel model) async {
    Database dbClient = await database;

    await dbClient
        .insert(
          tableCartProduct,
          model.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        )
        .then(
          (value) => {
            Get.defaultDialog(
              title: 'Adding to cart',
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

  Future<List<CartProductModel>> getAllProducts() async {
    Database dbClient = await database;
    List<Map> maps = await dbClient.query(tableCartProduct);
    List<CartProductModel> list = maps.isNotEmpty
        ? maps.map((product) => CartProductModel.fromJson(product)).toList()
        : [];
    return list;
  }

  updateProduct(CartProductModel model) async {
    Database dbClient = await database;
    return await dbClient.update(tableCartProduct, model.toJson(),
        where: '$columnProductId = ?', whereArgs: [model.productId]);
  }

  deleteProduct(CartProductModel model) async {
    Database dbClient = await database;
    await dbClient.delete(tableCartProduct,
        where: '$columnProductId = ?', whereArgs: [model.productId]);
  }

  clearDataBase() async {
    Database dbClient = await database;
    await dbClient.delete(tableCartProduct);
  }
}
