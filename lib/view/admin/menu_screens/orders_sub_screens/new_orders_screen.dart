import 'package:admin_grad_pro/lviewmodels/auth_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/checkOut_view_model.dart';

import '../../../../utils/constance.dart';
import 'package:admin_grad_pro/lviewmodels/admin_order_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/zoom_controller.dart';
import 'package:admin_grad_pro/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminOrderViewModel>(
      init: Get.find<AdminOrderViewModel>(),
      builder: (controller) => Scaffold(
          body: controller.newOrders.length == 0
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: 'No Orders Found',
                          fontSize: 30,
                        ),
                      ],
                    ),
                  ],
                )
              : controller.loading.value
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        ),
                      ],
                    )
                  : ListView.separated(
                      itemBuilder: (ctx, orderIndex) {
                        return Container(
                          height: 420,
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              ListTile(
                                trailing: IconButton(
                                  onPressed: () {
                                    controller.orderIsDone(
                                        controller.newOrders[orderIndex]);
                                  },
                                  icon: Icon(
                                    Icons.check,
                                    size: 30,
                                    color: Colors.red,
                                  ),
                                ),
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
                                            '\$${controller.newOrders[orderIndex].totalPrice}',
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
                                            '${controller.newOrders[orderIndex].address.street + ', ' + controller.newOrders[orderIndex].address.buildingNumber + ', ' + controller.newOrders[orderIndex].address.city + ', ' + controller.newOrders[orderIndex].address.neighborhood} ',
                                        style: TextStyle(
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
                                  itemCount: controller
                                      .newOrders[orderIndex].products.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: 150,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: 150,
                                            height: 180,
                                            child: Image.network(
                                              controller.newOrders[orderIndex]
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
                                              text: controller
                                                  .newOrders[orderIndex]
                                                  .products[index]
                                                  .name,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          CustomText(
                                            text: '\$' +
                                                controller.newOrders[orderIndex]
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
                            thickness: 3,
                            color: primaryColor,
                            height: 30,
                          ),
                      itemCount: controller.newOrders.length)),
    );
  }
}
