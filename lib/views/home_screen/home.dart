// import 'package:emart_seller/const/const.dart';
// import 'package:emart_seller/controllers/home_controller.dart';
// import 'package:emart_seller/views/home_screen/home_screen.dart';
// import 'package:emart_seller/views/orders_screen/orders_screen.dart';
// import 'package:emart_seller/views/products_screen/products_screen.dart';
// import 'package:emart_seller/views/settings_screen/profile_screen.dart';
// import 'package:get/get.dart';
// class Home extends StatelessWidget {
//   const Home({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var controller=Get.put(HomeController());
//     var navScreens=[
//       const HomeScreen(),
//       const ProductsScreen(),
//       const OrdersScreen(),
//       const ProfileScreen()
//     ];
//     var bottomNavbar=[
//        BottomNavigationBarItem(icon:controller.navInderx.value == 0 ?Icon(Icons.home_outlined):Icon(Icons.home),label: dashboard),
//        BottomNavigationBarItem(icon:Image.asset(icProducts,color: darkGrey,width: 24),label: products),
//        BottomNavigationBarItem(icon:Image.asset(icOrders,color: darkGrey,width: 24),label: orders),
//        BottomNavigationBarItem(icon:Image.asset(icGeneralSettings,color: darkGrey,width: 24),label: settings),
//     ];
//     return  Scaffold(
//       bottomNavigationBar: Obx(()=>BottomNavigationBar(
//           onTap: (index){
//             controller.navInderx.value=index;
//           },
//         currentIndex: controller.navInderx.value,
//           items: bottomNavbar,
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: purpleColor,
//           unselectedItemColor: darkGrey,
//         ),
//       ),
//       body: Obx(()=> Column(
//           children: [
//             Expanded(child: navScreens.elementAt(controller.navInderx.value))
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/home_controller.dart';
import 'package:emart_seller/views/home_screen/home_screen.dart';
import 'package:emart_seller/views/orders_screen/orders_screen.dart';
import 'package:emart_seller/views/products_screen/products_screen.dart';
import 'package:emart_seller/views/settings_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navScreens = const [
      HomeScreen(),
      ProductsScreen(),
      OrdersScreen(),
      ProfileScreen(),
    ];
    var simpleIcons = [
      Icons.home,
      Icons.shopping_bag,
      Icons.shopping_cart,
      Icons.settings,
    ];
    var outlinedIcons = [
      Icons.home_outlined,
      Icons.shopping_bag_outlined,
      Icons.shopping_cart_outlined,
      Icons.settings_outlined,
    ];
    var bottomNavbar = [
      BottomNavigationBarItem(
        icon: Icon(controller.navInderx.value == 0 ? simpleIcons[0] : outlinedIcons[0]),
        label: dashboard,

      ),
      BottomNavigationBarItem(
        icon: Icon(controller.navInderx.value == 1 ? simpleIcons[1] : outlinedIcons[1]),
        label: products,
      ),
      BottomNavigationBarItem(
        icon: Icon(controller.navInderx.value == 2 ? simpleIcons[2] : outlinedIcons[2]),
        label: orders,
      ),
      BottomNavigationBarItem(
        icon: Icon(controller.navInderx.value == 3 ? simpleIcons[3] : outlinedIcons[3]),
        label: settings,
      ),
    ];
    return Scaffold(
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        onTap: (index) {
          setState(() {
            controller.navInderx.value = index;
          });
        },
        currentIndex: controller.navInderx.value,
        items: bottomNavbar,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: purpleColor,
        unselectedItemColor: darkGrey,
      )),
      body: Obx(() => Column(
        children: [
          Expanded(child: navScreens[controller.navInderx.value]),
        ],
      )),
    );
  }
}

