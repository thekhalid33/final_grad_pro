import 'package:admin_grad_pro/lviewmodels/auth_view_model.dart';
import 'package:admin_grad_pro/view/widgets/custom_button.dart';
import 'package:admin_grad_pro/view/widgets/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: GetBuilder<AuthViewModel>(
        init: Get.find<AuthViewModel>(),
        builder: (controller) {
          return Column(
            children: [
              CustomTextField('Email', controller.emailController),
              CustomButton(
                  function: controller.resetPassword, label: 'Reset Password'),
            ],
          );
        },
      ),
    );
  }
}
