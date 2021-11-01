import 'package:admin_grad_pro/helpers/admin_firestore_helper.dart';
import 'package:admin_grad_pro/model/order_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AdminOrderViewModel extends GetxController {
  AdminOrderViewModel() {
    getAllNewOrders();
    getAllDoneOrders();
  }
  ValueNotifier<bool> _loading = ValueNotifier<bool>(false);
  get loading => _loading;

  List<OrderModel> _newOrders = [];
  get newOrders => _newOrders;

  List<OrderModel> _doneOrders = [];
  get doneOrders => _doneOrders;

  getAllNewOrders() async {

    EasyLoading.show(status: 'loading...');

    _loading = ValueNotifier<bool>(true);
    _newOrders = [];
    await AdminFireStoreHelper.adminFireStoreHelper
        .getAllOrdersFromFireStore('NewOrders')
        .then((value) {
      if (value.docs.isNotEmpty)
        for (int i = 0; i < value.docs.length; i++) {
          _newOrders.add(OrderModel.fromJson(value.docs[i].data()));
        }
    });
    EasyLoading.dismiss();

    _loading = ValueNotifier<bool>(false);
    update();
  }

  getAllDoneOrders() async {
    EasyLoading.show(status: 'loading...');


    _loading = ValueNotifier<bool>(true);
    _doneOrders = [];
    await AdminFireStoreHelper.adminFireStoreHelper
        .getAllOrdersFromFireStore('DoneOrders')
        .then((value) {
      if (value.docs.isNotEmpty)
        for (int i = 0; i < value.docs.length; i++) {
          _doneOrders.add(OrderModel.fromJson(value.docs[i].data()));
        }
    });
    EasyLoading.dismiss();

    _loading = ValueNotifier<bool>(false);
    update();
  }

  orderIsDone(OrderModel orderModel) async {
    _loading = ValueNotifier<bool>(true);
    List<Map> list = [];
    for (int i = 0; i < orderModel.products.length; i++) {
      list.add(orderModel.products[i].toJson());
    }

    await AdminFireStoreHelper.adminFireStoreHelper
        .addOrderToDoneOrdersFireStore(
      OrderModel(
        orderId: orderModel.orderId,
        dateTime: orderModel.dateTime,
        totalPrice: orderModel.totalPrice.toString(),
        mapAddress: orderModel.address.toJson(),
        mapProducts: list,
      ),
    );
    await AdminFireStoreHelper.adminFireStoreHelper
        .deleteOrder(orderModel.orderId);
    _doneOrders = [];
    _newOrders = [];
    getAllDoneOrders();
    getAllNewOrders();
    _loading = ValueNotifier<bool>(false);
    update();
  }

  deleteOrder(OrderModel orderModel) async {
    AdminFireStoreHelper.adminFireStoreHelper.deleteProduct(orderModel.orderId);
  }
}
