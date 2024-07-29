import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/products_screen/product_details.dart';
import 'package:emart_seller/views/widgets/appbar_widget.dart';
import 'package:emart_seller/views/widgets/dashboard_button.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../widgets/normal_text.dart';
import 'package:intl/intl.dart' as intl;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(dashboard),
      body: StreamBuilder(
          stream: StoreServices.getProducts(currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(purpleColor),
                ),
              );
            } else {
              var data = snapshot.data!.docs;
              data = data.sortedBy((a, b) => b['p_wishlist'].length.compareTo(a['p_wishlist'].length));
              return Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          dashboardButton(context, title: products, count: data.length, icon: icProducts),
                          dashboardButton(context, title: rating, count: '50', icon: icOrders)
                        ],
                      ),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          dashboardButton(context, title: orders, count: '60', icon: icStar),
                          dashboardButton(context, title: totalsale, count: '50', icon: icOrders)
                        ],
                      ),
                      10.heightBox,
                      const Divider(),
                      10.heightBox,
                      normalText(text: popular, size: 18.0, color: darkGrey),
                      20.heightBox,
                      ListView(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                            data.length,
                                (index) => data.isEmpty
                                ? const SizedBox()
                                : ListTile(
                              onTap: () {
                                Get.to(ProductDetails(data: data[index], title: data[index]['p_name']));
                              },
                              leading: Image.network(data[index]['p_imgs'][0], width: 100, height: 100, fit: BoxFit.cover),
                              title: normalText(text: data[index]['p_name'], size: 18.0, color: fontGrey),
                              subtitle: normalText(text: "\$${data[index]['p_price']}", size: 18.0, color: darkGrey),
                            )
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          }
      )
    );
  }
}
