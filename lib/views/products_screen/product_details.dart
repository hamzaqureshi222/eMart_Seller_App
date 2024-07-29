import 'package:emart_seller/const/const.dart';

import '../widgets/normal_text.dart';
class ProductDetails extends StatelessWidget {
  final String title;
  final dynamic data;
  const ProductDetails({super.key, required this.title, this.data});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: boldText(text: title,color: fontGrey,size: 16.0),
      ),
      body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VxSwiper.builder(
                height: 350,
                aspectRatio: 16/9,
                viewportFraction: 1.0,
                enlargeCenterPage: true,
                itemCount: data['p_imgs'].length,
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(data['p_imgs'][index],width: context.screenWidth,fit: BoxFit.cover);
                },
              ),
              10.heightBox,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    boldText(text: title!,color: fontGrey,size: 16.0),
                    10.heightBox,
                    Row(
                      children: [
                        boldText(text: "${data['p_category']}",color: fontGrey,size: 16.0),
                        10.widthBox,
                        boldText(text: "${data['p_subcategory']}",color: fontGrey,size: 16.0),
                      ],
                    ),
                    10.heightBox,
                    VxRating(
                      // value: double.parse(data['p_rating']),
                      value: 3.0,
                      isSelectable: false,
                      onRatingUpdate: (value){},normalColor: textfieldGrey,
                      selectionColor: golden,size: 25,maxRating: 5,),
                    10.heightBox,
                    boldText(text:"${data['p_price']}",size: 18.0,color: red),
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: "Color".text.color(fontGrey).make(),
                        ),
                        Row(
                            children: List.generate(3, (index) =>VxBox().size(40, 40)
                                    .roundedFull.margin(const EdgeInsets.symmetric(horizontal: 6))
                                    .color(Vx.randomPrimaryColor).make().onTap(() {
                                }),
                                )
                        )
                      ],
                    ).box.padding(const EdgeInsets.all(8)).make(),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: "Quantity".text.color(fontGrey).make(),
                        ),
                        normalText(text: "${data['p_quantity']}",color: fontGrey,size: 16.0)
                      ],
                    )
                  ],
                ).box.white.roundedSM.padding(const EdgeInsets.all(8)).make(),
                    20.heightBox,
                    boldText(text: "Description",color: fontGrey,size: 16.0),
                    10.heightBox,
                    normalText(text: "${data['p_desc']}",color: fontGrey,size: 16.0),
                  ]
                ),
              )
            ],
          ),
        ),
    );
  }
}
