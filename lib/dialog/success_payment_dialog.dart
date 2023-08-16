import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/viewModel/fees_viewmodel.dart';

AwesomeDialog successPaymentDialog(BuildContext context) {
  return AwesomeDialog(
    context: context,
    autoDismiss: false,
    animType: AnimType.SCALE,
    dialogType: DialogType.SUCCES,
    body: Center(
      child: Text(
        'Payment successfully done',
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
    ),
    onDissmissCallback: (DismissType type) {
      if (type == DismissType.BTN_OK) {
        Get.back();
      }
    },
    btnOkOnPress: () {
      FeesViewModel viewModel = Get.find(tag: FeesViewModel().toString());
      viewModel.getPaymentList();
      Get.back();
    },
  )..show();
}
