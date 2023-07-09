import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart'; 
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_buy_seller/const/const.dart';

class ProfileController extends GetxController {
  late QueryDocumentSnapshot snapshotData;
  var profileImgPath = ''.obs;
  var profileImagelink = "";
  var isloading = false.obs;

  //textfield

  var nameController = TextEditingController();
  var oldpassController = TextEditingController();
  var newpassController = TextEditingController();

  //shop controllers
  var shopnameController = TextEditingController();
  var shopaddressController = TextEditingController();
  var shopmobileController = TextEditingController();
  var shopwebsiteController = TextEditingController();
  var shopdescriptionController = TextEditingController();

  selectImage(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);

      if (img == null) return;
      profileImgPath.value = img.path;

      VxToast.show(context, msg: "Image selected");
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uplaodProfileImage() async {
    var filename = basename(profileImgPath.value);
    var destination = "images/${currentuser!.uid}/filename";
    Reference ref = FirebaseStorage.instance.ref().child(destination);          
    await ref.putFile(File(profileImgPath.value));
    profileImagelink = await ref.getDownloadURL();
  }

  updateProfile({name, password, imgUrl}) async {
    var store = firestore.collection(vendorsCollection).doc(currentuser!.uid);
    await store.set(
        {'vendor_name': name, 'password': password, 'imageUrl': imgUrl},
        SetOptions(merge: true));
    isloading(false);
  }

  changeAuthpassword({email, password, newpassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);

    await currentuser!.reauthenticateWithCredential(cred).then((value) {
      currentuser!.updatePassword(newpassword);
    }).catchError((error) {
      print(error.toString());
    });
  }


  updateShop({shopname,shopAddress,shopmobile,Shopwebsite,shopDescription}) async{
    var store = firestore.collection(vendorsCollection).doc(currentuser!.uid);
    await store.set(
        {
          'shop_name':shopname,
          'shop_address':shopAddress,
          'shop_mobile':shopmobile,
          'shop_website':Shopwebsite,
          'shop_desc':shopDescription,
        },
        SetOptions(merge: true));
    isloading(false);
  }























}
