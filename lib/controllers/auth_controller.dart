import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/controllers/profile_controller.dart';
import 'package:emart_seller/views/auth_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../const/const.dart';

class AuthController extends GetxController {
  var isloading = false.obs;

  Future<UserCredential?> loginMethod({context, email, password}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  storeUserData({name, password, email}) async {
    DocumentReference store = firestore.collection(vendorsCollection).doc(currentUser!.uid);
    store.set({'name': name, 'password': password, 'email': email, 'imageUrl': '', 'id': currentUser!.uid});
  }

  signOutMethod() async {
      await auth.signOut();
      Get.offAll(() => const LoginScreen());
  }
}
