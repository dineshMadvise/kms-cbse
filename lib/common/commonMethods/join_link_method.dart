import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/url_launch.dart';
import 'package:msp_educare_demo/dialog/permission_dialog.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/route_utils.dart';
import 'package:permission_handler/permission_handler.dart';


Future<void> onTap({required String link}) async {
  print('MEET =>${ConstUtils.convertLink(link).replaceAll(" ", "")}');
  urlLaunch(ConstUtils.convertLink(link).replaceAll(" ", ""));
  //
  // final cameraStatus = await Permission.camera.status;
  // final microphoneStatus = await Permission.microphone.status;
  // final storageStatus = await Permission.storage.status;
  // print('CAMERA STATUS :$cameraStatus');
  // print('STORAGE STATUS :$storageStatus');
  // print('MICROP STATUS :$microphoneStatus');
  //
  // if (cameraStatus != PermissionStatus.granted) {
  //   print('CAMERA------ STATUS :$cameraStatus');
  //
  //   // await Permission.camera.request();
  //
  //   await permissionDialog(title: 'camera');
  //   return;
  // }
  // if (microphoneStatus != PermissionStatus.granted) {
  //   await permissionDialog(title: 'microphone');
  //   return;
  // }
  // if (storageStatus != PermissionStatus.granted) {
  //   await permissionDialog(title: 'storage');
  //   return;
  // }
  // Get.back();
  // print('MEET =>${ConstUtils.convertLink(link).replaceAll(" ", "")}');
  // urlLaunch(ConstUtils.convertLink(link).replaceAll(" ", ""));
}

/*Future<void> onTap({required String link}) async {
  final cameraStatus = await Permission.camera.status;
  final microphoneStatus = await Permission.microphone.status;
  final storageStatus = await Permission.storage.status;
  print('CAMERA STATUS :$cameraStatus');
  print('STORAGE STATUS :$storageStatus');
  print('MICROP STATUS :$microphoneStatus');

  if (cameraStatus != PermissionStatus.granted) {
    print('CAMERA------ STATUS :$cameraStatus');

    // await Permission.camera.request();

    await permissionDialog(title: 'camera');
    return;
  }
  if (microphoneStatus != PermissionStatus.granted) {
    await permissionDialog(title: 'microphone');
    return;
  }
  if (storageStatus != PermissionStatus.granted) {
    await permissionDialog(title: 'storage');
    return;
  }
  Get.back();
  RouteUtils.navigateRoute(RouteUtils.webViewScreen, args: link);
}*/
