import 'package:admin_grad_pro/lviewmodels/auth_view_model.dart';
import 'package:admin_grad_pro/view/widgets/custom_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthViewModel>(
      init: Get.find<AuthViewModel>(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text('Add Address',style: TextStyle(color: Colors.white),),
          leading: IconButton(
            onPressed: () {
              controller.resetAddressControllers();
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios, size: 30,color: Colors.white,),
          ),
          actions: [
            IconButton(
              onPressed: () {
                controller.addAddressToFirebase();
              },
              icon: Icon(
                Icons.check,
                size: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomItemWidget('City Name', controller.cityNameController),
            CustomItemWidget(
                'Neighborhood ', controller.addNeighborhoodController),
            controller.addedTextFields.length == 0
                ? Expanded(
                    child: Container(),
                  )
                : Expanded(
                    child: ListView.separated(
                      itemCount: controller.addedTextFields.length,
                      itemBuilder: (context, index) {
                        return controller.addedTextFields[index];
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 20),
                    ),
                  ),
            IconButton(
              onPressed: () {
                controller.deleteTextField();
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
                size: 30,
              ),
            ),
          ],
        ),
        floatingActionButton: Visibility(
          visible: controller.visibility,
          child: FloatingActionButton.extended(
              icon: Icon(Icons.add),
              label: Text('Add'),
              onPressed: () {
                controller.addTextField();
              }),
        ),
      ),
    );
  }
}
