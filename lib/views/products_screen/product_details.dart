import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_buy_seller/const/colors.dart';
import 'package:quick_buy_seller/widgets/text_style.dart';

import '../../const/const.dart';

class ProductsDetails extends StatelessWidget {
  final dynamic data;
  const ProductsDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: boldText(text: "${data['p_name']}", color: fontGrey, size: 16.0),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
              autoPlay: true,
              height: 350,
              aspectRatio: 16 / 9,
              itemCount: data['p_imgs'].length,
              itemBuilder: (context, index) {
                return Image.network(
                  data['p_imgs'][index],
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
              viewportFraction: 1.1,
            ),
            10.heightBox,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title!.text.size(16).color(darkFontGrey).semiBold.make(),
                  boldText(
                      text: "${data['p_name']}", color: fontGrey, size: 16.0),

                  10.heightBox,
                  Row(
                    children: [
                      boldText(
                          text: "${data['p_category']}",
                          color: Vx.gray400,
                          size: 16.0),
                      10.widthBox,
                      normalText(
                          text: "${data['p_subcategory']}",
                          color: Vx.gray400,
                          size: 16.0)
                    ],
                  ),
                  10.heightBox,
                  VxRating(
                    isSelectable: false,
                    value: double.parse(data['p_rating']),
                    onRatingUpdate: (value) {},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    count: 5,
                    maxRating: 5,
                    size: 25,
                  ),
                  10.heightBox,
                  "${data['p_price']}"
                      .numCurrency
                      .text
                      .size(18)
                      .color(turquoiseColor)
                      .bold
                      .make(),
                  20.heightBox,
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              width: 100,
                              child:
                                  normalText(text: "Color", color: fontGrey)),
                          Row(
                            children: List.generate(
                              data['p_colors'].length,
                              (index) => VxBox()
                                  .size(40, 40)
                                  .border(
                                    color: darkFontGrey
                                        .withOpacity(0.5), // Border color
                                    width: 1.5, // Border width
                                  )
                                  .roundedFull
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .color(Color(data['p_colors'][index]))
                                  .make()
                                  .onTap(() {}),
                            ),
                          )
                        ],
                      ),
                      10.heightBox,
                      // quantity row

                      Row(
                        children: [
                          SizedBox(
                              width: 100,
                              child: normalText(
                                  text: "Quantity", color: fontGrey)),
                          normalText(
                              text: "${data['p_quantity']}  items",
                              color: fontGrey),
                        ],
                      )
                    ],
                  ).box.white.padding(EdgeInsets.all(8)).make(),
                  const Divider(),
                  20.heightBox,

                  // "Description".text.color(darkFontGrey).semiBold.make(),
                  boldText(text: "Description", color: fontGrey),
                  10.heightBox,
                  // "${data['p_desc']}".text.color(Vx.gray500).make(),
                  normalText(text: "${data['p_desc']}", color: fontGrey),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
