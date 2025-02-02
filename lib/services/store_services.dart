import 'package:emart_seller/const/const.dart';

class StoreServices{
  static getProfile(uid){
    return firestore.collection(vendorsCollection).where('id',isEqualTo: uid).get();
  }

  static getMessages(docId){
    return firestore.collection(chatsCollection).doc(docId)
        .collection(messagesCollection).orderBy('created_on',descending: false).snapshots();
  }
  static getOrders(uid){
    return firestore.collection(ordersCollection).where('Vendors',arrayContains: uid).snapshots();
  }
   static getProducts(uid){
    return firestore.collection(productsCollection).where('vendor_id',isEqualTo: uid).snapshots();
   }
  static getAllMessages(){
    return firestore.collection(chatsCollection).where('toId',isEqualTo:currentUser!.uid).snapshots();
  }
}