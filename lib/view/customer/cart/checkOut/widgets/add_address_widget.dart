import 'package:admin_grad_pro/lviewmodels/auth_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/checkOut_view_model.dart';
import 'package:admin_grad_pro/model/city_model.dart';
import 'package:admin_grad_pro/view/widgets/custom_text.dart';
import 'package:admin_grad_pro/view/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckOutViewModel>(
      init: Get.find<CheckOutViewModel>(),
      builder: (controller) => Form(
        key: controller.formState,
        child: Expanded(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  CustomText(
                    text: 'Billing address is the same as delivery address',
                    fontSize: 20,
                    alignment: Alignment.center,
                  ),
                  SizedBox(height: 30),
                  CustomTextFormField(
                    label: 'Street',
                    hint: 'Alwehda Street',
                    onSave: (value) {
                      controller.street = value;
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'you must write your street';
                      }
                    },
                  ),
                  SizedBox(height: 30),
                  CustomTextFormField(
                    label: 'Building Number',
                    hint: '1/151',
                    onSave: (value) {
                      controller.buildingNumber = value;
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'you must write your street';
                      }
                    },
                  ),
                  SizedBox(height: 30),
                  GetBuilder<AuthViewModel>(
                    init: Get.find<AuthViewModel>(),
                    builder: (authController) => Column(
                      children: <Widget>[
                        authController.cities == null
                            ? Container()
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(15)),
                                child: DropdownButton<CityModel>(
                                  isExpanded: true,
                                  underline: Container(),
                                  value: authController.selectedCity,
                                  onChanged: (x) {
                                    authController.selectCity(x);
                                  },
                                  items: authController.cities.map((e) {
                                    return DropdownMenuItem<CityModel>(
                                      child: Text(e.name),
                                      value: e,
                                    );
                                  }).toList(),
                                ),
                              ),
                        authController.cities == null
                            ? Container()
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(15)),
                                child: DropdownButton<dynamic>(
                                  isExpanded: true,
                                  underline: Container(),
                                  value: authController.selectedNeighborhood,
                                  onChanged: (x) {
                                    authController.selectNeighborhood(x);
                                  },
                                  items: authController.neighborhoods.map((e) {
                                    return DropdownMenuItem<dynamic>(
                                      child: Text(e),
                                      value: e,
                                    );
                                  }).toList(),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
