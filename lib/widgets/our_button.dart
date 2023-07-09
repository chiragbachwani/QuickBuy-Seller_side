import 'package:quick_buy_seller/const/const.dart';
import 'package:quick_buy_seller/widgets/text_style.dart';

Widget ourButton({title, color = purpleColor, onpress}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(12), backgroundColor: color),
      onPressed: onpress,
      child: boldText(text: title, size: 16.0));
}
