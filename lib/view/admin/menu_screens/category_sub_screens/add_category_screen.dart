import 'package:admin_grad_pro/lviewmodels/home_view_model.dart';
import 'package:admin_grad_pro/view/widgets/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      init: Get.find<HomeViewModel>(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text('Add Category',style: TextStyle(color: Colors.white),),
          leading: IconButton(
            onPressed: () {
              controller.resetControllers();
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios, size: 30,color: Colors.white,),
          ),
          actions: [
            IconButton(
              onPressed: () {
                controller.addCategoryToFireStore();
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
          children: [
            SizedBox(height: 20,),
            GestureDetector(
              onTap: () {
                controller.selectFile();
              },
              child: Container(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey,
                ),
                height: 200,
                width: 200,

                child: controller.file == null
                    ? Container()
                    : Image.file(controller.file, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 30),
            CustomTextField('Category Name', controller.nameController),
          ],
        ),
      ),
    );
  }
}
