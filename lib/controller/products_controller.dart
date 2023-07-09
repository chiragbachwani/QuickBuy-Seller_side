import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_buy_seller/const/const.dart';
import 'package:path/path.dart';
import 'package:quick_buy_seller/controller/home_controller.dart';

import '../models/category_model.dart';

class ProductsController extends GetxController {
  var isloading = false.obs;
  @override
  void onInit() {
    getcolorvalue();
    super.onInit();
  }

  var productnameController = TextEditingController();
  var productdescController = TextEditingController();
  var productpriceController = TextEditingController();
  var productqtyController = TextEditingController();

  var categoryList = <String>[].obs;
  var subcategoryList = <String>[].obs;

  List<Category> category = [];

  var pImgsList = RxList<dynamic>.generate(3, (index) => null);
  var pImgsLinks = [];

  var categoryValue = ''.obs;
  var subcategoryValue = ''.obs;
  var selectedColorindex = 0.obs;
  var colorlist = <bool>[].obs;

  var selectedColorlist = [];

  getCategories() async {
    var data = await rootBundle.loadString("lib/services/category_model.json");

    var cat = categoryModelFromJson(data);
    category = cat.categories;
  }

  populateCategorylist() {
    categoryList.clear();
    for (var item in category) {
      categoryList.add(item.name);
    }
  }

  getcolorvalue() {
    colorlist.assignAll(RxList<bool>.generate(9, (index) => false));
  }

  populateSubCategorylist(cat) {
    subcategoryList.clear(); // Clear subcategoryList instead of categoryList
    var data = category.where((element) => element.name == cat).toList();

    for (var i = 0; i < data.first.subcategory.length; i++) {
      subcategoryList.add(data.first.subcategory[i]);
    }
  }

  pickimage(index, context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (img == null) {
        return;
      } else {
        pImgsList[index] = File(img.path);
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadimages() async {
    var pImgsLinksMap = {}; // Use a Map to associate image files with URLs
    for (var i = 0; i < pImgsList.length; i++) {
      var item = pImgsList[i];
      if (item != null) {
        var filename = basename(item.path);
        var destination = "images/vendors/${currentuser!.uid}/$filename";
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var downloadURL = await ref.getDownloadURL();
        pImgsLinksMap[item] =
            downloadURL; // Associate the image file with its URL
      }
    }

    // Convert the Map values to a List and assign it to pImgsLinks
    pImgsLinks.assignAll(pImgsLinksMap.values.toList());
  }

  getselectedColors() async {
    selectedColorlist.clear();
    for (var i = 0; i < 8; i++) {
      if (colorlist[i]) {
        selectedColorlist.add(colorCodes[i]);
      }
    }
  }

  uploadProduct(context) async {
    await getselectedColors();
    var store = firestore.collection(productsCollection).doc();
    await store.set({
      'is_featured': false,
      'p_category': categoryValue.value,
      'p_subcategory': subcategoryValue.value,
      'p_colors': FieldValue.arrayUnion(selectedColorlist),
      'p_imgs': FieldValue.arrayUnion(pImgsLinks),
      'p_wishlist': FieldValue.arrayUnion([]),
      'p_desc': productdescController.text,
      'p_name': productnameController.text,
      'p_price': productpriceController.text,
      'p_quantity': productqtyController.text,
      'p_seller': Get.put(HomeController()).username,
      'p_rating': '5.0',
      'vendor_id': currentuser!.uid,
      'featured_id': ''
    });
    isloading(false);
    VxToast.show(context, msg: "Product uploaded");
  }

  addFeatured(docId) async {
    await firestore.collection(productsCollection).doc(docId).set(
        {'featured_id': currentuser!.uid, 'is_featured': true},
        SetOptions(merge: true));
  }

  removeFeatured(docId) async {
    await firestore.collection(productsCollection).doc(docId).set(
        {'featured_id': '', 'is_featured': false}, SetOptions(merge: true));
  }

  removeProduct(docId) async {
    await firestore.collection(productsCollection).doc(docId).delete();
  }
}
