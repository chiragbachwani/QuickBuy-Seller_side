import 'package:quick_buy_seller/const/const.dart';
import 'package:quick_buy_seller/widgets/text_style.dart';
import 'package:intl/intl.dart' as intl;

AppBar appbar({title}) {
  return AppBar(
    backgroundColor: Colors.white,
    actions: [
      Center(
        child: boldText(
            text: intl.DateFormat('EEE, MMM d, ' 'yy').format(DateTime.now()),
            color: purpleColor),
      ),
      10.widthBox,
    ],
    automaticallyImplyLeading: false,
    title: boldText(text: "$title", color: darkFontGrey, size: 18.0),
  );
}
