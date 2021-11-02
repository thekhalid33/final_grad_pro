import 'package:admin_grad_pro/lviewmodels/auth_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/zoom_controller.dart';
import 'package:admin_grad_pro/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthViewModel _authViewModel = Get.find<AuthViewModel>();
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: _authViewModel.user.imageUrl.isNotEmpty
                            ? NetworkImage(_authViewModel.user.imageUrl)
                            : ClipOval(
                                child: Image(
                                  image: AssetImage(
                                    "assets/images/empty.jpg",
                                  ),
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.fill,
                                ),
                              ),
                        maxRadius: 47,
                      ),
                      SizedBox(height: 12),
                      if (_authViewModel.user.id
                              .compareTo('z8UktWh4KSTrhh5LbNojma9LFIp2') ==
                          0)
                        Text(
                          'Khalid EL-ijla',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      if (_authViewModel.user.id
                              .compareTo('8oKV7Rrn8AUALC32K8Z5404dOKj2') ==
                          0)
                        Text(
                          'Osama Abu Dahy',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            ...menuItems,
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  String title;
  IconData icon;
  MenuItem(this.icon, this.title);
}

final List<Widget> menuItems = [
  Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        Get.find<ZoomController>().changeScreen(0);
      },
      child: Row(
        children: <Widget>[
          Icon(
            Icons.person_outline,
            color: Colors.white,
          ),
          SizedBox(width: 20),
          Text(
            'Home',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    ),
  ),
  Divider(
    thickness: 2,
    color: Colors.white60,
    height: 30,
  ),
  Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        Get.find<ZoomController>().changeScreen(1);
      },
      child: Row(
        children: <Widget>[
          Icon(
            Icons.format_list_bulleted,
            color: Colors.white,
          ),
          Icon(
            Icons.settings,
            color: Colors.white,
          ),
          SizedBox(width: 20),
          Text('Products', style: TextStyle(color: Colors.white)),
        ],
      ),
    ),
  ),
  Divider(
    thickness: 2,
    color: Colors.white60,
    height: 30,
  ),
  Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        Get.find<ZoomController>().changeScreen(2);
      },
      child: Row(
        children: <Widget>[
          Icon(
            Icons.format_list_bulleted,
            color: Colors.white,
          ),
          Icon(
            Icons.settings,
            color: Colors.white,
          ),
          SizedBox(width: 20),
          Text('Orders', style: TextStyle(color: Colors.white)),
        ],
      ),
    ),
  ),
  Divider(
    thickness: 2,
    color: Colors.white60,
    height: 30,
  ),
  Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        Get.find<ZoomController>().changeScreen(3);
      },
      child: Row(
        children: <Widget>[
          Icon(
            Icons.location_city,
            color: Colors.white,
          ),
          Icon(
            Icons.settings,
            color: Colors.white,
          ),
          SizedBox(width: 20),
          Text('Address', style: TextStyle(color: Colors.white)),
        ],
      ),
    ),
  ),
  Divider(
    thickness: 2,
    color: Colors.white60,
    height: 30,
  ),
  Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        Get.find<ZoomController>().changeScreen(4);
      },
      child: Row(
        children: <Widget>[
          Icon(
            Icons.category,
            color: Colors.white,
          ),
          Icon(
            Icons.settings,
            color: Colors.white,
          ),
          SizedBox(width: 20),
          Text('Categories', style: TextStyle(color: Colors.white)),
        ],
      ),
    ),
  ),
  Divider(
    thickness: 2,
    color: Colors.white60,
    height: 30,
  ),
  Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        Get.find<ZoomController>().changeScreen(5);
      },
      child: Row(
        children: <Widget>[
          Icon(
            Icons.settings,
            color: Colors.white,
          ),
          Icon(
            Icons.settings,
            color: Colors.white,
          ),
          SizedBox(width: 20),
          Text('Customers', style: TextStyle(color: Colors.white)),
        ],
      ),
    ),
  ),
  Divider(
    thickness: 2,
    color: Colors.white60,
    height: 30,
  ),
  Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        Get.find<ZoomController>().changeScreen(6);
      },
      child: Row(
        children: <Widget>[
          Icon(
            Icons.logout,
            color: Colors.white,
          ),
          SizedBox(width: 20),
          Text('Logout', style: TextStyle(color: Colors.white)),
        ],
      ),
    ),
  ),
];
