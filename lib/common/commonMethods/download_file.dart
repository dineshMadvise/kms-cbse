import 'dart:io';

// import 'package:open_file/open_file.dart' as open_file;
import 'package:dio/dio.dart';
import 'package:msp_educare_demo/common/commonMethods/get_storage_permission.dart';
import 'package:msp_educare_demo/common/commonMethods/toast_msg.dart';
import 'package:msp_educare_demo/common/commonMethods/url_launch.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> downloadFile(String url, {bool openFileStatus = false}) async {
  if (url == '' || url == null) {
    showToast(msg: VariableUtils.fileNotExists);
    return;
  }
  print('DOWNLOAD LINK : => $url');

  // showToast(msg: VariableUtils.fileDownloading, success: true);
  try {
    await urlLaunch(url);
  } catch (e) {
    showToast(msg: VariableUtils.fileDownloadFailed);
    print('ERROR :=>$e');
  }
}

Future<void> urlLaunch(String url) async {
  if (!await launch(url)) throw 'Could not launch $url';
}

// Future<void> downloadFile(String url, {bool openFileStatus = false}) async {
//   if (url == '' || url == null) {
//     showToast(msg: VariableUtils.fileNotExists);
//     return;
//   }
//   print('DOWNLOAD LINK : => $url');
//
//
//
//   showToast(msg: VariableUtils.fileDownloading, success: true);
//   final storagePermissionStatus = await getStoragePermission();
//   print('storagePermissionStatus;+>$storagePermissionStatus');
//   if (!storagePermissionStatus) {
//     showToast(msg: VariableUtils.enableStoragePermission);
//     return;
//   }
//   try {
//
//     final fileName=ConstUtils.kGetFileName(url);
//     if(!fileName.contains('.')){
//       urlLaunch(url);
//       return;
//     }
//
//     Dio dio = Dio();
//     String savePath = (await getDownloadPath()) ?? '';
//     if (savePath == "") {
//       showToast(msg: VariableUtils.fileDownloadFailed);
//       return;
//     }
//     print('PATH :=>$savePath');
//     savePath = savePath + '/' + fileName;
//
//
//     print('AFTER FILE NAME ADD PATH :=>$savePath');
//     final response = await dio.download(url, savePath);
//     // print('RESPONSE CODE : - ${response.statusCode}');
//     // print('RESPONSE :=> ${response.data}');
//     if (response.statusCode == 200) {
//       showToast(
//         msg: VariableUtils.fileDownloadSuccess,
//         success: true,
//       );
//       final fileExtensionStatus = ConstUtils.kCheckFileExtension(savePath);
//     /*  if (openFileStatus || fileExtensionStatus) {
//         // openFile(savePath, url);
//       } else {
//         RouteUtils.navigateRoute(RouteUtils.webViewScreen, args: url);
//       }*/
//     } else {
//       showToast(msg: VariableUtils.fileDownloadFailed);
//     }
//   } on Exception catch (e) {
//     showToast(msg: VariableUtils.fileDownloadFailed);
//     print('ERROR :=>$e');
//   }
// }
//
// Future<String?> getDownloadPath() async {
//   Directory? directory;
//   try {
//     if (Platform.isIOS) {
//       directory = await getApplicationDocumentsDirectory();
//     } else {
//       directory = Directory('/storage/emulated/0/Download');
//       final existsPathStatus = await directory.exists();
//       if (!existsPathStatus) directory = await getExternalStorageDirectory();
//       // directory = await getTemporaryDirectory();
//     }
//   } catch (err, stack) {
//     print("Cannot get download folder path");
//   }
//   return directory?.path;
// }

// Future<void> openFile(String path, String link) async {
//   await open_file.OpenFile.open(
//     path,
//   ).then((value) {
//     if (value.type != open_file.ResultType.done) {
//       urlLaunch(link);
//     }
//   }).catchError((e) => print('ERROR :=>$e'));
// }
