import 'dart:io';

import 'package:admin_grad_pro/helpers/admin_firestore_helper.dart';
import 'package:admin_grad_pro/helpers/auth_helper.dart';
import 'package:admin_grad_pro/helpers/firestorage_helper.dart';
import 'package:admin_grad_pro/helpers/firestore_helper.dart';
import 'package:admin_grad_pro/lviewmodels/cart_view_model.dart';
import 'package:admin_grad_pro/lviewmodels/favorites_view_model.dart';
import 'package:admin_grad_pro/model/city_model.dart';
import 'package:admin_grad_pro/model/register_request.dart';
import 'package:admin_grad_pro/model/user_model.dart';
import 'package:admin_grad_pro/view/admin/flutter_zoom_drawer.dart';
import 'package:admin_grad_pro/view/auth/auth_main_Screen.dart';
import 'package:admin_grad_pro/view/widgets/custom_item_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:admin_grad_pro/view/customer/control_view.dart';
import 'package:get/get.dart';

class AuthViewModel extends GetxController {
  AuthViewModel() {
    getCitiesFromFireStore();
    getUserFromFireStore();
  }

  final CartViewModel _cartViewModel = Get.put(CartViewModel());
  final FavoritesViewModel _favoritesViewModel = Get.put(FavoritesViewModel());

  String myId;

  TabController tabController;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController neighborhoodController = TextEditingController();

  List<String> addingNeighborhoods = [];
  List<Widget> addedTextFields = [];

  int index = 0;

  TextEditingController cityNameController = TextEditingController();

  TextEditingController addNeighborhoodController = TextEditingController();

  TextEditingController neighborhoodController0 = TextEditingController();
  TextEditingController neighborhoodController1 = TextEditingController();
  TextEditingController neighborhoodController2 = TextEditingController();
  TextEditingController neighborhoodController3 = TextEditingController();
  TextEditingController neighborhoodController4 = TextEditingController();
  TextEditingController neighborhoodController5 = TextEditingController();
  TextEditingController neighborhoodController6 = TextEditingController();

  bool visibility = true;

  CityModel wantToEditModel;

  fillAddressControllers() {
    cityNameController.text = wantToEditModel.name;
    addNeighborhoodController.text = wantToEditModel.neighborhoods[0];
    int i;
    for (i = 1; i < wantToEditModel.neighborhoods.length; i++) {
      TextEditingController controller = whichController(fillLoop: true, i: i);
      controller.text = wantToEditModel.neighborhoods[i];
      int number = i - 1;
      addedTextFields.add(
          CustomItemWidget('Neighborhood ' + number.toString(), controller));
    }
    index = --i;
  }

  whichController({bool loop = false, bool fillLoop = false, int i}) {
    TextEditingController controller;
    if (loop == false && fillLoop == false) {
      switch (index) {
        case 0:
          controller = neighborhoodController0;
          break;
        case 1:
          controller = neighborhoodController1;
          break;
        case 2:
          controller = neighborhoodController2;
          break;
        case 3:
          controller = neighborhoodController3;
          break;
        case 4:
          controller = neighborhoodController4;
          break;
        case 5:
          controller = neighborhoodController5;
          break;
        case 6:
          controller = neighborhoodController6;
          break;
      }
    }
    if (loop == true && fillLoop == false) {
      switch (i) {
        case 0:
          controller = neighborhoodController0;
          break;
        case 1:
          controller = neighborhoodController1;
          break;
        case 2:
          controller = neighborhoodController2;
          break;
        case 3:
          controller = neighborhoodController3;
          break;
        case 4:
          controller = neighborhoodController4;
          break;
        case 5:
          controller = neighborhoodController5;
          break;
        case 6:
          controller = neighborhoodController6;
          break;
      }
    }
    if (fillLoop == true && loop == false) {
      switch (i) {
        case 1:
          controller = neighborhoodController0;
          break;
        case 2:
          controller = neighborhoodController1;
          break;
        case 3:
          controller = neighborhoodController2;
          break;
        case 4:
          controller = neighborhoodController3;
          break;
        case 5:
          controller = neighborhoodController4;
          break;
        case 6:
          controller = neighborhoodController5;
          break;
        case 7:
          controller = neighborhoodController6;
          break;
      }
    }
    return controller;
  }

  addTextField() async {
    TextEditingController controller = whichController();

    addedTextFields
        .add(CustomItemWidget('Neighborhood ' + index.toString(), controller));
    index++;
    if (index == 7) {
      visibility = false;
    }
    update();
  }

  deleteTextField() {
    addedTextFields.removeLast();
    index--;
    if (index < 7) {
      visibility = true;
    }
    update();
  }

  addAddressToFirebase() async {
    if (cityNameController.text.trim().isNotEmpty &&
        addNeighborhoodController.text.trim().isNotEmpty) {
      String cityName = cityNameController.text;
      String firstNeighborhood = addNeighborhoodController.text;
      addingNeighborhoods.add(firstNeighborhood);
      for (int i = 0; i < addedTextFields.length; i++) {
        TextEditingController controller = whichController(i: i, loop: true);
        if (controller.text.trim().isNotEmpty) {
          addingNeighborhoods.add(controller.text);
        }
      }
      await AdminFireStoreHelper.adminFireStoreHelper.addAddressToFirebase(
          name: cityName, neighborhoods: addingNeighborhoods);
      Get.defaultDialog(
          title: 'Successful',
          titleStyle: TextStyle(fontSize: 25),
          middleText: 'The Address was added successfully',
          middleTextStyle: TextStyle(fontSize: 20),
          textConfirm: 'OK',
          onConfirm: () {
            resetAddressControllers();
            getCitiesFromFireStore();
            Get.back();
          });
    } else {
      Get.defaultDialog(
          title: 'Error',
          titleStyle: TextStyle(fontSize: 25),
          middleText: 'Please fill all required fields.',
          middleTextStyle: TextStyle(fontSize: 20),
          textConfirm: 'OK',
          onConfirm: () {
            Get.back();
          });
    }
    update();
  }

  deleteAddressFromFirebase(String id) async {
    await AdminFireStoreHelper.adminFireStoreHelper
        .deleteAddressFromFirebase(id);
    await getCitiesFromFireStore();
  }

  editAddressInFireStore() async {
    if (cityNameController.text.trim().isNotEmpty &&
        addNeighborhoodController.text.trim().isNotEmpty) {
      String cityName = cityNameController.text;
      String firstNeighborhood = addNeighborhoodController.text;
      addingNeighborhoods.add(firstNeighborhood);
      for (int i = 0; i < addedTextFields.length; i++) {
        TextEditingController controller = whichController(i: i, loop: true);
        if (controller.text.trim().isNotEmpty) {
          addingNeighborhoods.add(controller.text);
        }
      }
      await AdminFireStoreHelper.adminFireStoreHelper.editAddressInFireStore(
          id: wantToEditModel.id,
          name: cityName,
          neighborhoods: addingNeighborhoods);
      getCitiesFromFireStore();
      addingNeighborhoods = [];
      Get.back();
      Get.snackbar('Successful', 'The Address was added successfully');
    } else {
      Get.defaultDialog(
          title: 'Error',
          titleStyle: TextStyle(fontSize: 25),
          middleText: 'Please fill all required fields.',
          middleTextStyle: TextStyle(fontSize: 20),
          textConfirm: 'OK',
          onConfirm: () {
            Get.back();
          });
    }

    update();
  }

  resetAddressControllers() {
    cityNameController.clear();
    addNeighborhoodController.clear();
    neighborhoodController0.clear();
    neighborhoodController1.clear();
    neighborhoodController2.clear();
    neighborhoodController3.clear();
    neighborhoodController4.clear();
    neighborhoodController5.clear();
    neighborhoodController6.clear();
    addingNeighborhoods = [];
    addedTextFields = [];
    index = 0;
    wantToEditModel = null;
    visibility = true;
  }

  List<CityModel> cities;
  List<dynamic> neighborhoods = [];
  CityModel selectedCity;
  String selectedNeighborhood;

  selectCity(CityModel cityModel) {
    this.selectedCity = cityModel;
    this.neighborhoods = cityModel.neighborhoods;
    selectNeighborhood(neighborhoods.first.toString());
    update();
  }

  selectNeighborhood(dynamic neighborhood) {
    this.selectedNeighborhood = neighborhood;
    update();
  }

  getCitiesFromFireStore() async {
    List<CityModel> cities =
        await FireStoreHelper.fireStoreHelper.getAllCities();
    this.cities = cities;
    selectCity(cities.first);
    update();
  }

  checkLogin() {
    bool isLoggedIn = AuthHelper.authHelper.checkUserLogin();
    if (isLoggedIn) {
      this.myId = AuthHelper.authHelper.getUserId();
      //TODO: 2 add osama
      if (this.myId == 'z8UktWh4KSTrhh5LbNojma9LFIp2' ||
          this.myId == 'tysJdb582iYpIpbQz6drBNWsyp33') {
        Get.offAll(() => FlutterZoomDrawer());
      } else {
        Get.offAll(() => ControlView());
      }
    } else {
      Get.offAll(() => AuthMainScreen());
    }
  }

  UserModel user;
  getUserFromFireStore() async {
    String userId = AuthHelper.authHelper.getUserId();
    print(userId);
    user = await FireStoreHelper.fireStoreHelper.getUserFromFireStore(userId);
    update();
  }

  fillControllers() {
    emailController.text = user.email;
    firstNameController.text = user.fName;
    lastNameController.text = user.lName;
    cityController.text = user.city;
    neighborhoodController.text = user.neighborhood;
  }

  resetControllers() {
    emailController.clear();
    passwordController.clear();
    firstNameController.clear();
    lastNameController.clear();
  }

  login() async {
    UserCredential userCredential = await AuthHelper.authHelper
        .signin(emailController.text, passwordController.text);
    if (userCredential != null) {
      FireStoreHelper.fireStoreHelper
          .getUserFromFireStore(userCredential.user.uid);
      checkLogin();
      resetControllers();
    }
  }

  register() async {
    try {
      UserCredential userCredential = await AuthHelper.authHelper
          .signup(emailController.text, passwordController.text);

      if (userCredential != null) {
        String imageUrl = await FirebaseStorageHelper.firebaseStorageHelper
            .uploadUserImage(file);
        RegisterRequest registerRequest = RegisterRequest(
          imageUrl: imageUrl,
          id: userCredential.user.uid,
          city: selectedCity.name,
          neighborhood: selectedNeighborhood,
          email: emailController.text,
          fName: firstNameController.text,
          lName: lastNameController.text,
          password: passwordController.text,
        );
        await FireStoreHelper.fireStoreHelper
            .addUserToFireStore(registerRequest);
        await AuthHelper.authHelper.verifyEmail();
        await AuthHelper.authHelper.logout();
        tabController.animateTo(1);
      }
    } on Exception catch (e) {
      // TODO
      Get.defaultDialog(
          title: 'Error',
          titleStyle: TextStyle(fontSize: 25),
          middleText: e.toString(),
          middleTextStyle: TextStyle(fontSize: 20),
          textConfirm: 'OK',
          onConfirm: () {
            Get.back();
          });
    }
    resetControllers();
  }

  resetPassword() async {
    AuthHelper.authHelper.resetPassword(emailController.text);
    resetControllers();
  }

  logout() async {
    await AuthHelper.authHelper.logout();
    _cartViewModel.clearDataBase();
    _favoritesViewModel.clearDataBase();
    myId = '';
    await checkLogin();
    resetControllers();
  }

  updateProfile() async {
    String imageUrl;
    if (updatedFile != null) {
      imageUrl = await FirebaseStorageHelper.firebaseStorageHelper
          .uploadUserImage(updatedFile);
    }
    UserModel userModel = UserModel(
        neighborhood: selectedNeighborhood,
        city: selectedCity.name,
        fName: firstNameController.text,
        lName: lastNameController.text,
        id: user.id,
        imageUrl: imageUrl ?? user.imageUrl);

    await FireStoreHelper.fireStoreHelper.updateProfile(userModel);
    getUserFromFireStore();
    Get.back();
  }

  // For uploading the profile image
  File file;
  selectFile() async {
    XFile imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    this.file = File(imageFile.path);
    update();
  }

  File updatedFile;
  captureUpdateProfileImage() async {
    XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
    this.updatedFile = File(file.path);
    update();
  }
}
