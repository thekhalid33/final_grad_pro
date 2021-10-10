import 'package:admin_grad_pro/lviewmodels/admin_customer_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/admin_order_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/admin_product_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/auth_view_model.dart';
import 'package:admin_grad_pro/view/admin/main_screen.dart';
import 'package:admin_grad_pro/view/admin/menu_screens/address_sub_screens/address_management_screen.dart';
import 'package:admin_grad_pro/view/admin/menu_screens/orders_sub_screens/order_main_screen.dart';
import 'package:admin_grad_pro/view/admin/menu_screens/products_sub_screens/add_product_screen.dart';
import 'package:admin_grad_pro/view/admin/menu_screens/products_sub_screens/products_management_screen.dart';
import '../view/admin/menu_screens/category_sub_screens/categories_management.dart';
import '../view/admin/menu_screens/customer_sub_screens/customers_management.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class ZoomController extends GetxController {
  ZoomController() {
    Get.put(AdminProductViewModel());
    Get.put(AdminOrderViewModel());
    Get.put(AdminCustomersViewModel());
  }
  ZoomDrawerController drawerController = ZoomDrawerController();

  Widget _currentScreen = MainScreen();

  get currentScreen => _currentScreen;

  changeScreen(int number) {
    switch (number) {
      case 0:
        _currentScreen = MainScreen();
        drawerController.close();
        break;
      case 1:
        _currentScreen = ProductsManagementScreen();
        drawerController.close();
        Get.find<AdminProductViewModel>().getAllProducts();
        break;
      case 2:
        _currentScreen = OrderMainScreen();
        drawerController.close();
        Get.find<AdminOrderViewModel>().getAllNewOrders();
        break;
      case 3:
        _currentScreen = AddressManagementScreen();
        drawerController.close();
        Get.find<AuthViewModel>().getCitiesFromFireStore();
        break;
      case 4:
        _currentScreen = CategoriesManagement();
        drawerController.close();
        break;
      case 5:
        _currentScreen = CustomersManagement();
        drawerController.close();
        Get.find<AdminCustomersViewModel>().getAllUsersFromFireStore();
        break;
      case 6:
        Get.find<AuthViewModel>().logout();
        break;
    }
    update();
  }
}
