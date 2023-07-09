import 'package:quick_buy_seller/widgets/text_style.dart';

import '../../../const/const.dart';

Widget orderPlacedDetails({String? title1, String? title2, d1, d2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldText(text: title1, color: fontGrey),
            boldText(text: d1, color: turquoiseColor)
          ],
        ),
        SizedBox(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              boldText(text: title2, color: fontGrey),
              boldText(text: d2, color: fontGrey)
            ],
          ),
        )
      ],
    ),
  );
}
