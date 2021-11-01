import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthHelper {
  AuthHelper._();
  static AuthHelper authHelper = AuthHelper._();

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String getUserId() {
    return _firebaseAuth.currentUser.uid;
  }

  bool checkUserLogin() {
    if (_firebaseAuth.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<UserCredential> signin(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if(userCredential.user.emailVerified ){
        return userCredential ;
      }else{
        return null;
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.defaultDialog(
            title: 'Error',
            titleStyle: TextStyle(fontSize: 25),
            middleText: 'No user found for that email.',
            middleTextStyle: TextStyle(fontSize: 20),
            textConfirm: 'OK',
            onConfirm: () {
              Get.back();
            });
      } else if (e.code == 'wrong-password') {
        Get.defaultDialog(
            title: 'Error',
            titleStyle: TextStyle(fontSize: 25),
            middleText: 'Wrong password provided for that user.',
            middleTextStyle: TextStyle(fontSize: 20),
            textConfirm: 'OK',
            onConfirm: () {
              Get.back();
            });
      }
      return null;
    }
  }

  Future<UserCredential> signup(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.defaultDialog(
            title: 'Error',
            titleStyle: TextStyle(fontSize: 25),
            middleText: 'The password provided is too weak.',
            middleTextStyle: TextStyle(fontSize: 20),
            textConfirm: 'OK',
            onConfirm: () {
              Get.back();
            });
      } else if (e.code == 'email-already-in-use') {
        Get.defaultDialog(
            title: 'Error',
            titleStyle: TextStyle(fontSize: 25),
            middleText: 'The account already exists for that email.',
            middleTextStyle: TextStyle(fontSize: 20),
            textConfirm: 'OK',
            onConfirm: () {
              Get.back();
            });
      }
      return null;
    } catch (e) {
      Get.defaultDialog(
          title: 'Error',
          titleStyle: TextStyle(fontSize: 25),
          middleText: e.toString(),
          middleTextStyle: TextStyle(fontSize: 20),
          textConfirm: 'OK',
          onConfirm: () {
            Get.back();
          });
      return null;
    }
  }

  resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    Get.defaultDialog(
        title: 'Error',
        titleStyle: TextStyle(fontSize: 25),
        middleText:
            'we have sent email for reset password, please check your email',
        middleTextStyle: TextStyle(fontSize: 20),
        textConfirm: 'OK',
        onConfirm: () {
          Get.back();
        });
  }

  verifyEmail() async {
    await _firebaseAuth.currentUser.sendEmailVerification();
    Get.defaultDialog(
        title: 'Error',
        titleStyle: TextStyle(fontSize: 25),
        middleText: 'verification email has been sent, please check your email',
        middleTextStyle: TextStyle(fontSize: 20),
        textConfirm: 'OK',
        onConfirm: () {
          Get.back();
        });
  }

  logout() async {
    await _firebaseAuth.signOut();
  }
}
