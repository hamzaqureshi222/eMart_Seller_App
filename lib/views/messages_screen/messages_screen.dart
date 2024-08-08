import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/messages_screen/chat_screen.dart';
import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';
import '../widgets/normal_text.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: boldText(text: messages, size: 16.0, color: fontGrey),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: StoreServices.getAllMessages(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(purpleColor)),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return 'No Messages yet'.text.color(purpleColor).makeCentered();
              } else {
                var data = snapshot.data!.docs;
                return Column(
                  children: List.generate(data.length, (index) {
                    var docData = data[index].data() as Map<String, dynamic>;
                    var createdOn = docData['created_on'] as Timestamp?;
                    var time = createdOn != null
                        ? intl.DateFormat("h:mma").format(createdOn.toDate())
                        : 'N/A';
                    return ListTile(
                      onTap: () {
                        Get.to(
                              () => const ChatScreen(),
                          arguments: [data[index]['sendername'], data[index]['fromId']],
                        );
                      },
                      leading: const CircleAvatar(
                        backgroundColor: purpleColor,
                        child: Icon(Icons.person, color: white),
                      ),
                      title: boldText(
                          text: '${docData['sendername']}', size: 16.0, color: fontGrey),
                      subtitle: normalText(
                          text: '${docData['last_msg']}', size: 13.0, color: darkGrey),
                      trailing: time.text.make(),
                    );
                  }),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
