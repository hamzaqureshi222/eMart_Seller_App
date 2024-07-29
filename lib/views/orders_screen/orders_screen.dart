import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/orders_screen/order_detail.dart';
import 'package:emart_seller/views/widgets/appbar_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import '../../controllers/orders_controller.dart';
import '../widgets/normal_text.dart';
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(OrdersController());
    return Scaffold(
      appBar: appbarWidget(orders),
      body: StreamBuilder(
          stream: StoreServices.getOrders(currentUser!.uid),
          builder: (BuildContext context,AsyncSnapshot snapshot){
            if(!snapshot.hasData){
              return const Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(purpleColor)));
            }else{
              var data=snapshot.data!.docs;
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: List.generate(data.length,
                            (index){
                      var time=data[index]['order_date'].toDate();
                      return ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        onTap: (){
                          Get.to( OrderDetails(data: data[index]));
                        },
                        tileColor: textfieldGrey,
                        title: normalText(text: "${data[index]['order_code']}",size: 15.0,color: fontGrey),
                        subtitle:Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.calendar_month),
                                10.widthBox,
                                normalText(text: intl.DateFormat().add_yMd().format(time),size: 12.0,color: fontGrey)
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.payment),
                                10.widthBox,
                                normalText(text: unpaid,size: 12.0,color: red)
                              ],
                            )
                          ],
                        ),
                        trailing: boldText(text:  "\$ ${data[index]['total_amount']}",size: 14.0,color: purpleColor),
                      ).box.margin(const EdgeInsets.only(bottom: 5)).make();
                            }
                    ),
                  ),
                ),
              );
          }
          })
    );
  }
}
