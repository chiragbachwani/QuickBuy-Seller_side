import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_buy_seller/const/const.dart';
import 'package:quick_buy_seller/controller/home_controller.dart';
import 'package:quick_buy_seller/services/store_services.dart';
import 'package:quick_buy_seller/views/products_screen/product_details.dart';
import 'package:quick_buy_seller/widgets/app_bar.dart';
import 'package:quick_buy_seller/widgets/dashboard_button.dart';
import 'package:quick_buy_seller/widgets/loading_indicator.dart';
import 'package:quick_buy_seller/widgets/text_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return Scaffold(
      appBar: appbar(title: dashboard),
      body: StreamBuilder(
        stream: StoreServices.getproducts(currentuser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else {
            var data = snapshot.data!.docs;
            data = data.sortedBy((a, b) =>
                b['p_wishlist'].length.compareTo(a['p_wishlist'].length));
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      dashboardButton(context,
                          title: products,
                          count: data.length,
                          icon: icProducts),
                      dashboardButton(context,
                          title: orders, count: 1, icon: icOrders),
                    ],
                  ),
                  15.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      dashboardButton(context,
                          title: rating, count: 4, icon: icStar),
                      dashboardButton(context,
                          title: totalsales,
                          count: 1,
                          icon: "assets/icons/sales.png"),
                    ],
                  ),
                  10.heightBox,
                  const Divider(),
                  10.heightBox,
                  boldText(
                      text: popularProducts, color: darkFontGrey, size: 16.0),
                  20.heightBox,
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                        data.length,
                        (index) => data[index]['p_wishlist'].length == 0
                            ? const SizedBox()
                            : ListTile(
                                onTap: () {
                                  Get.to(() => ProductsDetails(
                                        data: data[index],
                                      ));
                                },
                                leading: Image.network(
                                  data[index]['p_imgs'][0],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                title: boldText(
                                    text: "${data[index]['p_name']}",
                                    color: darkGrey),
                                subtitle: "${data[index]['p_price']}"
                                    .numCurrency
                                    .text
                                    .gray400
                                    .make()),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
