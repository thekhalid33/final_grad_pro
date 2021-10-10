import 'package:admin_grad_pro/helpers/admin_firestore_helper.dart';
import 'package:admin_grad_pro/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AdminCustomersViewModel extends GetxController {
  AdminCustomersViewModel() {
    getAllUsersFromFireStore();
  }

  UserModel wantToDelete;

  ValueNotifier<bool> fetching = ValueNotifier(false);

  List<UserModel> _users = [];
  List<UserModel> get users => _users;

  Future getAllUsersFromFireStore() async {
    fetching = ValueNotifier(true);

    _users = [];

    List allUsersDocs =
        await AdminFireStoreHelper.adminFireStoreHelper.getAllUsers();

    for (int i = 0; i < allUsersDocs.length; i++) {
      _users.add(
        UserModel.fromMap(allUsersDocs[i].data()),
      );
    }
    fetching = ValueNotifier(false);
    update();
  }

  // deleteUserFromFireStore() async {
  //   AdminFireStoreHelper.adminFireStoreHelper.deleteUser(wantToDelete.id);
  // }
}
