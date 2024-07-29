import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/firebase_consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../const/const.dart';
import 'dart:io';
import 'package:path/path.dart';

class ProfileController extends GetxController{
  late QueryDocumentSnapshot snapshotData;
  var profileImgPAth=''.obs;
  var profileImgUrl='';
  var isloading=false.obs;

  var nameController=TextEditingController();
  var oldpasswordController=TextEditingController();
  var newpasswordController=TextEditingController();

  // shop controllers
  var shopNameController=TextEditingController();
  var shopAddressController=TextEditingController();
  var shopMobileController=TextEditingController();
  var shopWebsiteController=TextEditingController();
  var shopDescController=TextEditingController();

  changeImage(context)async{
    try{
      final img=await ImagePicker().pickImage(source: ImageSource.gallery);
      if(img == null) return;
      profileImgPAth.value=img.path;
    }catch(e){
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadProfileImage()async{
    var filename=basename(profileImgPAth.value);
    var destination='images/vendors/${currentUser!.uid}/$filename';
    Reference ref=FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgPAth.value));
    profileImgUrl=await ref.getDownloadURL();
    isloading(false);
  }
  updateProfile({name,password,imgUrl})async{
    var store=firestore.collection(vendorsCollection).doc(currentUser!.uid);
    await store.set({
      'name':name,
      'password':password,
      'imageUrl':imgUrl
    },SetOptions(merge: true));
    isloading(false);
  }
  updateImage({imgUrl})async{
    var store=firestore.collection(vendorsCollection).doc(currentUser!.uid);
    await store.set({
      'imageUrl':imgUrl
    },SetOptions(merge: true));
  }
  changeAuthpassword({email,password,newpassword})async{
    final cred=EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(cred).then((value){
      currentUser!.updatePassword(newpassword);
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  updateShop({shopname,shopaddress,shopmobile,shopwebsite,shopdesc})async{
    var store=firestore.collection(vendorsCollection).doc(currentUser!.uid);
    await store.set({
      'shop_name':shopname,
      'shop_address':shopaddress,
      'shop_mobile':shopmobile,
      'shop_website':shopwebsite,
      'shop_desc':shopdesc
    },SetOptions(merge: true));
    isloading(false);
  }
}