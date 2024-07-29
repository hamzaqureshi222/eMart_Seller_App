import 'package:emart_seller/const/const.dart';
import 'normal_text.dart';

Widget dashboardButton(context,{title,count,icon}){
  var size=MediaQuery.of(context).size;
  return Row(
    children: [
      Expanded(child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        mainAxisAlignment:MainAxisAlignment.spaceAround,
        children: [
          boldText(text: title,size: 16.0),
          boldText(text: count,size: 16.0)
        ],
      )),
      Image.asset(icon,width: size.width*0.1,color: Colors.white)
    ],
  ).box.color(purpleColor).rounded.size(size.width*0.4,size.height*0.085)
      .padding(const EdgeInsets.all(8)).make();

}