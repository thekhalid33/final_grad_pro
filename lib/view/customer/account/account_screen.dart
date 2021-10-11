import 'package:admin_grad_pro/lviewmodels/profile_view_model.dart';
import 'package:admin_grad_pro/view/customer/account/account_sub_screens/order_history.dart';
import 'package:admin_grad_pro/view/customer/account/account_sub_screens/profile_screen.dart';
import 'package:admin_grad_pro/view/customer/home/home_sub_screens/favorites_screen.dart';
import 'package:admin_grad_pro/view/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileViewModel>(
      init: Get.find<ProfileViewModel>(),
      builder: (controller) => controller.loading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              body: Container(
                padding: EdgeInsets.only(top: 50),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 70),
                      CustomListTile(
                        text: 'View Profile',
                        image: 'assets/menu_icon/Icon_Edit-Profile.png',
                        onPress: () {
                          Get.to(ProfileScreen());
                        },
                      ),
                      SizedBox(height: 15),
                      CustomListTile(
                        text: 'Order History',
                        image: 'assets/menu_icon/Icon_History.png',
                        onPress: () {
                          Get.to(() => OrderHistory());
                        },
                      ),
                      SizedBox(height: 15),
                      CustomListTile(
                        text: 'Favorites',
                        image: 'assets/menu_icon/Icon_Alert.png',
                        onPress: () {
                          Get.to(FavoritesScreen());
                        },
                      ),
                      SizedBox(height: 15),
                      CustomListTile(
                        text: 'Log Out',
                        image: 'assets/menu_icon/Icon_Exit.png',
                        onPress: () {
                          controller.signOut();
                        },
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
