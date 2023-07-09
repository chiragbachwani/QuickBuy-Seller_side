import 'package:quick_buy_seller/const/const.dart';
import 'package:quick_buy_seller/controller/products_controller.dart';
import 'package:quick_buy_seller/widgets/text_style.dart';

Widget productDropdown(
    hint, List<String> list, dropvalue, ProductsController controller) {
  return Obx(
    () => DropdownButtonHideUnderline(
            child: DropdownButton(
      hint: normalText(text: "$hint", color: fontGrey),
      isExpanded: true,
      value: dropvalue.value == '' ? null : dropvalue.value,
      items: list.map((e) {
        return DropdownMenuItem(
          value: e,
          child: e.toString().text.make(),
        );
      }).toList(),
      onChanged: (newValue) {
        if (hint == "Category") {
          controller.subcategoryValue.value = '';
          controller.populateSubCategorylist(newValue.toString());
        }
        dropvalue.value = newValue.toString();
      },
    ))
        .box
        .gray200
        .roundedSM
        .padding(EdgeInsets.symmetric(horizontal: 4))
        .make(),
  );
}
