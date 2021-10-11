import '../../../../utils/constance.dart';
import 'package:admin_grad_pro/lviewmodels/category_product_view_model.dart';
import 'package:admin_grad_pro/model/category_model.dart';
import 'package:admin_grad_pro/view/widgets/custom_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  CategoryModel categoryModel;

  CategoryScreen({@required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryProductViewModel>(
      init: CategoryProductViewModel(categoryModel.id),
      builder: (controller) => Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              categoryModel.name,
              style: TextStyle(color: primaryColor),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          body: controller.productCategoryModels.isEmpty
              ? Center(
                  child: Text('This Category does not have products yet'),
                )
              : controller.loading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: EdgeInsets.only(top: 30, right: 18, left: 18),
                      child: Column(
                        children: [
                          Flexible(
                            child: controller.productCategoryModels.length == 0
                                ? Center(
                                    child: Text('no products'),
                                  )
                                : CustomGridView(
                                    productsList:
                                        controller.productCategoryModels,
                                  ),
                          )
                        ],
                      ),
                    )),
    );
  }
}
