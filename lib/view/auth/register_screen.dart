import 'package:admin_grad_pro/lviewmodels/auth_view_model.dart';
import 'package:admin_grad_pro/model/city_model.dart';
import 'package:admin_grad_pro/view/widgets/custom_button.dart';
import 'package:admin_grad_pro/view/widgets/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<AuthViewModel>(
      init: Get.find<AuthViewModel>(),
      builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  controller.selectFile();
                },
                child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.grey,
                  child: controller.file == null
                      ? Container()
                      : Image.file(controller.file, fit: BoxFit.cover),
                ),
              ),
              CustomTextField('FirstName', controller.firstNameController),
              CustomTextField('LastName', controller.lastNameController),
              CustomTextField('Email', controller.emailController),
              CustomTextField('Password', controller.passwordController),
              controller.cities == null
                  ? Container()
                  : Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15)),
                      child: DropdownButton<CityModel>(
                        isExpanded: true,
                        underline: Container(),
                        value: controller.selectedCity,
                        onChanged: (x) {
                          controller.selectCity(x);
                        },
                        items: controller.cities.map((e) {
                          return DropdownMenuItem<CityModel>(
                            child: Text(e.name),
                            value: e,
                          );
                        }).toList(),
                      ),
                    ),
              controller.cities == null
                  ? Container()
                  : Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15)),
                      child: DropdownButton<dynamic>(
                        isExpanded: true,
                        underline: Container(),
                        value: controller.selectedNeighborhood,
                        onChanged: (x) {
                          controller.selectNeighborhood(x);
                        },
                        items: controller.neighborhoods.map((e) {
                          return DropdownMenuItem<dynamic>(
                            child: Text(e),
                            value: e,
                          );
                        }).toList(),
                      ),
                    ),
              CustomButton(function: controller.register, label: 'Register'),
            ],
          ),
        );
      },
    );
  }
}
