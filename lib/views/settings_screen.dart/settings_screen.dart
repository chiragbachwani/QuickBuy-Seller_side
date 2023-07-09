import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quick_buy_seller/const/const.dart';
import 'package:quick_buy_seller/controller/auth_controller.dart';
import 'package:quick_buy_seller/controller/profile_controller.dart';
import 'package:quick_buy_seller/services/store_services.dart';
import 'package:quick_buy_seller/views/auth_screen/login_screen.dart';
import 'package:quick_buy_seller/views/messages_screen/messages_screen.dart';
import 'package:quick_buy_seller/views/settings_screen.dart/edit_profile_screen.dart';
import 'package:quick_buy_seller/views/shop%20settings/shop_setting_screen.dart';
import 'package:quick_buy_seller/widgets/loading_indicator.dart';
import 'package:quick_buy_seller/widgets/text_style.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    const double circleRadius = 120.0;
    return Scaffold(
      backgroundColor: purpleColor.withOpacity(0.9),
      appBar: AppBar(
        title: boldText(text: settings, size: 18.0, color: white),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => EditProfileScreen(
                      username: controller.snapshotData['vendor_name'],
                    ));
              },
              icon: const Icon(
                Icons.edit,
                color: white,
              )),
          TextButton(
              onPressed: () async {
                await Get.put(AuthController()).signoutmethod(context);
                Get.offAll(() => LoginScreen());
              },
              child: normalText(text: logout, color: white))
        ],
      ),
      body: FutureBuilder(
        future: StoreServices.getprofile(currentuser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator(circleColor: white);
          } else {
            controller.snapshotData = snapshot.data!.docs[0];
            return Column(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 16.0),

                          // Here we adjust the top padding value to move the entire box lower
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: circleRadius / 2.0,
                                ),
                                child: Container(
                                  height: 160.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 8.0,
                                        offset: Offset(0.0, 5.0),
                                      ),
                                    ],
                                  ),
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15.0, bottom: 15.0),
                                    child: Column(
                                      children: <Widget>[
                                        const SizedBox(
                                          height: circleRadius / 2,
                                        ),
                                        Text(
                                          "${controller.snapshotData['vendor_name']}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22.0),
                                        ),
                                        Text(
                                          "${controller.snapshotData['email']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.0,
                                              color: Colors.lightBlueAccent),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              /// Image Avatar
                              Container(
                                width: circleRadius,
                                height: circleRadius,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 8.0,
                                      offset: Offset(0.0, 5.0),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Center(
                                      child: controller
                                                  .snapshotData['imageUrl'] ==
                                              ''
                                          ? CircleAvatar(
                                              radius: 60,
                                              child: Image.asset(icProfile),
                                            )
                                          : CircleAvatar(
                                              radius: 60,
                                              child: Image.network(controller
                                                      .snapshotData['imageUrl'])
                                                  .box
                                                  .roundedFull
                                                  .clip(Clip.antiAlias)
                                                  .make(),
                                            )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: profilebuttonTitles.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      color: lightGrey,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        switch (index) {
                          case 0:
                            Get.to(() => ShopSettings());

                            break;
                          case 1:
                            Get.to(() => MessagesScreen());

                            break;
                        }
                      },
                      leading: Icon(
                        profilebuttonIcons[index],
                      ),
                      title: profilebuttonTitles[index]
                          .text
                          .color(Vx.gray600)
                          .make(),
                    );
                  },
                )
                    .box
                    .white
                    .rounded
                    .height(450)
                    .width(context.screenWidth - 30)
                    .padding(const EdgeInsets.symmetric(horizontal: 16))
                    .make(),
              ],
            );
          }
        },
      ),
    );
  }
}
