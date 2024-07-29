import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/widgets/normal_text.dart';

Widget ourButton({title,color=purpleColor,onPress}){
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
        backgroundColor: color,
        padding: const EdgeInsets.all(12)
      ),
      onPressed: onPress, child: boldText(text: title,size: 16.0));
}