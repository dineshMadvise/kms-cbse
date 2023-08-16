import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> permissionDialog({
  required String title,
}) async {
  Get.defaultDialog(
      title: 'Allowed $title permission',
      textConfirm: "Allow",
      content: Text(""),
      onConfirm: () async {
        if (title == 'camera') {
          final permissionStatus = await Permission.camera.request();
          if (permissionStatus == PermissionStatus.granted) {
            final permissionStatus = await Permission.storage.request();
            if (permissionStatus == PermissionStatus.granted) {
              await Permission.microphone.request();
            }
          }
        } else if (title == 'storage') {
          final permissionStatus = await Permission.storage.request();
          if (permissionStatus == PermissionStatus.granted) {
            await Permission.microphone.request();
          }
        } else {
          await Permission.microphone.request();
        }

        Get.back();
      },
      confirmTextColor: ColorUtils.white,
      buttonColor: ColorUtils.blue,
      radius: 10.0);
}
