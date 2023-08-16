import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/route_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

showToast({required String msg, bool success = false}) {
  return Get.showSnackbar(GetSnackBar(
    message: msg,
    backgroundColor: success ? ColorUtils.green : ColorUtils.red,
    duration: const Duration(seconds: 2),
  ));
}
