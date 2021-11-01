import 'package:flutter/material.dart';

class UserModel {
  String id;
  String email;
  String neighborhood;
  String city;
  String fName;
  String lName;
  String imageUrl;
  UserModel({
    @required this.id,
    @required this.email,
    @required this.neighborhood,
    @required this.city,
    @required this.fName,
    @required this.lName,
    @required this.imageUrl,
  });

  UserModel.fromMap(Map map) {
    this.id = map['id'];
    this.email = map['email'];
    this.neighborhood = map['neighborhood'];
    this.city = map['city'];
    this.fName = map['fName'];
    this.lName = map['lName'];
    this.imageUrl = map['imageUrl'];
  }
  toMap() {
    return {
      'neighborhood': this.neighborhood,
      'city': this.city,
      'fName': this.fName,
      'lName': this.lName,
      'imageUrl': this.imageUrl
    };
  }
}
