import '../../../utils/constance.dart';
import 'package:admin_grad_pro/lviewmodels/home_view_model.dart';
import 'package:admin_grad_pro/view/customer/home/home_sub_screens/favorites_screen.dart';
import 'package:admin_grad_pro/view/customer/home/home_sub_screens/search_screen.dart';
import 'home_sub_screens/category_screen.dart';
import 'package:admin_grad_pro/view/widgets/custom_grid_view.dart';
import 'package:admin_grad_pro/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      init: Get.find<HomeViewModel>(),
      builder: (controller) => controller.loading.value
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              body: Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              Get.to(() => SearchScreen());
                            },
                            icon: Icon(
                              Icons.search,
                              size: 30,
                              color: primaryColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Get.to(() => FavoritesScreen());
                            },
                            icon: Icon(
                              // Icons.grid_view,
                              Icons.favorite,
                              size: 30,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomText(
                      text: 'Categories',
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 100,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.categoryModels.length,
                        itemBuilder: (ctx, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                () => CategoryScreen(
                                  categoryModel:
                                      controller.categoryModels[index],
                                ),
                              );
                            },
                            child: Column(
                              children: <Widget>[
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
                                SizedBox(height: 10),
                                CustomText(
                                    text:
                                        controller.categoryModels[index].name),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (ctx, index) => SizedBox(width: 20),
                      ),
                    ),
                    SizedBox(height: 30),
                    Flexible(
                      flex: 2,
                      child: controller.productModels.length == 0
                          ? Center(
                              child: Text('no products'),
                            )
                          : CustomGridView(
                              productsList: controller.productModels,
                            ),
                    ),
                    //TODO: MOST LIKED
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: <Widget>[
                    //     CustomText(
                    //       text: 'Best Selling',
                    //       fontSize: 18,
                    //     ),
                    //     CustomText(
                    //       text: 'See all',
                    //       fontSize: 16,
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 10),
                    // Container(
                    //   height: 350,
                    //   child: ListView.separated(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: controller.productModels.length,
                    //     itemBuilder: (ctx, index) {
                    //       return GestureDetector(
                    //         onTap: () {
                    //           Get.to(
                    //             () => DetailsScreen(
                    //               model: controller.productModels[index],
                    //             ),
                    //           );
                    //         },
                    //         child: Container(
                    //           width: MediaQuery.of(context).size.width * 0.4,
                    //           child: Column(
                    //             children: <Widget>[
                    //               Container(
                    //                 decoration: BoxDecoration(
                    //                   shape: BoxShape.circle,
                    //                   color: Colors.grey.shade100,
                    //                 ),
                    //                 height: 220,
                    //                 width: MediaQuery.of(context).size.width *
                    //                     0.4,
                    //                 child: Image.network(
                    //                   controller.productModels[index].image,
                    //                   fit: BoxFit.fill,
                    //                 ),
                    //               ),
                    //               SizedBox(height: 20),
                    //               CustomText(
                    //                 text:
                    //                     controller.productModels[index].name,
                    //                 alignment: Alignment.bottomLeft,
                    //                 fontSize: 15,
                    //               ),
                    //               SizedBox(height: 10),
                    //               CustomText(
                    //                 text:
                    //                     controller.productModels[index].brand,
                    //                 alignment: Alignment.bottomLeft,
                    //                 color: Colors.grey,
                    //                 fontSize: 12,
                    //               ),
                    //               SizedBox(height: 10),
                    //               CustomText(
                    //                 text: '\$' +
                    //                     controller.productModels[index].price,
                    //                 alignment: Alignment.bottomLeft,
                    //                 color: primaryColor,
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //     separatorBuilder: (ctx, index) => SizedBox(width: 20),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
    );
  }
}
