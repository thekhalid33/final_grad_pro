import 'package:flutter/foundation.dart';

class FavoriteProductModel {
  String productId;
  String name;
  String image;
  String price;
  String brand;
  int quantity;

  FavoriteProductModel({
    @required this.productId,
    @required this.name,
    @required this.image,
    @required this.price,
    @required this.brand,
    @required this.quantity,
  });

  factory FavoriteProductModel.fromJson(Map<String, dynamic> map) {
    FavoriteProductModel productModel = FavoriteProductModel(
      productId: map['productId'],
      name: map['name'],
      image: map['image'],
      price: map['price'],
      brand: map['brand'],
      quantity: map['quantity'],
    );
    return productModel;
  }

  toJson() {
    Map<String, dynamic> map = {
      'productId': productId,
      'name': name,
      'image': image,
      'price': price,
      'brand': brand,
      'quantity': quantity,
    };
    return map;
  }
}
