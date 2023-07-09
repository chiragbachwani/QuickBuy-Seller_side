import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_buy_seller/const/const.dart';
import 'package:quick_buy_seller/services/store_services.dart';
import 'package:quick_buy_seller/views/messages_screen/chat_screen.dart';
import 'package:quick_buy_seller/widgets/loading_indicator.dart';
import 'package:intl/intl.dart' as intl;
import 'package:quick_buy_seller/widgets/text_style.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: boldText(text: messages, size: 16.0, color: fontGrey),
      ),
      body: StreamBuilder(
        stream: StoreServices.getMessages(currentuser!.uid),
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
                    var t = data[index]['created_on'] == null
                        ? DateTime.now()
                        : data[index]['created_on'].toDate();

                    var time = intl.DateFormat("h:mma").format(t);
                    return ListTile(
                      onTap: () {
                        Get.to(() => const ChatScreen());
                      },
                      leading: const CircleAvatar(
                          backgroundColor: purpleColor,
                          child: Icon(
                            Icons.person,
                            color: white,
                          )),
                      title: boldText(
                          text: "${data[index]['sender_name']}",
                          color: darkFontGrey),
                      subtitle: normalText(
                          text: "${data[index]['last_msg']}",
                          color: fontGrey.withOpacity(0.7)),
                      trailing: normalText(text: time, color: darkFontGrey),
                    );
                  }),
                ),
              ),
            );
          }
        },
      ),
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: SingleChildScrollView(
      //     physics: const BouncingScrollPhysics(),
      //     child: Column(
      //       children: List.generate(
      //           20,
      //           (index) => ListTile(
      //                 onTap: () {
      //                   Get.to(() => const ChatScreen());
      //                 },
      //                 leading: const CircleAvatar(
      //                     backgroundColor: purpleColor,
      //                     child: Icon(
      //                       Icons.person,
      //                       color: white,
      //                     )),
      //                 title: boldText(text: "Username", color: darkFontGrey),
      //                 subtitle: normalText(
      //                     text: "Last Message",
      //                     color: fontGrey.withOpacity(0.7)),
      //                 trailing:
      //                     normalText(text: "10:45 AM", color: darkFontGrey),
      //               )),
      //     ),
      //   ),
      // ),
    );
  }
}
