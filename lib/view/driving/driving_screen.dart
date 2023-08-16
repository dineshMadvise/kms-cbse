import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/dashboard_viewmodel.dart';

class DrivingScreen extends StatelessWidget {
  DrivingScreen({Key? key}) : super(key: key);

  final viewModel =
      Get.find<DashBoardViewModel>(tag: DashBoardViewModel().toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: VariableUtils.driving,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
          child: GetBuilder<DashBoardViewModel>(
              tag: DashBoardViewModel().toString(),
              builder: (con) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Opacity(
                    //   opacity: con.isBackgroundServiceRunning ? 0.3 : 1.0,
                    //   child: CustomBtn(
                    //       onTap: con.isBackgroundServiceRunning
                    //           ? null
                    //           : () async {
                    //               if (ConstUtils.kGpsInterval == 0) {
                    //                 showToast(
                    //                     msg: 'Please check your interval time');
                    //                 return;
                    //               }
                    //
                    //               /// GET LOCATION PERMISSION
                    //               await GetLocation.checkLocationPermission();
                    //               if (GetLocation.latitude == 0 ||
                    //                   GetLocation.longitude == 0) {
                    //                 showToast(
                    //                     msg: 'Please first enable location');
                    //               } else {
                    //                 await initializeService();
                    //                 viewModel.isBackgroundServiceRunning = true;
                    //               }
                    //             },
                    //       title: VariableUtils.startGps,
                    //       borderColor: ColorUtils.transparent,
                    //       bgColor: ColorUtils.darkGreen,
                    //       leading: Icons.not_started_outlined),
                    // ),
                    // SizeConfig.sH20,
                    // Opacity(
                    //   opacity: !con.isBackgroundServiceRunning ? 0.3 : 1.0,
                    //   child: CustomBtn(
                    //     onTap: () async {
                    //             // FlutterBackgroundService()
                    //             //     .invoke("setAsForeground");
                    //             await stopBackgroundService();
                    //           },
                    //     title: VariableUtils.stopGps,
                    //     bgColor: ColorUtils.darkRed,
                    //     borderColor: ColorUtils.transparent,
                    //     leading: Icons.stop_circle_outlined,
                    //   ),
                    // ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
