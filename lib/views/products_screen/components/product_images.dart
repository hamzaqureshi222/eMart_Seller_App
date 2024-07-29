import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/widgets/normal_text.dart';

Widget productImages({required label}){
  return "$label".text.bold.color(fontGrey).size(16.0).makeCentered().box.color(lightGrey)
      .size(100,100).roundedSM.make();
}