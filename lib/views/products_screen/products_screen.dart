import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/products_controller.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/products_screen/add_products.dart';
import 'package:emart_seller/views/products_screen/product_details.dart';
import 'package:emart_seller/views/widgets/appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import '../widgets/normal_text.dart';
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(ProductsController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: ()async{
        await controller.getCategories();
        controller.populateCategoryList();
        Get.to( const AddProduct());
      },
        backgroundColor: purpleColor,
          child: const Icon(Icons.add,color: Colors.white,)),
      appBar: appbarWidget(products),
      body: StreamBuilder(
          stream: StoreServices.getProducts(currentUser!.uid),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
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
                    children: List.generate(data.length, (index) => ListTile(
                        onTap: (){
                          Get.to( ProductDetails(title: "${data[index]['p_name']}",data: data[index],));
                        },
                        leading: Image.network(data[index]['p_imgs'][0],width: 100,height: 100,fit: BoxFit.cover),
                        title: normalText(text: "${data[index]['p_name']}",size: 18.0,color: fontGrey),
                        subtitle: Row(
                          children: [
                            normalText(text: "\$${data[index]['p_price']}",size: 18.0,color: darkGrey),
                            10.widthBox,
                            normalText(text:data[index]['is_featured']==true?"Featured":'',size: 13.0,color: green),
                          ],
                        ),
                        trailing: PopupMenuButton(child: const Icon(CupertinoIcons.ellipsis_vertical),
                            itemBuilder: (context)=>[
                              PopupMenuItem(child: Row(children:[ Icon(Icons.featured_play_list,
                                color: data[index]['featured_id']==currentUser!.uid?Colors.green:darkGrey,),7.widthBox,
                                Text(data[index]['featured_id']==currentUser!.uid?removeF:featured,style:TextStyle(
                                color: data[index]['featured_id']==currentUser!.uid?Colors.green:darkGrey
                              ),)]),
                                onTap: (){
                                if(data[index]['is_featured']==true ){
                                  controller.removeFeature(data[index].id);
                                  VxToast.show(context, msg: "Removed");
                                }else{
                                  controller.addFeature(data[index].id);
                                  VxToast.show(context, msg: "Added");
                                }
                                }),
                              PopupMenuItem(child: Row(children:[const Icon(Icons.edit),7.widthBox,const Text(edit)]),
                                  onTap: (){}),
                              PopupMenuItem(child: Row(children:[const Icon(Icons.delete),7.widthBox,const Text(remove)]),
                                  onTap: (){controller.deleteProduct(data[index].id);
                                  VxToast.show(context, msg: "Product Deleted");
                              })
                            ]
                        )),
                    ),
                  ),
                ),
              );
            }
          })
    );
  }
}