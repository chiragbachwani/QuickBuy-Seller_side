import 'package:quick_buy_seller/const/const.dart';

class HomeController extends GetxController {
  @override
  void onInit() async {
    await getusername();
    super.onInit();
  }

  var username = '';

  getusername() async {
    var n = await firestore
        .collection(vendorsCollection)
        .where('id', isEqualTo: currentuser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['vendor_name'];
      }
    });
    username = n;
  }

  
}
