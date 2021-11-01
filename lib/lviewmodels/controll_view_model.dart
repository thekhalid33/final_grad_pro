import 'package:admin_grad_pro/view/customer/account/account_screen.dart';
import '../view/customer/cart/cart_screen.dart';
import '../view/customer/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControlViewModel extends GetxController {
  int _navigatorValue = 0;

  int get navigatorValue => _navigatorValue;

  Widget _currentScreen = HomeScreen();

  Widget get currentScreen => _currentScreen;

  void changeSelectValue(int selectedValue) {
    _navigatorValue = selectedValue;

    switch (selectedValue) {
      case 0:
        _currentScreen = HomeScreen();
        break;
      case 1:
        _currentScreen = CartScreen();
        break;
      case 2:
        _currentScreen = AccountScreen();
        break;
    }
    update();
  }
}
