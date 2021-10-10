import 'package:admin_grad_pro/lviewmodels/admin_product_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/home_view_model.dart';
import 'package:admin_grad_pro/model/category_model.dart';
import 'package:admin_grad_pro/view/widgets/custom_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductsScreen extends StatelessWidget {
  HomeViewModel _homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminProductViewModel>(
      init: Get.find<AdminProductViewModel>(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text('Editing Product'),
          actions: [
            IconButton(
              onPressed: () {
                controller.updateProduct(
                    categoryModel: _homeViewModel.selectedCategory);
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
                  controller.captureUpdateProductImage();
                },
                child: controller.updatedFile == null
                    ? CircleAvatar(
                        radius: 100,
                        backgroundImage:
                            NetworkImage(controller.productToEdit.image),
                      )
                    : CircleAvatar(
                        radius: 100,
                        backgroundImage: FileImage(controller.updatedFile),
                      ),
              ),
              CustomItemWidget('Product Name', controller.nameController),
              CustomItemWidget('Description', controller.descriptionController),
              CustomItemWidget('Color', controller.colorController),
              CustomItemWidget('Available Size', controller.sizeController),
              CustomItemWidget('Price', controller.priceController),
              CustomItemWidget('Brand', controller.brandController),
              GetBuilder<HomeViewModel>(
                init: Get.find<HomeViewModel>(),
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
                        child: DropdownButton<CategoryModel>(
                          isExpanded: true,
                          underline: Container(),
                          value: homeController.selectedCategory,
                          onChanged: (x) {
                            homeController.selectCategory(x);
                          },
                          items: homeController.categoryModels.map((e) {
                            return DropdownMenuItem<CategoryModel>(
                              child: Text(
                                e.name,
                                style: TextStyle(color: Colors.black),
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
