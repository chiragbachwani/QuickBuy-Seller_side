import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_buy_seller/const/const.dart';
import 'package:quick_buy_seller/controller/orders_controller.dart';
import 'package:quick_buy_seller/services/store_services.dart';

import 'package:quick_buy_seller/widgets/app_bar.dart';
import 'package:intl/intl.dart' as intl;
import 'package:quick_buy_seller/widgets/loading_indicator.dart';

import '../../widgets/text_style.dart';
import 'order_details.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrdersController());
    return Scaffold(
      appBar: appbar(title: orders),
      body: StreamBuilder(
        stream: StoreServices.getOrders(currentuser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(data.length, (index) {
                    var date = data[index]['order_date'].toDate();
                    return ListTile(
                            onTap: () {
                              Get.to(() => OrdersDetails(
                                    data: data[index],
                                  ));
                            },
                            tileColor: Vx.purple100,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                            title: boldText(
                                text: "${data[index]['order_code']}",
                                color: purpleColor,
                                size: 15.0),
                            subtitle: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_month,
                                      color: fontGrey,
                                    ),
                                    10.widthBox,
                                    normalText(
                                        text: intl.DateFormat()
                                            .add_yMd()
                                            .format(date),
                                        color: fontGrey)
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.payment,
                                      color: fontGrey,
                                    ),
                                    10.widthBox,
                                    boldText(text: unpaid, color: red)
                                  ],
                                )
                              ],
                            ),
                            trailing: "${data[index]['total_amount']}"
                                .numCurrency
                                .text
                                .bold
                                .color(purpleColor)
                                .size(16)
                                .make())
                        .box
                        .margin(const EdgeInsets.only(bottom: 4))
                        .make();
                  }),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
