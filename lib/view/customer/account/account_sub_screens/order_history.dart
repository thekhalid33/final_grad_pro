import '../../../../utils/constance.dart';
import 'package:admin_grad_pro/lviewmodels/order_view_model.dart';
import 'package:admin_grad_pro/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderViewModel>(
      init: Get.find<OrderViewModel>(),
      builder: (controller) => SafeArea(
        child: Scaffold(
          // backgroundColor: Colors.blueAccent,
          appBar: AppBar(
            title: Text('Orders History'),
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 30,
              ),
            ),
          ),
          body: SafeArea(
            child: ListView.separated(
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
                                      '\$${controller.orders[orderIndex].totalPrice}',
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
                                      '${controller.orders[orderIndex].address.street + ', ' + controller.orders[orderIndex].address.buildingNumber + ', ' + controller.orders[orderIndex].address.city + ', ' + controller.orders[orderIndex].address.neighborhood}',
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
                                controller.orders[orderIndex].products.length,
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
                                        controller.orders[orderIndex]
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
                                        text: controller.orders[orderIndex]
                                            .products[index].name,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    CustomText(
                                      text: '\$' +
                                          controller.orders[orderIndex]
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
                itemCount: controller.orders.length),
          ),
        ),
      ),
    );
  }
}
