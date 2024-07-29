import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../const/firebase_consts.dart';
import 'home_controller.dart';

class ChatsController extends GetxController{
  @override
  void onInit() {
    super.onInit();
    getChatId();
  }

  var chats = FirebaseFirestore.instance.collection(chatsCollection);
  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];
  var senderName = Get.find<HomeController>().username;
  var currentId = currentUser!.uid;
  var msgController = TextEditingController();
  var isLoading = false.obs;
  dynamic chatDocId;

  getChatId() async {
    isLoading(true);
    await chats.where('users',
        isEqualTo: {friendId: null, currentId: null}).limit(1).get().then((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        chatDocId = snapshot.docs.single.id;
      } else {
        chats.add({
          'created_on': null,
          'last_msg': '',
          'users': {friendId: null, currentId: null},
          'toId': '',
          'fromId': '',
          'friendname': friendName,
          'sendername': senderName
        }).then((value){
          chatDocId=value.id;
        });
      }
    });
    isLoading(false);
  }

  sendMsg(String msg) async {
    if (msg.trim().isNotEmpty) {
      var messageData = {
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentId
      };
      await chats.doc(chatDocId).collection(messagesCollection).add(messageData);
      await chats.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId':currentId,
        'fromId':friendId

      });
    }
  }
}
