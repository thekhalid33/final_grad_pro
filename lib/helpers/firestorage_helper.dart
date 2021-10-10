import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageHelper {
  FirebaseStorageHelper._();
  static FirebaseStorageHelper firebaseStorageHelper =
      FirebaseStorageHelper._();
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadUserImage(File file,
      [String folderName = 'profiles']) async {
    String filePath = file.path;
    String fileName = filePath.split('/').last;
    String path = 'images/$folderName/$fileName';
    Reference reference = firebaseStorage.ref(path);

    await reference.putFile(file);

    String imageUrl = await reference.getDownloadURL();

    return imageUrl;
  }

  Future<String> uploadProductsImage(File file,
      [String folderName = 'products']) async {
    String filePath = file.path;
    String fileName = filePath.split('/').last;
    String path = 'images/$folderName/$fileName';
    Reference reference = firebaseStorage.ref(path);

    await reference.putFile(file);

    String imageUrl = await reference.getDownloadURL();

    return imageUrl;
  }

  Future<String> uploadCategoryImage(File file,
      [String folderName = 'categories']) async {
    String filePath = file.path;
    String fileName = filePath.split('/').last;
    String path = 'images/$folderName/$fileName';
    Reference reference = firebaseStorage.ref(path);

    await reference.putFile(file);

    String imageUrl = await reference.getDownloadURL();

    return imageUrl;
  }
}
