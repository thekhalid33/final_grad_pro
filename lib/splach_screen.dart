import 'package:admin_grad_pro/lviewmodels/auth_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/cart_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/checkOut_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/controll_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/home_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/order_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/zoom_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplachScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(AuthViewModel());
    Get.put(ZoomController());
    Get.put(HomeViewModel());
    Get.put(ControlViewModel());
    Get.put(CheckOutViewModel());
    Future.delayed(Duration(seconds: 2))
        .then((value) => Get.find<AuthViewModel>().checkLogin());
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Text('Splach Screen'),
      ),
    );
  }
}
