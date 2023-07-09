import 'package:quick_buy_seller/const/const.dart';
import 'package:quick_buy_seller/views/products_screen/add_product.dart';
import 'package:quick_buy_seller/views/auth_screen/login_screen.dart';
import 'package:quick_buy_seller/views/home%20screen/home_screen.dart';
import 'package:quick_buy_seller/views/orders_screen/orders_screen.dart';
import 'package:quick_buy_seller/views/products_screen/product_screen.dart';
import 'package:quick_buy_seller/views/settings_screen.dart/settings_screen.dart';
import 'package:quick_buy_seller/widgets/text_style.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Home extends StatelessWidget {
  const Home({super.key});



  @override
  Widget build(BuildContext context) {

    
    PersistentTabController navController;

    navController = PersistentTabController(initialIndex: 0);

    List<Widget> _buildScreens() {
      return [
        const HomeScreen(),
        const ProductScreen(),
        // const AddProductScreen(),
        const OrdersScreen(),
        const SettingsScreen()
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          title: dashboard,
          activeColorPrimary: purpleColor,
          inactiveColorPrimary: Vx.gray400,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.markunread_mailbox),
          title: products,
          activeColorPrimary: purpleColor,
          inactiveColorPrimary: Vx.gray400,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.list_alt),
          title: orders,
          activeColorPrimary: purpleColor,
          inactiveColorPrimary: Vx.gray400,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.settings),
          title: settings,
          activeColorPrimary: purpleColor,
          inactiveColorPrimary: Vx.gray400,
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: navController,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style6, 
    );
  }
}
