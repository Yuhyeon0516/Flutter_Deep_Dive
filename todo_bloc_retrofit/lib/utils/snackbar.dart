import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_bloc_retrofit/helper/color_helper.dart';
import 'package:todo_bloc_retrofit/helper/font_helper.dart';

void toastMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: ColorHelper.primaryColor,
    textColor: ColorHelper.whiteColor,
    fontSize: FontHelper.font_16,
  );
}
