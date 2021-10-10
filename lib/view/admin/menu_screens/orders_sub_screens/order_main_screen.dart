import 'package:admin_grad_pro/lviewmodels/zoom_controller.dart';
import 'package:admin_grad_pro/view/admin/menu_screens/orders_sub_screens/done_orders_screen.dart';
import 'package:admin_grad_pro/view/admin/menu_screens/orders_sub_screens/new_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderMainScreen extends StatefulWidget {
  @override
  _OrderMainScreenState createState() => _OrderMainScreenState();
}

class _OrderMainScreenState extends State<OrderMainScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Orders',style: TextStyle( color: Colors.white),),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.find<ZoomController>().drawerController.toggle();
            },
            icon: Icon(Icons.menu,color: Colors.white,),
          ),
          bottom: TabBar(
              labelColor:  Colors.white,
              controller: _tabController, tabs: [
            Tab(
              text: 'New Orders',


            ),
            Tab(
              text:       'Done Orders',
            )
          ]),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [NewOrdersScreen(), DoneOrdersScreen()],
        ));
  }
}
