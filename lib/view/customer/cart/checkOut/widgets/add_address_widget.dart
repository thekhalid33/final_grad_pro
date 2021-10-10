import 'package:admin_grad_pro/lviewmodels/auth_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/checkOut_view_model.dart';
import 'package:admin_grad_pro/model/city_model.dart';
import 'package:admin_grad_pro/view/widgets/custom_text.dart';
import 'package:admin_grad_pro/view/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddress extends StatelessWidget {
  final AuthViewModel _authViewModel = Get.find<AuthViewModel>();
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
                  _authViewModel.cities == null
                      ? Container()
                      : Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(15)),
                          child: DropdownButton<CityModel>(
                            isExpanded: true,
                            underline: Container(),
                            value: _authViewModel.selectedCity,
                            onChanged: (x) {
                              _authViewModel.selectCity(x);
                            },
                            items: _authViewModel.cities.map((e) {
                              return DropdownMenuItem<CityModel>(
                                child: Text(e.name),
                                value: e,
                              );
                            }).toList(),
                          ),
                        ),
                  _authViewModel.cities == null
                      ? Container()
                      : Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(15)),
                          child: DropdownButton<dynamic>(
                            isExpanded: true,
                            underline: Container(),
                            value: _authViewModel.selectedNeighborhood,
                            onChanged: (x) {
                              _authViewModel.selectNeighborhood(x);
                            },
                            items: _authViewModel.neighborhoods.map((e) {
                              return DropdownMenuItem<dynamic>(
                                child: Text(e),
                                value: e,
                              );
                            }).toList(),
                          ),
                        ),
                  // CustomTextFormField(
                  //   label: 'City',
                  //   hint: 'Victoria Island',
                  //   onSave: (value) {
                  //     controller.city = value;
                  //   },
                  //   validator: (String value) {
                  //     if (value.isEmpty) {
                  //       return 'you must write your city';
                  //     }
                  //   },
                  // ),
                  // SizedBox(height: 30),
                  // Container(
                  //   width: Get.width,
                  //   child: Row(
                  //     children: <Widget>[
                  //       Expanded(
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(right: 20),
                  //           child: CustomTextFormField(
                  //             label: 'State',
                  //             hint: 'Lagos State',
                  //             onSave: (value) {
                  //               controller.state = value;
                  //             },
                  //             validator: (String value) {
                  //               if (value.isEmpty) {
                  //                 return 'you must write your state';
                  //               }
                  //             },
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(left: 20),
                  //           child: CustomTextFormField(
                  //             label: 'Country',
                  //             hint: 'Nigeria',
                  //             onSave: (value) {
                  //               controller.country = value;
                  //             },
                  //             validator: (String value) {
                  //               if (value.isEmpty) {
                  //                 return 'you must write your country';
                  //               }
                  //             },
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
