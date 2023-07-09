import 'package:firebase_auth/firebase_auth.dart';
import 'package:quick_buy_seller/views/auth_screen/login_screen.dart';
import 'package:quick_buy_seller/views/home%20screen/home.dart';
import '../../const/const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  gotoNextScreen() {
    Future.delayed(const Duration(seconds: 4), () {

     auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(const LoginScreen());
        } else {
          Get.to(() => const Home());
        }
      });
    });
  }

  @override
  void initState() {
    gotoNextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [Image.asset("assets/icons/logos.gif")],
      ),
    );
  }
}
