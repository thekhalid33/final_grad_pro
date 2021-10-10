import 'package:admin_grad_pro/lviewmodels/admin_customer_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/zoom_controller.dart';
import 'package:admin_grad_pro/view/admin/menu_screens/customer_sub_screens/customer_profile_screen.dart';
import 'package:admin_grad_pro/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomersManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customers Management',style: TextStyle(color: Colors.white),),
        leading: IconButton(
          onPressed: () {
            Get.find<ZoomController>().drawerController.toggle();
          },
          icon: Icon(Icons.menu,color: Colors.white,),
        ),
      ),
      body: GetBuilder<AdminCustomersViewModel>(
        init: Get.find<AdminCustomersViewModel>(),
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: controller.fetching.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  itemCount: controller.users.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      controller.wantToDelete = controller.users[index];
                      Get.to(() => CustomerProfileScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: 80,
                          height: 80,
                          child: CircleAvatar(
                            child: ClipOval(
                              child: Image.network(
                                controller.users[index].imageUrl,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        RichText(
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            text: controller.users[index].email,
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  separatorBuilder: (context, index) => Divider(
                    height: 50,
                    thickness: 2,
                    color: Colors.grey,
                  ),
                ),
        ),
      ),
    );
  }
}
