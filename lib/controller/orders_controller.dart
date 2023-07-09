import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_buy_seller/const/const.dart';

class OrdersController extends GetxController {
  var confirmed = false.obs;
  var onDelivery = false.obs;
  var delivered = false.obs;
  var orders = [];

  getOrders(data) {
    orders.clear();
    for (var item in data['orders']) {
      if (item['vendor_id'] == currentuser!.uid) {
        orders.add(item);
      }
    }
  }

  changeStatus({title, status, docId}) async {
    var store = firestore.collection(orderscollection).doc(docId);
    await store.set({title: status}, SetOptions(merge: true));
  }
}
