import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_app_version.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/app_config.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/viewModel/auth_viewmodel.dart';
import 'package:open_store/open_store.dart';

Future<void> checkAppVersion(BuildContext context) async {
  final authViewModel =
      Get.find<AuthViewModel>(tag: AuthViewModel().toString());
  await authViewModel.getAppVersion();

  if (authViewModel.getAppVersionApiResponse.status == Status.COMPLETE) {
    GetAppVersionResModel doc = authViewModel.getAppVersionApiResponse.data;
    if (doc.data!.isEmpty) {
      return;
    }

    String versionName = "";
    int newVersion = 0;
    int currentVersion = int.parse(ConstUtils.appVersion.replaceAll('.', ''));
    if (Platform.isAndroid) {
      versionName = doc.data!.first.android.toString().replaceAll('.', '');
      newVersion = int.parse(versionName);
    } else {
      versionName = doc.data!.first.ios.toString().replaceAll('.', '');
      newVersion = int.parse(versionName);
    }
    print('NEW VERSION : $newVersion CURRENT VERSION :$currentVersion');
    // if (newVersion != currentVersion) {
    if (newVersion > currentVersion) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return WillPopScope(
              onWillPop: () => Future.value(false),
              child: AlertDialog(
                title: const Text('Notice'),
                content: const Text(
                    'A new version is available. Update the app to continue.'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text('CLOSE')),
                  TextButton(
                      onPressed: () {
                        OpenStore.instance.open(
                          appStoreId:AppConfig.appStoreId, // AppStore id of your app
                          androidAppBundleId:
                              AppConfig.androidAppBundleId, // Android app bundle package name
                        );
                      },
                      child: const Text('UPDATE')),
                ],
              ),
            );
          });
    }
  }
}
