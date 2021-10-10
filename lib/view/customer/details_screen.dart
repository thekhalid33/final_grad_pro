import 'package:admin_grad_pro/lviewmodels/cart_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/favorites_view_model.dart';
import 'package:admin_grad_pro/model/cart_product_model.dart';
import 'package:admin_grad_pro/model/favorite_product_model.dart';
import 'package:admin_grad_pro/view/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../utils/constance.dart';
import 'package:admin_grad_pro/model/product_model.dart';
import 'package:admin_grad_pro/view/widgets/custom_text.dart';

class DetailsScreen extends StatelessWidget {
  final ProductModel model;

  DetailsScreen({
    @required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.find<FavoritesViewModel>().addProductToFavorite(
                FavoriteProductModel(
                  productId: model.productId,
                  name: model.name,
                  image: model.image,
                  price: model.price,
                  brand: model.brand,
                  quantity: 1,
                ),
              );
            },
            icon: Icon(
              Icons.favorite,
              size: 30,
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[

          Container(
            width: MediaQuery.of(context).size.width,
            height: 270,
            child: Image.network(
              model.image,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 18, right: 18),
                child: Column(
                  children: <Widget>[
                    Text(
                      model.name,
                      style:
                      TextStyle(fontFamily: 'SourceSans', fontSize: 26),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              CustomText(
                                text: 'Size',
                              ),
                              CustomText(
                                text: model.size,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width * 0.43,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              CustomText(
                                text: 'Color',
                              ),
                              Container(
                                width: 22,
                                height: 22,
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: model.color,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    CustomText(
                      text: 'Details',
                      fontSize: 18,
                    ),
                    SizedBox(height: 20),
                    CustomText(
                      text: model.description,
                      fontSize: 15,
                      height: 1.7,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    CustomText(
                      text: 'PRICE',
                      color: Colors.grey,
                      fontSize: 22,
                    ),
                    SizedBox(height: 10),
                    CustomText(
                      text: '\$' + model.price,
                      color: primaryColor,
                      fontSize: 18,
                    ),
                  ],
                ),
                GetBuilder<CartViewModel>(
                  init: Get.find<CartViewModel>(),
                  builder: (controller) => Container(
                    child: CustomTextButton(
                      text: 'ADD to Cart',
                      onPressed: () {
                        controller.addProduct(CartProductModel(
                          productId: model.productId,
                          name: model.name,
                          image: model.image,
                          price: model.price,
                          brand: model.brand,
                          quantity: 1,
                        ));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
