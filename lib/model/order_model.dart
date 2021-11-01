import 'package:admin_grad_pro/model/cart_product_model.dart';
import 'package:flutter/cupertino.dart';

class OrderModel {
  String orderId;
  String totalPrice;
  String dateTime;
  Address address = Address(
    street: 'street',
    buildingNumber: 'buildingNumber',
    city: 'city',
    neighborhood: 'neighborhood',
  );
  Map<dynamic, dynamic> mapAddress = {};
  List<CartProductModel> products = [];
  List<Map> mapProducts = [];

  OrderModel({
    @required this.orderId,
    @required this.dateTime,
    this.address,
    this.mapAddress,
    this.products,
    this.mapProducts,
    @required this.totalPrice,
  });

  factory OrderModel.fromJson(Map<String, dynamic> map) {
    List<CartProductModel> list = [];
    for (int i = 0; i < map['mapProducts'].length; i++) {
      list.add(CartProductModel.fromJson(map['mapProducts'][i]));
    }

    return OrderModel(
      orderId: map['orderId'],
      dateTime: map['dateTime'],
      totalPrice: map['totalPrice'],
      address: Address.fromJson(map['mapAddress']),
      products: list,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'orderId': orderId,
      'dateTime': dateTime,
      'mapAddress': mapAddress,
      'mapProducts': mapProducts,
      'totalPrice': totalPrice,
    };
    return map;
  }
}

class Address {
  String street;
  String buildingNumber;
  String city;
  String neighborhood;

  Address({
    @required this.street,
    @required this.buildingNumber,
    @required this.city,
    @required this.neighborhood,
  });

  factory Address.fromJson(Map<String, dynamic> map) {
    return Address(
      street: map['street'],
      buildingNumber: map['buildingNumber'],
      city: map['city'],
      neighborhood: map['neighborhood'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    Map map = {
      'street': street,
      'buildingNumber': buildingNumber,
      'city': city,
      'neighborhood': neighborhood,
    };
    return map;
  }
}
