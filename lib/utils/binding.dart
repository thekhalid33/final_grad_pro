import 'package:admin_grad_pro/lviewmodels/admin_customer_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/admin_order_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/admin_product_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/auth_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/cart_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/category_product_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/checkOut_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/controll_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/home_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/order_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/profile_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/search_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/zoom_controller.dart';
import 'package:get/get.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => CartViewModel());
    Get.lazyPut(() => CheckOutViewModel());
    Get.lazyPut(() => ControlViewModel());
    Get.lazyPut(() => HomeViewModel());
    Get.lazyPut(() => OrderViewModel());
    Get.lazyPut(() => ProfileViewModel());
    Get.lazyPut(() => SearchViewModel());
    Get.lazyPut(() => ZoomController());
    Get.lazyPut(() => AdminProductViewModel());
    Get.lazyPut(() => AdminOrderViewModel());
    Get.lazyPut(() => AdminCustomersViewModel());
  }
}
