import 'package:admin_grad_pro/lviewmodels/admin_product_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/category_product_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/home_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/zoom_controller.dart';
import 'package:admin_grad_pro/utils/constance.dart';
import 'package:admin_grad_pro/view/admin/menu_screens/category_sub_screens/edit_category_screen.dart';
import 'add_category_screen.dart';
import 'package:admin_grad_pro/view/widgets/custom_text.dart';
import 'package:admin_grad_pro/view/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      init: Get.find<HomeViewModel>(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Categories Management',
            style: TextStyle(fontSize: 17,color: Colors.white),

          ),
          leading: IconButton(
            onPressed: () {
              Get.find<ZoomController>().drawerController.toggle();
            },
            icon: Icon(Icons.menu, color: Colors.white,),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => AddCategoryScreen());
              },
              icon: Icon(Icons.add,color: Colors.white,),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              CustomText(
                text: 'Categories :',
                fontSize: 25,
              ),
              SizedBox(height: 30),
              Expanded(
                child: ListView.separated(
                  itemCount: controller.categoryModels.length,
                  itemBuilder: (ctx, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            SizedBox(width: 15),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade100,
                              ),
                              height: 60,
                              width: 60,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Image.network(
                                    controller.categoryModels[index].image),
                              ),
                            ),
                          ],
                        ),
                        CustomText(text: controller.categoryModels[index].name),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  controller.selectCategory(
                                      controller.categoryModels[index]);
                                  controller.fillControllers();
                                  Get.to(() => EditCategoryScreen());
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: primaryColor,
                                  size: 30,
                                )),
                            SizedBox(width: 10),
                            IconButton(
                                onPressed: () {
                                  controller.deleteCategory(
                                      id: controller.categoryModels[index].id);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 30,
                                )),
                            SizedBox(width: 10),
                          ],
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (ctx, index) => SizedBox(height: 30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
