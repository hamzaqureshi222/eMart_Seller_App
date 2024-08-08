import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:get/get.dart';
import '../../controllers/chat_controller.dart';
import 'chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkFontGrey),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          controller.friendName,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: darkFontGrey),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(color: darkGrey));
        }
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: StoreServices.getMessages(
                      controller.chatDocId.toString()),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.data!.docs.isEmpty) {
                      return const Center(
                          child: Text('No messages yet',
                              style: TextStyle(color: darkFontGrey)));
                    } else {
                      var data = snapshot.data!.docs;
                      return ListView.builder(
                        reverse: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var message = data[data.length - 1 - index];
                          return Align(
                            alignment: message['uid'] == currentUser!.uid
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: chatBubble(message),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.msgController,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        hintText: 'Type a message',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: textfieldGrey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: textfieldGrey),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.sendMsg(controller.msgController.text);
                      controller.msgController.clear();
                    },
                    icon: const Icon(Icons.send, color: Colors.white),
                  )
                      .box
                      .color(Colors.black45)
                      .roundedFull
                      .margin(const EdgeInsets.only(left: 5))
                      .make(),
                ],
              )
                  .box
                  .height(70)
                  .padding(const EdgeInsets.all(12))
                  .margin(const EdgeInsets.only(bottom: 2))
                  .make(),
            ],
          ),
        );
      }),
    );
  }
}
