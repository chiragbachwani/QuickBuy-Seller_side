import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_buy_seller/const/const.dart';
import 'package:quick_buy_seller/views/messages_screen/components/chat_bubble.dart';

import '../../const/colors.dart';
import '../../widgets/text_style.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_new)),
        title: boldText(text: "Username", size: 16.0, color: fontGrey),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return chatBubble();
                },
              ),
            ),
            10.heightBox,
            SizedBox(
              height: 56,
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Enter Message",
                        filled: true,
                        fillColor: Vx.gray200,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: purpleColor.withOpacity(0.4)),
                            borderRadius: BorderRadius.circular(30))),
                  )),
                  IconButton(
                      onPressed: () {},
                      icon:
                          Icon(Icons.send, color: purpleColor.withOpacity(0.8)))
                ],
              ).box.padding(EdgeInsets.only(bottom: 4)).make(),
            )
          ],
        ),
      ),
    );
  }
}
