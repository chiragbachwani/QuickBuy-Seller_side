import 'package:quick_buy_seller/const/const.dart';
import 'package:quick_buy_seller/widgets/text_style.dart';

Widget customTextField(
    {lable, hint, controller, icon = Icons.email, isDesc = false}) {
  return TextFormField(
    controller: controller,
    maxLines: isDesc ? 4 : 1,
    decoration: InputDecoration(
      isDense: true,
      label: normalText(text: "$lable", color: fontGrey),
      filled: true,
      fillColor: Vx.gray100,
      prefixIcon: Icon(icon),
      hintText: hint,
      hintStyle: const TextStyle(
        fontSize: 16,
        color: textfieldGrey,
      ),
      labelStyle: const TextStyle(fontSize: 14),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 1.0, horizontal: 18.0),
      border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius:
              isDesc ? BorderRadius.circular(8.0) : BorderRadius.circular(50)),
      focusedBorder: OutlineInputBorder(
        borderRadius:
            isDesc ? BorderRadius.circular(8.0) : BorderRadius.circular(25),
        borderSide: const BorderSide(color: Vx.purple300),
      ),
    ),
  );
}
