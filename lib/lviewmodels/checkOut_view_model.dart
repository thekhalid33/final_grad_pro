import '../utils/constance.dart';
import 'package:admin_grad_pro/lviewmodels/auth_view_model.dart';
import 'package:admin_grad_pro/utils/enums.dart';
import 'package:admin_grad_pro/view/customer/control_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutViewModel extends GetxController {
  int _index = 0;
  int get index => _index;

  Pages get pages => _pages;
  Pages _pages = Pages.DeliveryTime;

  String street;
  String buildingNumber;

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  void changeIndex(int i) {
    if (i <= 0) {
      _pages = Pages.DeliveryTime;
      _index = i;
    }
    if (i == 1) {
      _pages = Pages.AddAddress;
      _index = i;
    } else if (i == 2) {
      formState.currentState.save();
      if (formState.currentState.validate()) {
        _pages = Pages.Summary;
        _index = i;
      }
    } else if (i == 3) {
      Get.find<AuthViewModel>().checkLogin();
      _pages = Pages.DeliveryTime;
      _index = 0;
    }
    update();
  }

  Color getColor(int index) {
    if (index == _index) {
      return inProgressColor;
    } else if (index < _index) {
      return Colors.green;
    } else {
      return todoColor;
    }
  }
}
