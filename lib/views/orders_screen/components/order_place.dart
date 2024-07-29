import 'package:emart_seller/const/colors.dart';
import 'package:emart_seller/views/widgets/normal_text.dart';
import 'package:flutter/cupertino.dart';

Widget orderPlaceDetails({title1,title2,d1,d2}){
  return  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween ,
      children: [
        Column(
          children: [
            boldText(text: '$title1',color: purpleColor,size: 18.0),
            boldText(text: '$d1',color: red,size: 18.0)
            // '$title1'.text.semiBold.make(),
            // '$d1'.text.color(redColor).semiBold.make()
          ],
        ),
        Column(
          children: [
            boldText(text: '$title2',color: purpleColor,size: 18.0),
            boldText(text: '$d2',color: red,size: 18.0)
            // '$title2'.text.semiBold.make(),
            // '$d2'.text.color(redColor).semiBold.make()
          ],
        ),
      ],
    ),
  );
}