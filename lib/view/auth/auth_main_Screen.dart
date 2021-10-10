import 'package:admin_grad_pro/lviewmodels/auth_view_model.dart';
import 'package:admin_grad_pro/view/auth/login_screen.dart';
import 'package:admin_grad_pro/view/auth/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMainScreen extends StatefulWidget {
  @override
  _AuthMainScreenState createState() => _AuthMainScreenState();
}

class _AuthMainScreenState extends State<AuthMainScreen>
    with SingleTickerProviderStateMixin {
  @override
  initState() {
    super.initState();
    Get.find<AuthViewModel>().tabController =
        TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Main Page'),
          bottom: TabBar(
              controller: Get.find<AuthViewModel>().tabController,
              tabs: [
                Tab(
                  text: 'Register',
                ),
                Tab(
                  text: 'Login',
                )
              ]),
        ),
        body: TabBarView(
          controller: Get.find<AuthViewModel>().tabController,
          children: [RegisterScreen(), LoginScreen()],
        ));
  }
}
