import 'package:flutter/cupertino.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:toast/toast.dart';

class ShowToast {
  ShowToast.info(String text, BuildContext context) {
    Toast.show(text, context,
        backgroundColor: MyColors.mainBlue,
        textColor: MyColors.white,
        duration: 2,
        gravity: Toast.TOP);
  }

  ShowToast.error(String text, BuildContext context) {
    Toast.show(text, context,
        backgroundColor: MyColors.error,
        textColor: MyColors.white,
        duration: 2,
        gravity: Toast.TOP);
  }
}
