import 'package:emart_seller/const/const.dart';

Widget normalText({text,color=white,size=14}){
  return '$text'.text.color(color).size(size).make();
}

Widget boldText({text,color=white,size=14}){
  return '$text'.text.bold.color(color).size(size).make();
}