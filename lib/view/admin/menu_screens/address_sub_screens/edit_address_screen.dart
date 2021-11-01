import 'package:admin_grad_pro/lviewmodels/auth_view_model.dart';
import 'package:admin_grad_pro/model/city_model.dart';
import 'package:admin_grad_pro/view/widgets/custom_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthViewModel>(
      init: Get.find<AuthViewModel>(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text('Editing Address'),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              controller.resetAddressControllers();
              Get.back();
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                controller.editAddressInFireStore();
              },
              icon: Icon(
                Icons.done,
                size: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 30,
            ),
            CustomItemWidget('Category Name', controller.cityNameController),
            SizedBox(
              height: 30,
            ),
            CustomItemWidget(
                'Neighborhood', controller.addNeighborhoodController),
            SizedBox(
              height: 30,
            ),
            controller.wantToEditModel.neighborhoods.length == 0
                ? Expanded(
                    child: Container(),
                  )
                : Expanded(
                    child: ListView.separated(
                      itemCount: controller.addedTextFields.length,
                      itemBuilder: (context, index) {
                        return controller.addedTextFields[index];
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 30,
                      ),
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
