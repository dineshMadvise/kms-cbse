import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/shared_preference_utils.dart';

void showPrivacyPolicyDialog() {
  Get.dialog(
      AlertDialog(
        title: Text('MSPEducare'),
        content: Text(
            'MSPEducare collects location data to enable visit tracking even when the app is closed or not in use and it is also used to view visit reports admin portal'),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: ColorUtils.blue,
              ),
              onPressed: () {
                PreferenceManagerUtils.setPrivacyPolicy();
                Get.back();
              },
              child: Text('Agree'))
        ],
      ),
      barrierDismissible: false);
}
