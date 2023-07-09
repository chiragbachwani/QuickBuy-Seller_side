import 'package:quick_buy_seller/const/const.dart';
import 'package:get/state_manager.dart';

import 'package:quick_buy_seller/controller/products_controller.dart';
import 'package:quick_buy_seller/views/products_screen/components/product_dropdown.dart';
import 'package:quick_buy_seller/views/products_screen/components/product_images.dart';
import 'package:quick_buy_seller/widgets/custom_textfield.dart';
import 'package:quick_buy_seller/widgets/loading_indicator.dart';
import 'package:quick_buy_seller/widgets/text_style.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title:
              boldText(text: "Add Products", color: darkFontGrey, size: 18.0),
          actions: [
            controller.isloading.value
                ? loadingIndicator()
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);
                      await controller.uploadimages();
                      await controller.uploadProduct(context);
                      Get.back();
                    },
                    child: boldText(text: save, color: purpleColor))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField(
                    controller: controller.productnameController,
                    hint: "eg. Laptop",
                    lable: "product name",
                    icon: Icons.markunread_mailbox),
                10.heightBox,
                customTextField(
                  controller: controller.productdescController,
                  hint: "eg. Nice product",
                  lable: "Description",
                  icon: Icons.description,
                  isDesc: true,
                ),
                10.heightBox,
                customTextField(
                    controller: controller.productpriceController,
                    hint: "eg. \$100",
                    lable: "Price",
                    icon: Icons.price_change),
                10.heightBox,
                customTextField(
                    controller: controller.productqtyController,
                    hint: "eg. 35",
                    lable: "Available Qauntity",
                    icon: Icons.bookmarks),
                10.heightBox,
                productDropdown("Category", controller.categoryList,
                    controller.categoryValue, controller),
                10.heightBox,
                productDropdown("SubCategory", controller.subcategoryList,
                    controller.subcategoryValue, controller),
                10.heightBox,
                const Divider(),
                boldText(text: "Choose product images:-", color: fontGrey),
                10.heightBox,
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                        3,
                        (index) => controller.pImgsList[index] != null
                            ? Image.file(controller.pImgsList[index],
                                    width: 100, height: 100)
                                .onTap(() {
                                controller.pickimage(index, context);
                              })
                            : productImages(label: "${index + 1}").onTap(() {
                                controller.pickimage(index, context);
                              })),
                  ),
                ),
                5.heightBox,
                normalText(
                    text: "First image will be your display Image",
                    color: fontGrey),
                10.heightBox,
                const Divider(),
                boldText(text: "Choose product Colors", color: fontGrey),
                10.heightBox,
                Obx(
                  () => Wrap(
                    children: List.generate(
                        9,
                        (index) => Stack(
                              alignment: Alignment.center,
                              children: [
                                VxBox()
                                    .size(50, 50)
                                    .margin(EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 4))
                                    .roundedFull
                                    .border(color: fontGrey)
                                    .color(productColors[index])
                                    .make()
                                    .onTap(() {
                                  controller.colorlist[index] =
                                      !controller.colorlist[index];
                                }),
                                controller.colorlist[index]
                                    ? Icon(
                                        Icons.done,
                                        color: Vx.gray300,
                                      )
                                    : SizedBox()
                              ],
                            )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
