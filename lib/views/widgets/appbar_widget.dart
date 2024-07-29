import 'package:emart_seller/const/const.dart';
import 'package:intl/intl.dart' as intl;
import 'normal_text.dart';

AppBar appbarWidget(title){
  return  AppBar(
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    title: boldText(text: title,color: fontGrey,size: 17.0),
    actions: [
      normalText(text: intl.DateFormat('EEE,MMM d,''y').format(DateTime.now()),color: purpleColor,size: 14.0),
      15.widthBox
    ],
  );
}