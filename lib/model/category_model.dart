import 'package:flutter/foundation.dart';

class CategoryModel {
  String id;
  String name;
  String image;

  CategoryModel({
    @required this.id,
    @required this.name,
    @required this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> map) {
    CategoryModel categoryModel = CategoryModel(
      id: map['id'],
      name: map['name'],
      image: map['image'],
    );
    return categoryModel;
  }

  toJson() {
    Map<String, dynamic> map = {
      'id': id,
      'name': name,
      'image': image,
    };
    return map;
  }
}
