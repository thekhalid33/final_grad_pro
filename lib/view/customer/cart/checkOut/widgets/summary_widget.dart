import 'package:admin_grad_pro/lviewmodels/auth_view_model.dart';

import '../../../../../utils/constance.dart';
import 'package:admin_grad_pro/lviewmodels/cart_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/checkOut_view_model.dart';
import 'package:admin_grad_pro/view/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Summary extends StatelessWidget {
  final AuthViewModel _authViewModel = Get.find<AuthViewModel>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<CartViewModel>(
        init: Get.find<CartViewModel>(),
        builder: (controller) => SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                height: 350,
                padding: EdgeInsets.all(20),
                child: ListView.separated(
                  itemCount: controller.cartProducts.length,
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
                              controller.cartProducts[index].image,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          SizedBox(height: 10),
                          RichText(
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: controller.cartProducts[index].name,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                          SizedBox(height: 10),
                          CustomText(
                            text: '\$' + controller.cartProducts[index].price,
                            color: primaryColor,
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: 'Shipping Address',
                  fontSize: 24,
                ),
              ),
              GetBuilder<CheckOutViewModel>(
                init: Get.find<CheckOutViewModel>(),
                builder: (checkOutController) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    text:
                        '${checkOutController.street + ', ' + checkOutController.buildingNumber + ', ' + _authViewModel.selectedCity.name + ', ' + _authViewModel.selectedNeighborhood} ',
                    color: Colors.grey,
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
