import 'package:emart_seller/controllers/profile_controller.dart';
import 'package:emart_seller/views/widgets/customfield.dart';
import 'package:emart_seller/const/const.dart';
import 'package:get/get.dart';
import '../widgets/normal_text.dart';
import 'dart:io';

class EditSettingsScreen extends StatefulWidget {
  final String?username;
  const EditSettingsScreen({super.key, this.username});

  @override
  State<EditSettingsScreen> createState() => _EditSettingsScreenState();
}

class _EditSettingsScreenState extends State<EditSettingsScreen> {
  var controller=Get.find<ProfileController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.nameController.text = widget.username ?? '';
  }
  @override
  Widget build(BuildContext context) {
    return  Obx(()=>Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        appBar: AppBar(
          leading: IconButton(onPressed: (){Get.back();}, icon: const Icon(Icons.arrow_back,color: Colors.white),),
          title: boldText(text: editprofil,size: 15.0),
          actions: [
            controller.isloading.value?const Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(white),))
                :TextButton(onPressed: ()async{
              controller.isloading(true);
              if(controller.profileImgPAth.value.isNotEmpty){
                await controller.uploadProfileImage();
                controller.updateImage(imgUrl: controller.profileImgUrl);
              }else{
                controller.profileImgUrl=controller.snapshotData['imageUrl'];
              }

              if(controller.snapshotData['password']==controller.oldpasswordController.text){
                await  controller.changeAuthpassword(
                    email: controller.snapshotData['email'],
                    password: controller.oldpasswordController.text,
                    newpassword: controller.newpasswordController.text);
                await controller.updateProfile(
                  imgUrl: controller.profileImgUrl,
                  name: controller.nameController.text,
                  password: controller.newpasswordController.text);
                VxToast.show(context, msg: 'Updated');
              }else if (controller.oldpasswordController.text.isEmptyOrNull &&
                  controller.newpasswordController.text.isEmptyOrNull){
                await controller.updateProfile(
                  imgUrl: controller.profileImgUrl,
                  name: controller.nameController.text,
                  password: controller.snapshotData['password']);
                VxToast.show(context, msg: 'Updated');
              }else{
                VxToast.show(context, msg: 'Error Occured');
                controller.isloading(false);
              }
            }, child: const Text('Save',style: TextStyle(color: Colors.white),))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
              children: [
                // Image.asset(imgProduct,width: context.screenWidth*0.4).box.roundedFull.clip(Clip.antiAlias).make(),
                controller.snapshotData['imageUrl']=='' && controller.profileImgPAth.isEmpty
                    ?Image.asset(imgProduct,width: context.screenHeight*0.2,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
                // if data is not
                    :controller.snapshotData['imageUrl']!='' && controller.profileImgUrl.isEmpty?
                Image.network(controller.snapshotData['imageUrl'],width: context.screenHeight*0.1,fit: BoxFit.fill,).box.roundedFull.clip(Clip.antiAlias).make()
                    :Image.file(File(controller.profileImgPAth.value),width: context.screenHeight*0.150,fit: BoxFit.fill,).box.roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,
                ElevatedButton(onPressed: (){
                  controller.changeImage(context);
                },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                    ),
                    child: normalText(text: 'Change Image',color: fontGrey,size: 13.0)),
                10.heightBox,
                const Divider(),
                10.heightBox,
                customTextField(label: name,hint: 'Enter Name',controller: controller.nameController),
                20.heightBox,
                Align(
                    alignment: Alignment.centerLeft,
                    child: boldText(text: 'Change your password',size: 16.0)),
                10.heightBox,
                customTextField(label: password,hint: passwordHint,controller: controller.oldpasswordController),
                10.heightBox,
                customTextField(label: cnfrmpaas,hint: passwordHint,controller: controller.newpasswordController),

              ],
            ),
        ),
      ),
    );
  }
}
