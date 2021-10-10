import 'package:admin_grad_pro/lviewmodels/admin_product_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/home_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/zoom_controller.dart';
import 'package:admin_grad_pro/model/category_model.dart';
import 'package:admin_grad_pro/view/widgets/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductScreen extends StatelessWidget {
  final HomeViewModel _homeViewModel = Get.find<HomeViewModel>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminProductViewModel>(
      init: Get.find<AdminProductViewModel>(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text('Add Product'),
          leading: IconButton(
            onPressed: () {
              Get.back();
              Get.find<AdminProductViewModel>().resetControllers();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 30,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                controller.addProductToFireStore(
                    categoryModel: _homeViewModel.selectedCategory);
              },
              icon: Icon(
                Icons.check,
                size: 30,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
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
              CustomTextField('name', controller.nameController),
              CustomTextField('description', controller.descriptionController),
              CustomTextField('color', controller.colorController),
              CustomTextField('size', controller.sizeController),
              CustomTextField('price', controller.priceController),
              CustomTextField('brand', controller.brandController),
              GetBuilder<HomeViewModel>(
                init: _homeViewModel,
                builder: (homeController) => homeController.categoryModels ==
                        null
                    ? Container()
                    : Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        child: homeController.selectedCategory == null
                            ? Container()
                            : DropdownButton<CategoryModel>(
                                isExpanded: true,
                                underline: Container(),
                                value: homeController.selectedCategory,
                                onChanged: (x) {
                                  homeController.selectCategory(x);
                                },
                                items: homeController.categoryModels.isEmpty
                                    ? null
                                    : homeController.categoryModels.map((e) {
                                        return DropdownMenuItem<CategoryModel>(
                                          child: Text(
                                            e.name,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          value: e,
                                        );
                                      }).toList(),
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
