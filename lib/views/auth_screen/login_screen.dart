import 'package:quick_buy_seller/const/const.dart';
import 'package:quick_buy_seller/controller/auth_controller.dart';
import 'package:quick_buy_seller/views/home%20screen/home.dart';
import 'package:quick_buy_seller/widgets/loading_indicator.dart';
import 'package:quick_buy_seller/widgets/our_button.dart';
import 'package:quick_buy_seller/widgets/text_style.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      backgroundColor: purpleColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 30.heightBox,
                // normalText(text: welcome, size: 18.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      icLogo,
                      width: 200,
                      height: 200,
                    ).box.padding(const EdgeInsets.all(8)).roundedSM.make(),
                    10.heightBox,
                  ],
                ),
                10.heightBox,
                Obx(
                  () => Column(
                    children: [
                      boldText(text: loginto, size: 16.0, color: purpleColor),
                      30.heightBox,
                      TextFormField(
                        controller: controller.emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Vx.gray100,
                          prefixIcon: const Icon(
                            Icons.email,
                            color: purpleColor,
                          ),
                          hintText: emailhint,
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            color: textfieldGrey,
                          ),
                          labelStyle: TextStyle(fontSize: 14),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 18.0),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(50)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(color: Vx.purple300),
                          ),
                        ),
                      ),
                      10.heightBox,
                      TextFormField(
                        controller: controller.passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Vx.gray100,
                          prefixIcon: const Icon(
                            Icons.key,
                            color: purpleColor,
                          ),
                          hintText: passhint,
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            color: textfieldGrey,
                          ),
                          labelStyle: TextStyle(fontSize: 14),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 18.0),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(50)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(color: Vx.purple300),
                          ),
                        ),
                      ),
                      30.heightBox,
                      TextButton(
                          onPressed: () {},
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: normalText(
                                  text: forgotPassword, color: Vx.blue500))),
                      20.heightBox,
                      SizedBox(
                          width: context.screenWidth - 90,
                          child: controller.isloading.value
                              ? loadingIndicator()
                              : ourButton(
                                  title: login,
                                  onpress: () async {
                                    controller.isloading(true);
                                    await controller
                                        .loginMethod(context: context)
                                        .then((value) {
                                      if (value != null) {
                                        VxToast.show(context, msg: "Logged in");
                                        controller.isloading(false);
                                        Get.offAll(() => const Home());
                                      } else {
                                        controller.isloading(false);
                                      }
                                    });
                                  })),
                      10.heightBox
                    ],
                  )
                      .box
                      .white
                      .rounded
                      .outerShadowMd
                      .padding(EdgeInsets.all(6))
                      .make(),
                ),
                10.heightBox,
                Center(
                    child: normalText(
                        text: anyProblem, color: Vx.gray300, size: 14.0))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
