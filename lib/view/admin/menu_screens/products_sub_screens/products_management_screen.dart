import 'package:admin_grad_pro/view/admin/menu_screens/products_sub_screens/add_product_screen.dart';
import 'package:admin_grad_pro/view/admin/menu_screens/products_sub_screens/edit_products_screen.dart';

import '../../../../utils/constance.dart';
import 'package:admin_grad_pro/lviewmodels/admin_product_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/zoom_controller.dart';
import 'package:admin_grad_pro/utils/enums.dart';
import 'package:admin_grad_pro/view/customer/details_screen.dart';
import 'package:admin_grad_pro/view/widgets/custom_text.dart';
import 'package:admin_grad_pro/view/widgets/slidable_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products Management',
          style: TextStyle(fontSize: 17,color:  Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.find<ZoomController>().drawerController.toggle();
            Get.find<AdminProductViewModel>().resetControllers();
          },
          icon: Icon(Icons.menu,color: Colors.white,),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => AddProductScreen());
            },
            icon: Icon(
              Icons.add,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: GetBuilder<AdminProductViewModel>(
        init: Get.find<AdminProductViewModel>(),
        builder: (controller) => Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 50, right: 20, left: 20),
                child: ListView.separated(
                  itemCount: controller.products.length ?? 0,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () =>
                              DetailsScreen(model: controller.products[index]),
                        );
                      },
                      child: SlidableWidget(
                        index: 3,
                        id: controller.products[index].productId,
                        child: buildCartProduct(
                          controller: controller,
                          index: index,
                        ),
                        onDismissed: (action) => dismissSlidableItem(
                          controller: controller,
                          index: index,
                          action: action,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void dismissSlidableItem({
  @required AdminProductViewModel controller,
  @required int index,
  @required SlidableAction action,
}) {
  switch (action) {
    case SlidableAction.AdminProductDelete:
      controller.deleteProduct(
          categoryId: controller.products[index].categoryId,
          productId: controller.products[index].productId);
      Get.snackbar('Deleting Product', 'Product was deleted successfully');
      break;
    case SlidableAction.edit:
      controller.fillControllers(controller.products[index]);
      controller.productToEdit = controller.products[index];
      Get.to(() => EditProductsScreen());
      break;
  }
}

Widget buildCartProduct(
    {@required AdminProductViewModel controller, @required int index}) {
  return Container(
    height: 140,
    child: Row(
      children: <Widget>[
        Container(
          width: 140,
          child: Image.network(
            controller.products[index].image,
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                width: Get.width * 0.4,
                child: RichText(
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: controller.products[index].name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              CustomText(
                text: controller.products[index].brand.trim(),
                color: Colors.black,
              ),
              SizedBox(height: 20),
              CustomText(
                text: '\$' + controller.products[index].price,
                color: primaryColor,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
