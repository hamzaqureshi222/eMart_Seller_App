import 'package:emart_seller/const/const.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUsername();
  }
  var navInderx=0.obs;
  var username='';

   getUsername()async{
     var n=await firestore.collection(vendorsCollection).where('id',isEqualTo:currentUser!.uid).get().then((value){
       if(value.docs.isNotEmpty){
         return value.docs.single['name'];
       }else {
         return null; // Return null if the document is not found
       }
     });
     username=n;
     if (kDebugMode) {
       print(username);
     }
   }
}