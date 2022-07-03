import 'package:fluttertoast/fluttertoast.dart';
import 'package:github_stars/theme.dart';

class Toast {
  Toast._internal();

  static void show(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: primaryColor,
      fontSize: 12.0,
    );
  }
}
