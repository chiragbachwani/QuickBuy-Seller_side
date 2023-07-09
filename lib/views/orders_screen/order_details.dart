import 'package:quick_buy_seller/const/const.dart';
import 'package:quick_buy_seller/controller/orders_controller.dart';
import 'package:quick_buy_seller/widgets/our_button.dart';
import 'package:quick_buy_seller/widgets/text_style.dart';
import 'package:intl/intl.dart' as intl;

import 'components/order_placed.dart';

class OrdersDetails extends StatefulWidget {
  final dynamic data;
  const OrdersDetails({Key? key, this.data}) : super(key: key);

  @override
  State<OrdersDetails> createState() => _OrdersDetailsState();
}

class _OrdersDetailsState extends State<OrdersDetails> {
  var controller = Get.find<OrdersController>();

  @override
  void initState() {
    super.initState();
    controller.getOrders(widget.data);
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.onDelivery.value = widget.data['order_on_delivery'];
    controller.delivered.value = widget.data['order_delivered'];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Order Details".text.semiBold.make(),
        ),
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
            height: 60,
            width: context.screenWidth,
            child: ElevatedButton(
              onPressed: () {
                controller.confirmed(true);
                controller.changeStatus(
                    title: 'order_confirmed',
                    status: true,
                    docId: widget.data.id);
              },
              child: boldText(text: "Confirm Order", size: 16.0),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0)),
                  padding: EdgeInsets.all(12),
                  backgroundColor: Colors.green),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                //order dellivery status section
                Visibility(
                  visible: controller.confirmed.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldText(
                          text: "Order Status", color: fontGrey, size: 17.0),
                      SwitchListTile(
                          dense: true,
                          activeColor: Colors.green,
                          value: true,
                          onChanged: (value) {},
                          title: boldText(
                              text: "Placed", color: fontGrey, size: 16.0)),
                      SwitchListTile(
                          activeColor: Colors.green,
                          value: controller.confirmed.value,
                          onChanged: (value) {
                            controller.confirmed.value = value;
                          },
                          title: boldText(
                              text: "Confirmed", color: fontGrey, size: 16.0)),
                      SwitchListTile(
                          activeColor: Colors.green,
                          value: controller.onDelivery.value,
                          onChanged: (value) {
                            controller.onDelivery.value = value;
                            controller.changeStatus(
                                title: 'order_on_delivery',
                                status: value,
                                docId: widget.data.id);
                          },
                          title: boldText(
                              text: "on Delivery",
                              color: fontGrey,
                              size: 16.0)),
                      SwitchListTile(
                          activeColor: Colors.green,
                          value: controller.delivered.value,
                          onChanged: (value) {
                            controller.delivered.value = value;
                            controller.changeStatus(
                                title: 'order_delivered',
                                status: value,
                                docId: widget.data.id);
                          },
                          title: boldText(
                              text: "Delivered", color: fontGrey, size: 16.0)),
                    ],
                  )
                      .box
                      .padding(EdgeInsets.all(6))
                      .outerShadowMd
                      .white
                      .border(color: lightGrey)
                      .roundedSM
                      .make(),
                ),

                Column(
                  children: [
                    orderPlacedDetails(
                        title1: "Order Code",
                        title2: "Shipping Method",
                        d1: "${widget.data['order_code']}",
                        d2: "${widget.data['shipping_method']}"),
                    orderPlacedDetails(
                        title1: "Order Date",
                        title2: "Payment Method",
                        // d1:
                        // DateTime.now(),
                        d1: intl.DateFormat()
                            .add_yMMMEd()
                            .format(widget.data['order_date'].toDate()),
                        d2: "${widget.data['payment_method']}"),
                    orderPlacedDetails(
                        title1: "Payment Status",
                        title2: "Delivery Status",
                        d1: "Unpaid",
                        d2: "Order Placed"),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              boldText(
                                  text: "Shipping Address", color: purpleColor),
                              "${widget.data['order_by_name']}"
                                  .text
                                  .gray500
                                  .semiBold
                                  .make(),
                              "${widget.data['order_by_email']}"
                                  .text
                                  .gray500
                                  .semiBold
                                  .make(),
                              "${widget.data['order_by_address']}"
                                  .text
                                  .gray500
                                  .semiBold
                                  .make(),
                              "${widget.data['order_by_city']}"
                                  .text
                                  .gray500
                                  .semiBold
                                  .make(),
                              "${widget.data['order_by_state']}"
                                  .text
                                  .gray500
                                  .semiBold
                                  .make(),
                              "${widget.data['order_by_postalCode']}"
                                  .text
                                  .gray500
                                  .semiBold
                                  .make(),
                              "${widget.data['order_by_phone']}"
                                  .text
                                  .gray500
                                  .semiBold
                                  .make()
                            ],
                          ),
                          SizedBox(
                            width: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // "Total Amount\n\n".text.semiBold.make(),
                                // "${data['total_amount']}"
                                //     .numCurrency
                                //     .text
                                //     .color(turquoiseColor)
                                //     .bold
                                //     .make()
                                boldText(
                                    text: "Total Amount", color: purpleColor),
                                "${widget.data['total_amount']}"
                                    .numCurrency
                                    .text
                                    .bold
                                    .color(turquoiseColor)
                                    .size(16)
                                    .make()
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
                    .box
                    .outerShadowMd
                    .white
                    .border(color: lightGrey)
                    .roundedSM
                    .make(),
                20.heightBox,
                boldText(text: "Ordered product", color: fontGrey, size: 16.0),
                10.heightBox,
                ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children:
                            List.generate(controller.orders.length, (index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              orderPlacedDetails(
                                  title1:
                                      "${controller.orders[index]['title']}",
                                  title2:
                                      "${controller.orders[index]['tprice']}",
                                  d1: "${controller.orders[index]['qty']} x ",
                                  d2: "Refundable"),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(
                                          controller.orders[index]['color']),
                                      borderRadius: BorderRadius.circular(25)),
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              Divider(),
                            ],
                          );
                        }).toList())
                    .box
                    .outerShadowMd
                    .white
                    .margin(EdgeInsets.only(bottom: 4))
                    .roundedSM
                    .make(),
                20.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
