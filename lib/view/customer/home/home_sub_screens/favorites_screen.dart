import '../../../../utils/constance.dart';
import 'package:admin_grad_pro/lviewmodels/favorites_view_model.dart';
import 'package:admin_grad_pro/utils/enums.dart';
import 'package:admin_grad_pro/view/widgets/custom_text.dart';
import 'package:admin_grad_pro/view/widgets/slidable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoritesViewModel>(
      init: Get.find<FavoritesViewModel>(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(
            'My Favorites',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
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
        body: controller.favoritesProducts.length == 0
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
                        itemCount: controller.favoritesProducts.length ?? 0,
                        itemBuilder: (context, index) {
                          return SlidableWidget(
                            index: 2,
                            id: controller.favoritesProducts[index].productId,
                            child: buildFavoriteProduct(
                              controller: controller,
                              index: index,
                            ),
                            onDismissed: (action) =>
                                favoriteDismissSlidableItem(
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
                ],
              ),
      ),
    );
  }
}

void favoriteDismissSlidableItem({
  @required FavoritesViewModel controller,
  @required int index,
  @required SlidableAction action,
}) {
  switch (action) {
    case SlidableAction.unFavorite:
      controller.deleteFavoriteProduct(index);
      Get.snackbar('Deleting Product', 'Product was deleted successfully');
      break;
  }
}

Widget buildFavoriteProduct(
    {@required FavoritesViewModel controller, @required int index}) {
  return Container(
    height: 140,
    child: Row(
      children: <Widget>[
        Container(
          width: 140,
          child: Image.network(
            controller.favoritesProducts[index].image,
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              Container(
                width: Get.width * 0.4,
                child: RichText(
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: controller.favoritesProducts[index].name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              CustomText(
                text: '\$' + controller.favoritesProducts[index].price,
                color: primaryColor,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
