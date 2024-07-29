import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/auth_controller.dart';
import 'package:emart_seller/controllers/profile_controller.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/auth_screen/login_screen.dart';
import 'package:emart_seller/views/messages_screen/messages_screen.dart';
import 'package:emart_seller/views/settings_screen/edit_settingsscreen.dart';
import 'package:emart_seller/views/widgets/normal_text.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    AuthController authController=Get.put(AuthController());

    // Define the icons and titles for the profile buttons
    final List<IconData> profileButtonsIcons = [
      Icons.settings,
      Icons.message,
    ];
    final List<String> profileButtonsTitle = [
      'Edit Settings',
      'Messages',
    ];

    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: boldText(text: profile, size: 16.0),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(EditSettingsScreen(username: controller.snapshotData['name']));
            },
            icon: const Icon(Icons.edit, color: Colors.white),
          ),
          TextButton(
            onPressed: () async {
              await Get.find<AuthController>().signOutMethod();
            },
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: FutureBuilder(
        future: StoreServices.getProfile(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(white),
              ),
            );
          } else {
            controller.snapshotData = snapshot.data!.docs[0];
            return Column(
              children: [
                ListTile(
                  leading: controller.snapshotData['imageUrl'] == ''
                      ? Image.asset(
                    imgProduct,
                    width: context.screenHeight * 0.1,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.network(
                    controller.snapshotData['imageUrl'],
                    width: context.screenHeight * 0.045,
                  ).box.roundedFull.clip(Clip.antiAlias).make(),
                  title: boldText(text: "${controller.snapshotData['name']}", size: 15.0),
                  subtitle: normalText(text: "${controller.snapshotData['email']}", size: 14.0),
                ),
                const Divider(),
                20.heightBox,
                Column(
                  children: List.generate(profileButtonsIcons.length, (index) => ListTile(
                    onTap: () {
                      switch (index) {
                        case 0:
                          Get.to(const EditSettingsScreen());
                          break;
                        case 1:
                          Get.to(const MessagesScreen());
                          break;
                      }
                    },
                    leading: Icon(profileButtonsIcons[index], color: Colors.white),
                    title: normalText(text: profileButtonsTitle[index], size: 15.0),
                  )),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
