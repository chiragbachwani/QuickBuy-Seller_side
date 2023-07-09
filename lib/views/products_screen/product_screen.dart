import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quick_buy_seller/const/const.dart';
import 'package:quick_buy_seller/controller/add_product_controller.dart';
import 'package:quick_buy_seller/services/store_services.dart';
import 'package:quick_buy_seller/views/products_screen/add_product.dart';
import 'package:quick_buy_seller/views/products_screen/product_details.dart';
import 'package:quick_buy_seller/widgets/app_bar.dart';
import 'package:quick_buy_seller/widgets/loading_indicator.dart';
import '../../controller/products_controller.dart';
import '../../widgets/text_style.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductsController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        onPressed: () async {
          await controller.getCategories();
          controller.populateCategorylist();
          Get.to(() => const AddProductScreen(), binding: AddProductBinding());
        },
        backgroundColor: purpleColor,
        child: const Icon(
          Icons.add,
          color: white,
        ),
      ),
      appBar: appbar(title: products),
      body: StreamBuilder(
        stream: StoreServices.getproducts(currentuser!.uid),
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
                  children: List.generate(
                    data.length,
                    (index) => Card(
                      color: Color.fromARGB(255, 247, 247, 247),
                      child: ListTile(
                        onTap: () {
                          Get.to(() => ProductsDetails(data: data[index]));
                        },
                        leading: Image.network(
                          "${data[index]['p_imgs'][0]}",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        title: boldText(
                            text: "${data[index]['p_name']}", color: darkGrey),
                        subtitle: Row(
                          children: [
                            "${data[index]['p_price']}"
                                .numCurrency
                                .text
                                .gray400
                                .make(),
                            10.widthBox,
                            Visibility(
                                visible: data[index]['is_featured'],
                                child: boldText(text: "Featured", color: green))
                          ],
                        ),
                        trailing: VxPopupMenu(
                            child: Icon(Icons.more_vert_outlined),
                            menuBuilder: () => Column(
                                    children: List.generate(
                                  popupMenuIconsList.length,
                                  (i) => Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          popupMenuIconsList[i],
                                          color: data[index]['featured_id'] ==
                                                      currentuser!.uid &&
                                                  i == 0
                                              ? green
                                              : darkGrey,
                                        ),
                                        10.widthBox,
                                        normalText(
                                            text: data[index]['featured_id'] ==
                                                        currentuser!.uid &&
                                                    i == 0
                                                ? 'Remove Featured'
                                                : popupMenuTitles[i],
                                            color: darkGrey)
                                      ],
                                    ).onTap(() {
                                      switch (i) {
                                        case 0:
                                          if (data[index]['is_featured'] ==
                                              true) {
                                            controller
                                                .removeFeatured(data[index].id);
                                            VxToast.show(context,
                                                msg: "Removed");
                                          } else {
                                            controller
                                                .addFeatured(data[index].id);
                                            VxToast.show(context, msg: "Added");
                                          }

                                          break;

                                        case 1:
                                          break;

                                        case 2:
                                          controller
                                              .removeProduct(data[index].id);
                                          VxToast.show(context,
                                              msg: "Product Removed");
                                          break;
                                        default:
                                      }
                                    }),
                                  ),
                                )).box.white.rounded.width(250).make(),
                            clickType: VxClickType.singleClick),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
