import 'package:admin_grad_pro/lviewmodels/auth_view_model.dart';
import 'package:admin_grad_pro/model/city_model.dart';
import 'package:admin_grad_pro/view/widgets/custom_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthViewModel>(
      init: Get.find<AuthViewModel>(),
      builder: (controller) => Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text('Editing Profile'),
          actions: [
            IconButton(
              onPressed: () {
                controller.updateProfile();
              },
              icon: Icon(Icons.done),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  controller.captureUpdateProfileImage();
                },
                child: controller.updatedFile == null
                    ? CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage(controller.user.imageUrl),
                      )
                    : CircleAvatar(
                        radius: 100,
                        backgroundImage: FileImage(controller.updatedFile),
                      ),
              ),
              CustomItemWidget('first Name', controller.firstNameController),
              CustomItemWidget('last Name', controller.lastNameController),
              // ItemWidget('city Name', controller.cityController),
              // ItemWidget(
              //     'neighborhood Name', controller.neighborhoodController),
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
            ],
          ),
        ),
      ),
    );
  }
}
