import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/orders_controller.dart';
import 'package:emart_seller/views/widgets/our_button.dart';
import 'package:get/get.dart';
import '../widgets/normal_text.dart';
import 'components/order_place.dart';
import 'package:intl/intl.dart' as intl;
class OrderDetails extends StatefulWidget {
  final dynamic data;
  const OrderDetails({super.key, this.data});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var controller=Get.find<OrdersController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getOrders(widget.data);
    controller.confirmed.value=widget.data['order_confirmed'];
    controller.ondelivery.value=widget.data['order_on_delivery'];
    controller.delivered.value=widget.data['order_delivered'];
  }
  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
        appBar: AppBar(
          title:boldText(text: "Order Details",size: 16.0,color: fontGrey),
        ),
        bottomNavigationBar: Visibility(
          visible: controller.confirmed.value,
          child: SizedBox(
            height: 60,
            width: context.screenWidth,
            child: ourButton(color: green,onPress: (){
              controller.confirmed(true);
              controller.changeStatus(title: 'order_confirmed',status: true,docId: widget.data.id);
            },title: 'Confirm Order'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Visibility(
                  visible: controller.confirmed.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldText(text: "Order Status:",size: 16.0,color: purpleColor),
                      SwitchListTile(activeColor:green,value: true,
                        onChanged: (value){},title: const Text('Placed')),
                      SwitchListTile(activeColor:green,value: controller.confirmed.value,
                        onChanged: (value){
                        controller.confirmed.value=value;
                        },title: const Text('Confirmed')),
                      SwitchListTile(activeColor:green,value: controller.ondelivery.value,
                        onChanged: (value){
                          controller.ondelivery.value=value;
                          controller.changeStatus(title: 'order_on_delivery',status: value,docId: widget.data.id);
                        },title: const Text('OnDeliver')),
                      SwitchListTile(activeColor:green,value: controller.delivered.value,
                        onChanged: (value){
                          controller.delivered.value=value;
                          controller.changeStatus(title: 'order_delivered',status: value,docId: widget.data.id);
                        },title: const Text('Delivery')),
                    ],
                  ).box.padding(const EdgeInsets.all(8)).border(color: lightGrey).roundedSM.outerShadowSm.make(),
                ),
                Column(
                  children: [
                    orderPlaceDetails(d1: "${widget.data['order_code']}"
                        ,d2: "${widget.data['shipping_method']}"
                        ,title1: 'Order Code'
                        ,title2: 'Shipping Method'),
                   orderPlaceDetails(
                     d1: intl.DateFormat().add_yMd().format((widget.data['order_date'].toDate()))
                        ,d2: "${widget.data['payment_method']}",title1: 'Order Date',title2: 'Payment Method'),
                    orderPlaceDetails(d1: 'Unpaid',d2:'Order Placed',title1: 'Payment Status',title2: 'Delivery Status'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              'Shipping Adress'.text.semiBold.make(),
                              boldText(text: "Shipping Address",size: 16.0,color: purpleColor),
                              "${widget.data['order_by_name']}".text.make(),
                              "${widget.data['order_by_email']}".text.make(),
                              "${widget.data['order_by_address']}".text.make(),
                              "${widget.data['order_by_city']}".text.make(),
                              "${widget.data['order_by_state']}".text.make(),
                              "${widget.data['order_by_postal']}".text.make(),
                            ],
                          ),
                          SizedBox(
                            width: context.screenWidth*0.2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                boldText(text: "Total Amount",size: 14.0,color: purpleColor),
                                boldText(text: "${widget.data['total_amount']}",size: 16.0,color: red),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ).box.outerShadowMd.white.make(),
                10.heightBox,
                boldText(text: "Ordered Products",size: 16.0,color: fontGrey),
                10.heightBox,
                ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(controller.orders.length, (index){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          orderPlaceDetails(
                              title1:"${controller.orders[index]['title']}",
                              title2:"${controller.orders[index]['p_price']}",
                              d1: "${controller.orders[index]['qty']}x",
                              d2: 'Refundable'
                          ),
                          Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              width: 30,
                              height: 20,
                              color:Color(controller.orders[index]['color'])
                            ),)
                        ],
                      );
                    }).toList()
                ).box.outerShadowMd.white.padding(const EdgeInsets.only(bottom: 5)).make(),
                20.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
