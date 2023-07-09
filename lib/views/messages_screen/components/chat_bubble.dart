import 'package:quick_buy_seller/const/const.dart';

Widget chatBubble() {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
          color: turquoiseColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "hello".text.white.size(16).make(),
          10.heightBox,
          "10:45 AM".text.color(whiteColor.withOpacity(0.5)).make()
        ],
      ),
    ),
  );
}
