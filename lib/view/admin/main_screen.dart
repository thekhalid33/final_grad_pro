import 'package:admin_grad_pro/lviewmodels/zoom_controller.dart';
import 'package:admin_grad_pro/view/customer/control_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  // final ZoomDrawerController zoomDrawerController;

  // MainScreen({
  //   // required this.zoomDrawerController,
  // });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
        leading: IconButton(
          onPressed: () {
            Get.find<ZoomController>().drawerController.toggle();
          },
          icon: Icon(Icons.menu),
        ),
      ),
      body: ControlView(),
    );
  }
}
