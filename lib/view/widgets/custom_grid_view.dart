import '../../utils/constance.dart';
import 'package:admin_grad_pro/view/customer/details_screen.dart';
import 'package:admin_grad_pro/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomGridView extends StatelessWidget {
  List productsList;

  CustomGridView({
    @required this.productsList,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: productsList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
        childAspectRatio: (1 / 2.2),
      ),
      itemBuilder: (ctx, index) {
        return GestureDetector(
          onTap: () {
            Get.to(
              () => DetailsScreen(
                model: productsList[index],
              ),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Column(
              children: <Widget>[
                Container(
                  height: 220,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Image.network(
                    productsList[index].image,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 20),
                CustomText(
                  text: productsList[index].name,
                  alignment: Alignment.bottomLeft,
                  fontSize: 15,
                ),
                SizedBox(height: 10),
                CustomText(
                  text: productsList[index].brand,
                  alignment: Alignment.bottomLeft,
                  color: Colors.grey,
                  fontSize: 12,
                ),
                SizedBox(height: 10),
                CustomText(
                  text: '\$' + productsList[index].price,
                  alignment: Alignment.bottomLeft,
                  color: primaryColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
