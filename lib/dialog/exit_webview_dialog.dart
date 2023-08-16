import 'package:flutter/material.dart';
import 'package:get/get.dart';

showExitWebViewDialog() {
  ///showExitDialog

  return Get.dialog(AlertDialog(
    title: Text('Exit App'),
    content: Text('Are you sure you want to exit?'),
    actions: [
      TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('No')),
      TextButton(
          onPressed: () async {
            Get.back();
            Get.back();
            Get.back();
            // exit(0);
          },
          child: Text('Yes')),
    ],
  ));
}
