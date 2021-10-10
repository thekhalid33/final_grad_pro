import 'package:admin_grad_pro/lviewmodels/zoom_controller.dart';
import 'package:flutter/material.dart';

import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import 'menu_screen.dart';

class FlutterZoomDrawer extends StatefulWidget {
  @override
  _FlutterZoomDrawerState createState() => _FlutterZoomDrawerState();
}

class _FlutterZoomDrawerState extends State<FlutterZoomDrawer> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ZoomController>(
      init: Get.find<ZoomController>(),
      builder: (controller) => Scaffold(
        body: ZoomDrawer(
          controller: Get.find<ZoomController>().drawerController,
          style: DrawerStyle.Style1,
          menuScreen: MenuScreen(),
          mainScreen: controller.currentScreen,
          borderRadius: 24.0,
          showShadow: true,
          angle: -10.0,
          backgroundColor: Colors.grey.shade300,
          slideWidth: MediaQuery.of(context).size.width * 0.6,
          openCurve: Curves.fastOutSlowIn,
          closeCurve: Curves.fastOutSlowIn,
        ),
      ),
    );
  }
}
