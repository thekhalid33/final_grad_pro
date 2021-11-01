import 'package:admin_grad_pro/lviewmodels/auth_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/cart_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/controll_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/order_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/profile_view_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ControlView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(OrderViewModel());
    Get.put(ProfileViewModel());
    return GetBuilder<ControlViewModel>(
      init: ControlViewModel(),
      builder: (controlViewModelController) => Scaffold(
        body: controlViewModelController.currentScreen,
        bottomNavigationBar: bottomNavigationBar(),
      ),
    );
  }
}

Widget bottomNavigationBar() {
  return GetBuilder<ControlViewModel>(
    init: Get.find<ControlViewModel>(),
    builder: (controller) => BottomNavigationBar(
      currentIndex: controller.navigatorValue,
      onTap: (index) {
        controller.changeSelectValue(index);
      },
      elevation: 0,
      selectedItemColor: Colors.black,
      backgroundColor: Colors.grey.shade50,
      items: [
        BottomNavigationBarItem(
          activeIcon: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Text('Explore'),
          ),
          label: '',
          icon: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Image.asset(
              'assets/images/Icon_Explore.png',
              fit: BoxFit.contain,
              width: 20,
            ),
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Text('Cart'),
          ),
          label: '',
          icon: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Image.asset(
              'assets/images/Icon_Cart.png',
              fit: BoxFit.contain,
              width: 20,
            ),
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Text('Account'),
          ),
          label: '',
          icon: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Image.asset(
              'assets/images/Icon_User.png',
              fit: BoxFit.contain,
              width: 20,
            ),
          ),
        ),
      ],
    ),
  );
}
