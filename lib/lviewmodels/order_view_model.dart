import 'package:admin_grad_pro/helpers/firestore_order_helper.dart';
import 'package:admin_grad_pro/lviewmodels/auth_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/cart_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/checkOut_view_model.dart';
import 'package:admin_grad_pro/model/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class OrderViewModel extends GetxController {
  CartViewModel _cartViewModel = Get.find<CartViewModel>();
  CheckOutViewModel _checkOutViewModel = Get.find<CheckOutViewModel>();

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  List<OrderModel> _orders = [];

  get orders => _orders;

  OrderViewModel() {
    getAllOrders();
  }

  final AuthViewModel _authViewModel = Get.find<AuthViewModel>();

  Future<void> addOrder() async {
    Address address = Address(
      street: _checkOutViewModel.street,
      buildingNumber: _checkOutViewModel.buildingNumber,
      city: _authViewModel.selectedCity.name,
      neighborhood: _authViewModel.selectedNeighborhood,
    );
    List<Map> list = [];
    for (int i = 0; i < _cartViewModel.cartProducts.length; i++) {
      list.add(_cartViewModel.cartProducts[i].toJson());
    }

    await FireStoreOrderHelper.fireStoreOrderHelper
        .addOrderToFireStore(OrderModel(
      orderId: DateTime.now().toString(),
      dateTime: DateTime.now().toString(),
      mapAddress: address.toJson(),
      mapProducts: list,
      totalPrice: _cartViewModel.totalPrice.toString(),
    ));

    getAllOrders();
  }

  getAllOrders() async {
    await FireStoreOrderHelper.fireStoreOrderHelper
        .getUserOrdersFromFireStore(_firebaseAuth.currentUser.uid)
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        _orders.add(OrderModel.fromJson(value.docs[i].data()));
      }
    });
    update();
  }
}
