import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/widgets/customfield.dart';
import 'package:get/get.dart';
import '../../controllers/profile_controller.dart';
import '../widgets/normal_text.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<ProfileController>();
    return  Obx(()=>Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: editprofil,size: 16.0),
          actions: [
            controller.isloading.value?const Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(white),))
                : TextButton(onPressed: ()async{
                  controller.isloading(true);
              await controller.updateShop(
                shopaddress: controller.shopAddressController.text,
                shopmobile: controller.shopMobileController.text,
                shopdesc:  controller.shopDescController.text,
                shopname:  controller.shopNameController.text,
                shopwebsite: controller.shopWebsiteController.text,
              );
              VxToast.show(context, msg: 'Shop Updated');
            }, child: const Text('Save',style: TextStyle(color: Colors.white),))
          ],
        ),
        body: Padding(padding: const EdgeInsets.all(8)
        ,child: Column(
            children: [
              10.heightBox,
              customTextField(label: shopname,hint: nameHint,controller:controller.shopNameController),
              10.heightBox,
              customTextField(label: adress,hint: shopAdressHint,controller:controller.shopAddressController),
              10.heightBox,
              customTextField(label: mobile,hint: shopMobileHint,controller:controller.shopMobileController),
              10.heightBox,
              customTextField(label: website,hint: shopWebsiteHint,controller:controller.shopWebsiteController),
              10.heightBox,
              customTextField(label: desc,hint: shopDescHint,isDesc: true,controller:controller.shopDescController)

            ],
          ),
        ),
      ),
    );
  }
}
