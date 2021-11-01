import '../../../../utils/constance.dart';
import 'package:admin_grad_pro/lviewmodels/checkOut_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/order_view_model.dart';
import 'package:admin_grad_pro/utils/enums.dart';
import 'package:admin_grad_pro/view/customer/cart/checkOut/widgets/add_address_widget.dart';
import 'package:admin_grad_pro/view/customer/cart/checkOut/widgets/delevery_time_widget.dart';
import 'package:admin_grad_pro/view/customer/cart/checkOut/widgets/summary_widget.dart';
import 'package:admin_grad_pro/view/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:status_change/status_change.dart';

class CheckOutScreen extends StatelessWidget {
  OrderViewModel _orderViewModel = Get.find<OrderViewModel>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckOutViewModel>(
      init: Get.find<CheckOutViewModel>(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            "CheckOut",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              height: 100,
              child: StatusChange.tileBuilder(
                theme: StatusChangeThemeData(
                  direction: Axis.horizontal,
                  connectorTheme:
                      ConnectorThemeData(space: 1.0, thickness: 1.0),
                ),
                builder: StatusChangeTileBuilder.connected(
                  itemWidth: (_) =>
                      MediaQuery.of(context).size.width / _processes.length,
                  nameWidgetBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        _processes[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: controller.getColor(index),
                        ),
                      ),
                    );
                  },
                  indicatorWidgetBuilder: (_, index) {
                    if (index <= controller.index) {
                      return DotIndicator(
                        size: 35.0,
                        border: Border.all(color: Colors.green, width: 1),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return OutlinedDotIndicator(
                        size: 30,
                        borderWidth: 1.0,
                        color: todoColor,
                      );
                    }
                  },
                  lineWidgetBuilder: (index) {
                    if (index > 0) {
                      if (index == controller.index) {
                        final prevColor = controller.getColor(index - 1);
                        final color = controller.getColor(index);
                        var gradientColors;
                        gradientColors = [
                          prevColor,
                          Color.lerp(prevColor, color, 0.5)
                        ];
                        return DecoratedLineConnector(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: gradientColors,
                            ),
                          ),
                        );
                      } else {
                        return SolidLineConnector(
                          color: controller.getColor(index),
                        );
                      }
                    } else {
                      return null;
                    }
                  },
                  itemCount: _processes.length,
                ),
              ),
            ),
            controller.pages == Pages.DeliveryTime
                ? DeliveryTime()
                : controller.pages == Pages.AddAddress
                    ? AddAddress()
                    : Summary(),
            Row(
              children: [
                controller.index == 0
                    ? Expanded(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            width: 200,
                            height: 100,
                            child: CustomTextButton(
                              text: 'CANCEL',
                              color: Colors.white,
                              textColor: primaryColor,
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            width: 200,
                            height: 100,
                            child: CustomTextButton(
                              text: 'BACK',
                              color: Colors.white,
                              textColor: primaryColor,
                              onPressed: () {
                                controller.changeIndex(controller.index - 1);
                              },
                            ),
                          ),
                        ),
                      ),
                controller.index == 2
                    ? Expanded(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            width: 200,
                            height: 100,
                            child: CustomTextButton(
                              text: 'ORDER NOW',
                              onPressed: () async {
                                _orderViewModel.addOrder();
                                Future.delayed(Duration(seconds: 3)).then(
                                    (value) => controller
                                        .changeIndex(controller.index + 1));
                              },
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            width: 200,
                            height: 100,
                            child: CustomTextButton(
                              text: 'NEXT',
                              onPressed: () {
                                controller.changeIndex(controller.index + 1);
                              },
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final _processes = [
  'Information',
  'Address',
  'Summer',
];
