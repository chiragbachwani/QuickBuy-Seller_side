import 'package:quick_buy_seller/const/const.dart';

class StoreServices {
  static getprofile(uid) {
    return firestore
        .collection(vendorsCollection)
        .where('id', isEqualTo: uid)
        .get();
  }

  static getMessages(uid) {
    return firestore
        .collection(chatscollection)
        .where('toId', isEqualTo: uid)
        .snapshots();
  }

  static getOrders(uid) {
    return firestore
        .collection(orderscollection)
        .where('vendors', arrayContains: uid)
        .snapshots();
  }

  static getproducts(uid) {
    return firestore
        .collection(productsCollection)
        .where('vendor_id', isEqualTo: uid)
        .snapshots();
  }

}
