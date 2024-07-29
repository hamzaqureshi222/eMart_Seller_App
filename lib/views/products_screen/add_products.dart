import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/products_controller.dart';
import 'package:emart_seller/views/products_screen/components/product_dropdown.dart';
import 'package:emart_seller/views/products_screen/components/product_images.dart';
import 'package:emart_seller/views/widgets/customfield.dart';
import 'package:get/get.dart';
import '../widgets/normal_text.dart';
class AddProduct extends StatelessWidget {
  const AddProduct({super.key});
  @override
  Widget build(BuildContext context) {
    var controller=Get.find<ProductsController>();
    return  Obx(()=>Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          leading: IconButton(onPressed: (){Get.back();}, icon: const Icon(Icons.arrow_back,color: white)),
          title:boldText(text: "Add Product",color: white,size: 16.0),
          actions: [
            controller.isloading.value
                ?const Center(child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(white)))
          :TextButton(onPressed: ()async{
            controller.isloading(true);
            await controller.uploadImages();
            await  controller.uploadProduct(context);
              Get.back();
            }, child: boldText(text: 'Save',size: 16.0,color: white))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField(hint: "Add Product Name",label: 'Product Name',controller: controller.pnameController),
                10.heightBox,
                customTextField(hint: "Add Description",label: 'Product Description',isDesc: true,controller: controller.pdescController),
                10.heightBox,
                customTextField(hint: "Add Price",label: 'Price',controller: controller.ppriceController),
                10.heightBox,
                customTextField(hint: "Add Quantity",label: 'Quantity',controller: controller.pquantityController),
                10.heightBox,
                productDropdown("Category",controller.categoryList,controller.categoryvalue,controller),
                10.heightBox,
                productDropdown("Subcategory",controller.subcategoryList,controller.subcategoryvalue,controller),
                10.heightBox,
                boldText(text: "Choose Product Images",size: 15.0,color: lightGrey),
                const Divider(color: white),
                10.heightBox,
                Obx(()=>Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:List.generate(3, (index) =>
                          controller.pImagesList[index]!=null
                              ?Image.file(controller.pImagesList[index],width: context.screenWidth*0.3).onTap(() {
                                 controller.pickImages(index);
                          })
                              :productImages(label: "${index+1}").onTap(() {
                         controller.pickImages(index);
                      })
                      )
                    ),
                ),
                10.heightBox,
                boldText(text: "First Image will be your display Image",size: 15.0,color: lightGrey),
                const Divider(color: white),
                10.heightBox,
                Obx(()=>Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(9, (index) => Stack(
                      alignment: Alignment.center,
                      children:[ VxBox().color(Vx.randomPrimaryColor)
                          .roundedFull.size(50, 50).make().onTap(() {
                            controller.selectedColorIndex.value=index;
                      }),
                        controller.selectedColorIndex.value==index?
                        const Icon(Icons.done,color: white):const SizedBox()
                      ]
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
