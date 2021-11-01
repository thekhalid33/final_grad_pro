import 'package:admin_grad_pro/utils/extenstion.dart';
import 'package:admin_grad_pro/utils/hex_color.dart';
import 'package:flutter/material.dart';

class ProductModel {
  String productId;
  String categoryId;
  String name;
  String image;
  String description;
  Color color;
  String colorString;
  String size;
  String price;
  String brand;

  ProductModel({
    @required this.productId,
    @required this.categoryId,
    @required this.name,
    @required this.image,
    @required this.description,
    this.color,
    this.colorString,
    @required this.size,
    @required this.price,
    @required this.brand,
  });

  factory ProductModel.fromJson(Map<String, dynamic> map) {
    ProductModel productModel = ProductModel(
      productId: map['productId'],
      categoryId: map['categoryId'],
      name: map['name'],
      image: map['image'],
      description: map['description'],
      color: HexColor.fromHex(map['colorString']),
      size: map['size'],
      price: map['price'],
      brand: map['brand'],
    );
    return productModel;
  }

  toJson() {
    Map<String, dynamic> map = {
      'productId': productId,
      'categoryId': categoryId,
      'name': name,
      'image': image,
      'description': description,
      'colorString': colorString,
      'size': size,
      'price': price,
      'brand': brand,
    };
    return map;
  }
}
