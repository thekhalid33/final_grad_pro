import 'package:admin_grad_pro/lviewmodels/home_view_model.dart';
import 'package:admin_grad_pro/view/widgets/custom_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditCategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      init: Get.find<HomeViewModel>(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text('Editing Product'),
          actions: [
            IconButton(
              onPressed: () {
                controller.editCategoryInFireStore();
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
                  controller.captureUpdateCategoryImage();
                },
                child: controller.updatedFile == null
                    ? CircleAvatar(
                        radius: 100,
                        backgroundImage:
                            NetworkImage(controller.selectedCategory.image),
                      )
                    : CircleAvatar(
                        radius: 100,
                        backgroundImage: FileImage(controller.updatedFile),
                      ),
              ),
              SizedBox(
                height: 30,
              ),
              CustomItemWidget('Category Name', controller.nameController),
            ],
          ),
        ),
      ),
    );
  }
}
