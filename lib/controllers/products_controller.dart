import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/controllers/home_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductsController extends GetxController{
var isloading=false.obs;
  var pnameController=TextEditingController();
  var pdescController=TextEditingController();
  var ppriceController=TextEditingController();
  var pquantityController=TextEditingController();

  var categoryList=<String>[].obs;
  var subcategoryList=<String>[].obs;

  List<Category> category =[];
  var pImagesLink=[];
  var pImagesList=RxList<dynamic>.generate(3, (index) => null);

  var categoryvalue=''.obs;
  var subcategoryvalue=''.obs;
  var selectedColorIndex=0.obs;

  getCategories()async{
    var data=await rootBundle.loadString("lib/services/category_model.json");
    var cat=categoryModelFromJson(data);
    category=cat.categories;
}
populateCategoryList(){
  categoryList.clear();
  for (var item in category){
    categoryList.add(item.name);
  }
}

  populateSubCategoryList(cat){
    subcategoryList.clear();
    var data=category.where((element) => element.name ==cat).toList();
    for(var i=0;i<data.first.subcategory.length;i++){
      subcategoryList.add(data.first.subcategory[i]);
    }
  }
  pickImages(index)async{
    try {
      final img = await ImagePicker().pickImage(
          source: ImageSource.gallery, imageQuality: 80);
      if (img == null) return;
      pImagesList[index] = File(img.path);
    }
    catch(e){
      // VxToast.show(context, msg: e.toString());
      print(e.toString());

    }
  }

  uploadImages()async{
    pImagesLink.clear();
    for(var item in pImagesList){
      if(item!=null){
        var filename=basename(item.path);
        var destination='images/vendors/${currentUser!.uid}/$filename';
        Reference ref=FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var n= await ref.getDownloadURL();
        pImagesLink.add(n);
      }
    }
    // isloading(false);
  }
  uploadProduct(context)async{
    try{
      await uploadImages();
      var store=firestore.collection(productsCollection).doc();
         store.set({
        'is_featured':false,
        'p_category':categoryvalue.value,
        'p_subcategory':subcategoryvalue.value,
        'p_colors':FieldValue.arrayUnion([Colors.red.value,Colors.black.value]),
        'p_imgs':FieldValue.arrayUnion(pImagesLink),
        'p_wishlist':FieldValue.arrayUnion([]),
        'p_desc':pdescController.text,
        'p_name':pnameController.text,
        'p_price':ppriceController.text,
        'p_quantity':pquantityController.text,
        'p_seller':await Get.find<HomeController>().getUsername(),
        'p_rating':"5.0",
        'vendor_id':currentUser != null ? currentUser!.uid : 'Unknown',
        'featured_id':''
      });
      print('Product data successfully set in Firestore');
      isloading(false);
    }catch(e){
      print('error...........: $e');
    }
    VxToast.show(context, msg: 'Product uploaded');
  }

  addFeature(docId)async{
    await firestore.collection(productsCollection).doc(docId).set({
      'featured_id':currentUser!.uid,
      'is_featured':true
    },SetOptions(merge: true));
  }

removeFeature(docId)async{
  await firestore.collection(productsCollection).doc(docId).set({
    'featured_id':'',
    'is_featured':false
  },SetOptions(merge: true));
}
deleteProduct(docId)async{
    await firestore.collection(productsCollection).doc(docId).delete();
}
}