import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/dashboard_viewmodel.dart';

showAppExitDialog() {
  return Get.dialog(AlertDialog(
    title: Text('Exit App'),
    content: Text('Are you sure you want to close the app ?'),
    actions: [
      TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('No')),
      //
      TextButton(
          onPressed: () async {
            Get.back();
            DashBoardViewModel _dashBoardViewModel =
                Get.find(tag: DashBoardViewModel().toString());
            await _dashBoardViewModel.updateUserStatus(
                status: VariableUtils.close);
            await Future.delayed(Duration(seconds: 2));
            exit(0);
          },
          child: Text('Yes')),
    ],
  ));
}
