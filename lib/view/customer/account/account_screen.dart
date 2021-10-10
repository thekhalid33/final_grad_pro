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
                      // Container(
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: <Widget>[
                      //       Container(
                      //         width: 120,
                      //         height: 120,
                      //         decoration: BoxDecoration(
                      //           color: Color.fromRGBO(252, 213, 12, 1),
                      //           borderRadius: BorderRadius.circular(120),
                      //           image: DecorationImage(
                      //             image: controller.userModel == null
                      //                 ? NetworkImage(
                      //                     'https://firebasestorage.googleapis.com/v0/b/gradpro-cf1aa.appspot.com/o/images%2Fprofiles%2F-no-user-profile-picture-hand.jpg?alt=media&token=07d4d8da-8c3a-4042-9121-4667fabc53aa')
                      //                 : controller.userModel.imageUrl ==
                      //                         'default'
                      //                     ? NetworkImage(
                      //                         'https://firebasestorage.googleapis.com/v0/b/gradpro-cf1aa.appspot.com/o/images%2Fprofiles%2F-no-user-profile-picture-hand.jpg?alt=media&token=07d4d8da-8c3a-4042-9121-4667fabc53aa')
                      //                     : NetworkImage(
                      //                         controller.userModel.imageUrl),
                      //           ),
                      //         ),
                      //       ),
                      //       Column(
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         children: <Widget>[
                      //           RichText(
                      //             maxLines: 1,
                      //             textAlign: TextAlign.start,
                      //             overflow: TextOverflow.ellipsis,
                      //             text: TextSpan(
                      //               text: (controller.userModel.fName +
                      //                   ' ' +
                      //                   controller.userModel.lName),
                      //               style: TextStyle(
                      //                 color: Colors.black,
                      //                 fontSize: 24,
                      //               ),
                      //             ),
                      //           ),
                      //           RichText(
                      //             maxLines: 1,
                      //             textAlign: TextAlign.start,
                      //             overflow: TextOverflow.ellipsis,
                      //             text: TextSpan(
                      //               text: controller.userModel.email,
                      //               style: TextStyle(
                      //                 color: Colors.black,
                      //                 fontSize: 16,
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(height: 70),
                      CustomListTile(
                        text: 'View Profile',
                        image: 'assets/menu_icon/Icon_Edit-Profile.png',
                        onPress: () {
                          Get.to(ProfileScreen());
                        },
                      ),
                      // SizedBox(height: 15),
                      // CustomListTile(
                      //   text: 'Shipping Address',
                      //   image: 'assets/menu_icon/Icon_Location.png',
                      //   onPress: () {},
                      // ),
                      SizedBox(height: 15),
                      CustomListTile(
                        text: 'Order History',
                        image: 'assets/menu_icon/Icon_History.png',
                        onPress: () {
                          Get.to(() => OrderHistory());
                        },
                      ),
                      // SizedBox(height: 15),
                      // CustomListTile(
                      //   text: 'Cards',
                      //   image: 'assets/menu_icon/Icon_Payment.png',
                      //   onPress: () {},
                      // ),
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
