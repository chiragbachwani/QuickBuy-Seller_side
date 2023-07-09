import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_buy_seller/const/colors.dart';
import 'package:quick_buy_seller/controller/profile_controller.dart';
import 'package:quick_buy_seller/widgets/custom_textfield.dart';
import 'package:quick_buy_seller/widgets/loading_indicator.dart';

import '../../const/const.dart';
import '../../const/strings.dart';
import '../../widgets/text_style.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor.withOpacity(0.9),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: white,
              )),
          title: boldText(text: shopsettings, size: 18.0, color: white),
          actions: [
            controller.isloading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);
                      await controller.updateShop(
                          shopname: controller.shopnameController.text,
                          shopAddress: controller.shopaddressController.text,
                          shopDescription:
                              controller.shopdescriptionController.text,
                          shopmobile: controller.shopmobileController.text,
                          Shopwebsite: controller.shopwebsiteController.text);
                      VxToast.show(context, msg: "Shop Details updated");
                    },
                    child: normalText(text: save, color: white, size: 16.0))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              customTextField(
                  lable: shopname,
                  hint: nameHint,
                  icon: Icons.shop,
                  controller: controller.shopnameController),
              10.heightBox,
              customTextField(
                  lable: address,
                  hint: shopAddressHint,
                  icon: Icons.location_city,
                  controller: controller.shopaddressController),
              10.heightBox,
              customTextField(
                  lable: mobile,
                  hint: shopMobileHint,
                  icon: Icons.phone,
                  controller: controller.shopmobileController),
              10.heightBox,
              customTextField(
                  lable: website,
                  hint: shopWebsiteHint,
                  icon: Icons.web,
                  controller: controller.shopwebsiteController),
              10.heightBox,
              TextFormField(
                controller: controller.shopdescriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  isDense: true,
                  label: normalText(text: description, color: fontGrey),
                  filled: true,
                  fillColor: Vx.gray100,
                  prefixIcon: const Icon(
                    Icons.description_outlined,
                    color: purpleColor,
                  ),
                  hintText: shopDescHint,
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    color: textfieldGrey,
                  ),
                  labelStyle: const TextStyle(fontSize: 14),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 1.0, horizontal: 18.0),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Vx.purple300),
                  ),
                ),
              ),
            ],
          )
              .box
              .white
              .rounded
              .padding(const EdgeInsets.all(18))
              .margin(const EdgeInsets.all(8))
              .height(390)
              .outerShadowLg
              .make(),
        ),
      ),
    );
  }
}
