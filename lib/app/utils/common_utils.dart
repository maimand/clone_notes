import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommonUtils {
  static void showToast(
    String msg, {
    Toast toastLength = Toast.LENGTH_LONG,
    ToastGravity gravity = ToastGravity.BOTTOM,
    int timeForIos = 3,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: timeForIos,
    );
  }

  static void showLoading() =>
      EasyLoading.show(maskType: EasyLoadingMaskType.black);

  static void closeLoading() => EasyLoading.dismiss();
}
