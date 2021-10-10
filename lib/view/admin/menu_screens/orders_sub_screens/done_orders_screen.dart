import 'package:admin_grad_pro/lviewmodels/auth_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/checkOut_view_model.dart';

import '../../../../utils/constance.dart';
import 'package:admin_grad_pro/lviewmodels/admin_order_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/zoom_controller.dart';
import 'package:admin_grad_pro/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoneOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthViewModel _authViewModel = Get.find<AuthViewModel>();
    final CheckOutViewModel _checkOutViewModel = Get.find<CheckOutViewModel>();

    return GetBuilder<AdminOrderViewModel>(
      init: Get.find<AdminOrderViewModel>(),
      builder: (controller) => Scaffold(
          body: ListView.separated(
              itemBuilder: (ctx, orderIndex) {
                return Container(
                  height: 420,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ListTile(
                        title: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: 'Total Price: '),
                              TextSpan(
                                text:
                                    '\$${controller.doneOrders[orderIndex].totalPrice}',
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                        subtitle: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: 'Address: '),
                              TextSpan(
                                text:
                                    '${_checkOutViewModel.street + ', ' + _checkOutViewModel.buildingNumber + ', ' + _authViewModel.selectedCity.name + ', ' + _authViewModel.selectedNeighborhood} ',
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 250,
                        child: ListView.separated(
                          itemCount:
                              controller.doneOrders[orderIndex].products.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 150,
                                    height: 180,
                                    child: Image.network(
                                      controller.doneOrders[orderIndex]
                                          .products[index].image,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  RichText(
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      text: controller.doneOrders[orderIndex]
                                          .products[index].name,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  CustomText(
                                    text: '\$' +
                                        controller.doneOrders[orderIndex]
                                            .products[index].price,
                                    color: primaryColor,
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 20),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (ctx, index) => Divider(
                    thickness: 2,
                    color: Colors.white60,
                    height: 30,
                  ),
              itemCount: controller.doneOrders.length)),
    );
  }
}
