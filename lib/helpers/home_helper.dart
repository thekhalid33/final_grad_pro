import 'package:cloud_firestore/cloud_firestore.dart';

class HomeHelper {
  HomeHelper._();
  static HomeHelper homeHelper = HomeHelper._();

  FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getCategory() async {
    QuerySnapshot<Map<String, dynamic>> value =
        await _firebaseFireStore.collection('Categories').get();

    return value.docs;
  }

  addProductToCategory() async {
    // QuerySnapshot<Map<String, dynamic>> value =
    // await _firebaseFireStore.collection('Categories').doc().collection(collectionPath);

    // return value.docs;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getAllProducts() async {
    QuerySnapshot<Map<String, dynamic>> value =
        await _firebaseFireStore.collection('Products').get();

    return value.docs;
  }
}
