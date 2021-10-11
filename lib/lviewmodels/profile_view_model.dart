import 'package:admin_grad_pro/lviewmodels/auth_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/cart_view_model.dart';
import 'package:admin_grad_pro/model/user_model.dart';
import 'package:admin_grad_pro/splach_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileViewModel extends GetxController {
  final AuthViewModel _authViewModel = Get.find<AuthViewModel>();

  ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;

  UserModel _userModer;
  UserModel get userModel => _userModer;
  @override
  void onInit() {
    super.onInit();
    getCurrentUser();
  }

  signOut() async {
    _authViewModel.logout();
  }

  getCurrentUser() async {
    _loading.value = true;
    _loading.value = false;
    update();
  }
}
