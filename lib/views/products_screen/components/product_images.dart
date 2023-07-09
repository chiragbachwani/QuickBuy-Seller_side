import 'package:quick_buy_seller/const/const.dart';
import 'package:quick_buy_seller/widgets/text_style.dart';

Widget productImages({required label, onpress}) {
  return "$label"
      .text
      .bold
      .color(darkFontGrey)
      .makeCentered()
      .box
      .gray200
      .size(100, 100)
      .roundedSM
      .make();
}
