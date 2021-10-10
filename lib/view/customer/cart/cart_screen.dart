import '../../../utils/constance.dart';
import 'package:admin_grad_pro/lviewmodels/cart_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/favorites_view_model.dart';
import 'package:admin_grad_pro/model/favorite_product_model.dart';
import 'package:admin_grad_pro/utils/enums.dart';
import 'package:admin_grad_pro/view/customer/cart/checkOut/checkOut_screen.dart';
import 'package:admin_grad_pro/view/widgets/custom_text.dart';
import 'package:admin_grad_pro/view/widgets/custom_text_button.dart';
import 'package:admin_grad_pro/view/widgets/slidable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartViewModel>(
      init: Get.find<CartViewModel>(),
      builder: (controller) => Scaffold(
        body: controller.cartProducts.length == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    'assets/images/Empty_Cart.svg',
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(height: 20),
                  CustomText(
                    text: 'Cart is empty',
                    fontSize: 32,
                    alignment: Alignment.topCenter,
                  ),
                ],
              )
            : Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 50, right: 20, left: 20),
                      child: ListView.separated(
                        itemCount: controller.cartProducts.length ?? 0,
                        itemBuilder: (context, index) {
                          return SlidableWidget(
                            index: 1,
                            id: controller.cartProducts[index].productId,
                            child: buildCartProduct(
                              controller: controller,
                              index: index,
                            ),
                            onDismissed: (action) => dismissSlidableItem(
                              controller: controller,
                              index: index,
                              action: action,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 15),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            CustomText(
                              text: 'TOTAL',
                              color: Colors.grey,
                              fontSize: 22,
                            ),
                            SizedBox(height: 10),
                            GetBuilder<CartViewModel>(
                              init: Get.find<CartViewModel>(),
                              builder: (controller) => CustomText(
                                text: '\$' + controller.totalPrice.toString(),
                                color: primaryColor,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: CustomTextButton(
                            text: 'CHECKOUT',
                            onPressed: () {
                              print(DateTime.now().toString());
                              print(DateTime.now());
                              Get.to(() => CheckOutScreen());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

void dismissSlidableItem({
  @required CartViewModel controller,
  @required int index,
  @required SlidableAction action,
}) {
  switch (action) {
    case SlidableAction.delete:
      controller.deleteCartProduct(index);
      Get.snackbar('Deleting Product', 'Product was deleted successfully');
      break;
    case SlidableAction.favorite:
      Get.find<FavoritesViewModel>().addProductToFavorite(
        FavoriteProductModel(
          productId: controller.cartProducts[index].productId,
          name: controller.cartProducts[index].name,
          image: controller.cartProducts[index].image,
          price: controller.cartProducts[index].price,
          brand: controller.cartProducts[index].brand,
          quantity: 1,
        ),
      );
      break;
  }
}

Widget buildCartProduct(
    {@required CartViewModel controller, @required int index}) {
  return Container(
    height: 140,
    child: Row(
      children: <Widget>[
        Container(
          width: 140,
          child: Image.network(
            controller.cartProducts[index].image,
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
                    text: controller.cartProducts[index].name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              CustomText(
                text: '\$' + controller.cartProducts[index].price,
                color: primaryColor,
              ),
              SizedBox(height: 20),
              Container(
                width: 140,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        controller.increaseQuantity(index);
                      },
                      icon: Icon(Icons.add),
                      splashRadius: 10,
                    ),
                    CustomText(
                      text: controller.cartProducts[index].quantity.toString(),
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    controller.cartProducts[index].quantity == 1
                        ? IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.remove),
                            splashRadius: 10,
                            color: Colors.grey,
                          )
                        : IconButton(
                            onPressed: () {
                              controller.decreaseQuantity(index);
                            },
                            icon: Icon(Icons.remove),
                            splashRadius: 10,
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
