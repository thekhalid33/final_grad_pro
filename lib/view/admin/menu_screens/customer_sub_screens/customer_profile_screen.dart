import 'package:admin_grad_pro/lviewmodels/admin_customer_view_model.dart';
import 'package:admin_grad_pro/view/widgets/custom_const_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AdminCustomersViewModel _adminCustomersViewModel =
        Get.find<AdminCustomersViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(_adminCustomersViewModel.wantToDelete.fName + ' Profile'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios, size: 30),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 30,
          ),
          CircleAvatar(
            radius: 80,
            backgroundImage:
                NetworkImage(_adminCustomersViewModel.wantToDelete.imageUrl),
          ),
          CustomConstItemWidget(
              'Email', _adminCustomersViewModel.wantToDelete.email),
          CustomConstItemWidget(
              'first Name', _adminCustomersViewModel.wantToDelete.fName),
          CustomConstItemWidget(
              'last Name', _adminCustomersViewModel.wantToDelete.lName),
          CustomConstItemWidget(
              'city Name', _adminCustomersViewModel.wantToDelete.city),
          CustomConstItemWidget('neighborhood Name',
              _adminCustomersViewModel.wantToDelete.neighborhood),
        ],
      ),
    );
  }
}
