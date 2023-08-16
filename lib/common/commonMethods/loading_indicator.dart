/// KEY : circleIndicator
/// Desc. : Add Full Screen Circle Indicator And Only Circle Indicator
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

Container postDataLoadingIndicator({Color? color}) {
  return Container(
      height: Get.height,
      width: Get.width,
      color: color ?? ColorUtils.black26,
      child: getDataLoadingIndicator());
}

Widget getDataLoadingIndicator() {
  // ignore: prefer_const_constructors
  return Center(
    child: const CircularProgressIndicator(
      // ignore: prefer_const_constructors
      valueColor: AlwaysStoppedAnimation<Color>(ColorUtils.blue),
    ),
  );
}


Widget getDataErrorMsg() {
  return const Center(
    child: Text(VariableUtils.somethingWantWrong),
  );
}


Widget getNotApplicableMsg({String? msg}) {
  return Center(
    child: Text(msg ?? VariableUtils.notApplicable),
  );
}
Widget getFieldIsEmptyMsg() {
  return const Center(
    child: Text(VariableUtils.fieldIsEmpty),
  );
}

Widget emptyMsg() {
  return const Center(
    child: Text(VariableUtils.dataNotFound),
  );
}
