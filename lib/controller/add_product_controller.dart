import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:quick_buy_seller/controller/products_controller.dart';

class AddProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductsController());
  }
}
