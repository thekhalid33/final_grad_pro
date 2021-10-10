import 'package:admin_grad_pro/lviewmodels/auth_view_model.dart';
import 'package:admin_grad_pro/view/auth/reset_password_screen.dart';
import 'package:admin_grad_pro/view/widgets/custom_button.dart';
import 'package:admin_grad_pro/view/widgets/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<AuthViewModel>(
      init: Get.find<AuthViewModel>(),
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField('Email', controller.emailController),
            CustomTextField('Password', controller.passwordController),
            CustomButton(function: controller.login, label: 'Login'),
            GestureDetector(
              onTap: () {
                Get.to(ResetPasswordScreen());
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Forget Password?',
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
