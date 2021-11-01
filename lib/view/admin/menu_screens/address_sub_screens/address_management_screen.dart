import 'package:admin_grad_pro/lviewmodels/auth_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/zoom_controller.dart';
import 'package:admin_grad_pro/utils/constance.dart';
import 'package:admin_grad_pro/view/admin/menu_screens/address_sub_screens/add_address_screen.dart';
import 'package:admin_grad_pro/view/admin/menu_screens/address_sub_screens/edit_address_screen.dart';
import 'package:admin_grad_pro/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthViewModel>(
      init: Get.find<AuthViewModel>(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Address Management',
            style: TextStyle(fontSize: 18,color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () {
              Get.find<ZoomController>().drawerController.toggle();
            },
            icon: Icon(
              Icons.menu,
              size: 30,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => AddAddressScreen());
              },
              icon: Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.separated(
            itemCount: controller.cities.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: controller.cities[index].name,
                        fontSize: 30,
                        color: Colors.black,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              controller.wantToEditModel =
                                  controller.cities[index];
                              controller.fillAddressControllers();
                              Get.to(() => EditAddressScreen());
                            },
                            icon: Icon(
                              Icons.edit,
                              color: primaryColor,
                              size: 30,
                            ),
                          ),
                          SizedBox(width: 20),
                          IconButton(
                            onPressed: () {
                              controller.deleteAddressFromFirebase(
                                  controller.cities[index].id);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 200,
                    padding: EdgeInsets.only(left: 30),
                    color: Colors.grey.shade200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                        itemCount:
                            controller.cities[index].neighborhoods.length,
                        itemBuilder: (context, neighborhoodsIndex) {
                          return Row(
                            children: [
                              CustomText(
                                text: neighborhoodsIndex.toString() + ' - ',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              CustomText(
                                text: controller.cities[index]
                                    .neighborhoods[neighborhoodsIndex],
                              )
                            ],
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 30),
                      ),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 30),
          ),
        ),
      ),
    );
  }
}
