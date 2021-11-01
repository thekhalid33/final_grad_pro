import 'package:flutter/material.dart';

class RegisterRequest {
  String id;
  String email;
  String password;
  String city;
  String neighborhood;
  String fName;
  String lName;
  String imageUrl;
  RegisterRequest({
    @required this.id,
    @required this.email,
    @required this.password,
    @required this.city,
    @required this.neighborhood,
    @required this.fName,
    @required this.lName,
    @required this.imageUrl,
  });
  toMap() {
    return {
      'id': this.id,
      'email': this.email,
      'city': this.city,
      'neighborhood': this.neighborhood,
      'fName': this.fName,
      'lName': this.lName,
      'imageUrl': this.imageUrl
    };
  }
}
