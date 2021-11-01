import 'dart:ui';

import 'package:admin_grad_pro/lviewmodels/auth_view_model.dart';
import 'package:admin_grad_pro/view/customer/account/account_sub_screens/edit_profile_screen.dart';
import 'package:admin_grad_pro/view/widgets/custom_const_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthViewModel authViewModel = Get.find<AuthViewModel>();
  @override
  void initState() {
    super.initState();
    Get.find<AuthViewModel>().getUserFromFireStore();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text('Profile Page'),
          actions: [
            IconButton(
                onPressed: () {
                  Get.find<AuthViewModel>().fillControllers();
                  Get.to(EditProfileScreen());
                },
                icon: Icon(Icons.edit)),
            IconButton(
                onPressed: () {
                  authViewModel.logout();
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: GetBuilder<AuthViewModel>(
          init: authViewModel,
          builder: (controller) {
            return controller.user == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(controller.user.imageUrl),
                      ),
                      CustomConstItemWidget('Email', controller.user.email),
                      CustomConstItemWidget(
                          'first Name', controller.user.fName),
                      CustomConstItemWidget('last Name', controller.user.lName),
                      CustomConstItemWidget('city Name', controller.user.city),
                      CustomConstItemWidget(
                          'neighborhood Name', controller.user.neighborhood),
                    ],
                  );
          },
        ));
  }
}
