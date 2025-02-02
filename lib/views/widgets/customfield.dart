import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/widgets/normal_text.dart';

Widget customTextField({label,hint,controller,isDesc=false}){
  return TextFormField(
    style: const TextStyle(color: white),
    maxLines: isDesc?4:1,
    controller: controller,
    decoration: InputDecoration(
      label: normalText(text: label,size: 10.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white)
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white)
      ),
          hintText: hint,
      hintStyle: const TextStyle(color: lightGrey)

    ),
  );
}