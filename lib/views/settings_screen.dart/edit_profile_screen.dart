import 'dart:io';
import 'package:quick_buy_seller/const/const.dart';
import 'package:quick_buy_seller/controller/profile_controller.dart';
import 'package:quick_buy_seller/widgets/custom_textfield.dart';
import 'package:quick_buy_seller/widgets/loading_indicator.dart';
import 'package:quick_buy_seller/widgets/our_button.dart';
import 'package:quick_buy_seller/widgets/text_style.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;
  const EditProfileScreen({super.key, this.username});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.put(ProfileController());

  @override
  void initState() {
    controller.nameController.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor.withOpacity(0.9),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: white,
              )),
          title: boldText(text: editprofile, size: 18.0, color: white),
          actions: [
            controller.isloading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);

                      //if image is not selected

                      if (controller.profileImgPath.value.isNotEmpty) {
                        await controller.uplaodProfileImage();
                      } else {
                        controller.profileImagelink =
                            controller.snapshotData['imageUrl'];
                      }

                      //if old password field matches the old passsword
                      if (controller.snapshotData['password'] ==
                          controller.oldpassController.text) {
                        controller.changeAuthpassword(
                            email: controller.snapshotData['email'],
                            password: controller.oldpassController.text,
                            newpassword: controller.newpassController.text);

                        await controller.updateProfile(
                            imgUrl: controller.profileImagelink,
                            name: controller.nameController.text,
                            password: controller.newpassController.text);
                        // ignore: use_build_context_synchronously
                        VxToast.show(context, msg: "Updated");
                      } else if (controller
                              .oldpassController.text.isEmptyOrNull &&
                          controller.newpassController.text.isEmptyOrNull) {
                        await controller.updateProfile(
                            imgUrl: controller.profileImagelink,
                            name: controller.nameController.text,
                            password: controller.snapshotData['password']);
                        VxToast.show(context, msg: "Changes Saved");
                        // ignore: use_build_context_synchronously
                      } else {
                        VxToast.show(context, msg: "Some Error Occured");
                        controller.isloading(false);
                      }
                    },
                    child: normalText(text: save, color: white, size: 16.0))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              controller.snapshotData['imageUrl'] == '' &&
                      controller.profileImgPath.isEmpty
                  ? CircleAvatar(
                      radius: 60,
                      child: Image.asset("assets/icons/profile.png"),
                    )
                  : controller.snapshotData['imageUrl'] != '' &&
                          controller.profileImgPath.isEmpty
                      ? CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              NetworkImage(controller.snapshotData['imageUrl']))
                      : CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              FileImage(File(controller.profileImgPath.value)),
                        ),
              10.heightBox,
              ourButton(
                  title: changeImage,
                  onpress: () {
                    controller.selectImage(context);
                  },
                  color: turquoiseColor),
              20.heightBox,
              customTextField(
                  lable: name,
                  hint: "eg. Chirag",
                  icon: Icons.people,
                  controller: controller.nameController),
              10.heightBox,
              Align(
                  alignment: Alignment.centerLeft,
                  child: boldText(
                      text: "    Change Your Password", color: darkFontGrey)),
              10.heightBox,
              customTextField(
                  lable: password,
                  hint: passhint,
                  icon: Icons.key,
                  controller: controller.oldpassController),
              10.heightBox,
              customTextField(
                  lable: confirmPass,
                  hint: passhint,
                  icon: Icons.key,
                  controller: controller.newpassController),
            ],
          )
              .box
              .white
              .outerShadowLg
              .rounded
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
              .make(),
        ),
      ),
    );
  }
}
