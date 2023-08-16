// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/dialog/app_exit_dialog.dart';
import 'package:msp_educare_demo/dialog/pop_up_dialog.dart';
import 'package:msp_educare_demo/dialog/update_version_dialog.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/services/app_notification.dart';
import 'package:msp_educare_demo/services/google_map_marker_pin.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/view/dashboard/home_tab.dart';
import 'package:msp_educare_demo/view/dashboard/notification_tab.dart';
import 'package:msp_educare_demo/view/dashboard/widgets/bottom_navigation.dart';
import 'package:msp_educare_demo/view/events/events_list.dart';
import 'package:msp_educare_demo/view/studentList/student_list_screen.dart';
import 'package:msp_educare_demo/viewModel/auth_viewmodel.dart';
import 'package:msp_educare_demo/viewModel/dashboard_viewmodel.dart';
import 'package:msp_educare_demo/viewModel/dropdown_options_viewmodel.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState
    extends State<DashBoard> /*with WidgetsBindingObserver */ {
  late UserData userData;
  final dropDownViewModel = Get.find<DropdownOptionViewModel>(
      tag: DropdownOptionViewModel().toString());
  final _dashBoardViewModel =
      Get.find<DashBoardViewModel>(tag: DashBoardViewModel().toString());
  final AuthViewModel authViewModel = Get.find(tag: AuthViewModel().toString());
  final _inAppReview = InAppReview.instance;

  // final InAppReviewExampleApp _inAppReviewExampleApp = InAppReviewExampleApp();
  Future<void> inAppReviewExampleApp() => _inAppReview.requestReview();

  @override
  void initState() {
    init();
    super.initState();
  }

/*  void init() {
    // WidgetsBinding.instance.addObserver(this);
    // serServiceAsForeground();
    Get.find<DropdownOptionViewModel>(tag: DropdownOptionViewModel().toString())
        .getAttendanceStatus();
    GoogleMapMarkerPinService.setSourceAndDestinationIcons();

    _dashBoardViewModel.updateUserStatus(status: VariableUtils.open);
    userData = ConstUtils.getUserData();

    getGpsStatus();
    if (userData.usertype == ConstUtils.kGetRoleIndex(VariableUtils.parent)) {
      _dashBoardViewModel.dashBoardHomeRoute = DashBoardHomeRoute.StudentList;
    } else {
      _dashBoardViewModel.dashBoardHomeRoute = DashBoardHomeRoute.HomeTab;
    }
    AppNotificationHandler.getInitialMsg();
    AppNotificationHandler.showMsgHandler();
    AppNotificationHandler.onMsgOpen();

    /// CHECK APP VERSION
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkAppVersion(context);
    });

    /// SHOW POP UP
    showPopUp();
  }*/

  void init() {
    // WidgetsBinding.instance.addObserver(this);
    GoogleMapMarkerPinService.setSourceAndDestinationIcons();
    dropDownViewModel.getAttendanceStatus();
    dropDownViewModel.getStatusOption();
    dropDownViewModel.getTypeOption();
    _dashBoardViewModel.updateUserStatus(status: VariableUtils.open);
    userData = ConstUtils.getUserData();
    logs('USER DATA ==>${jsonEncode(userData.toJson())}');
    // getGpsStatus();
    if (userData.usertype == ConstUtils.kGetRoleIndex(VariableUtils.parent)) {
      /// REVIEW AND RATTING
      // inAppReviewExampleApp();
      print('PARENT LOGIN ----------');
      _dashBoardViewModel.dashBoardHomeRoute =
          DashBoardHomeRoute.StudentList.index;
    } else if (userData.usertype ==
            ConstUtils.kGetRoleIndex(VariableUtils.teacher) ||
        userData.usertype == ConstUtils.kGetRoleIndex(VariableUtils.admin)) {
      authViewModel.teacherDetail(userData.userid ?? "");
    } else {
      _dashBoardViewModel.dashBoardHomeRoute = DashBoardHomeRoute.HomeTab.index;
    }
    AppNotificationHandler.getInitialMsg();
    AppNotificationHandler.showMsgHandler();
    AppNotificationHandler.onMsgOpen();
    NotificationController.startListeningNotificationEvents();

    /// CHECK APP VERSION
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      checkAppVersion(context);
      // _dashBoardViewModel.dashBoardHomeRoute = DashBoardHomeRoute.HomeTab.index;
    });

    /// SHOW POP UP
    showPopUp();
  }

  Future<bool> onWillPop() {
    if (userData.usertype == ConstUtils.kGetRoleIndex(VariableUtils.parent)) {
      return Future.value(true);
    }
    showAppExitDialog();
    return Future.value(false);
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.paused) {
  //     print('BACKGROUBD....................');
  //     // serServiceAsBackground();
  //   } else if (state == AppLifecycleState.resumed) {
  //     // serServiceAsForeground();
  //     print('FORE GRAND ------------------');
  //   }
  // }

  @override
  void dispose() {
    // WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: GetBuilder<DashBoardViewModel>(
          tag: DashBoardViewModel().toString(),
          builder: (cont) {
            if (cont.getGpsStatusApiResponse.status == Status.LOADING) {
              return Material(
                child: getDataLoadingIndicator(),
              );
            }
            return Scaffold(

              bottomNavigationBar:
                  SafeArea(bottom: true, child: BottomNavigation()),
              body: Stack(
                children: [
                  GetBuilder<DashBoardViewModel>(
                    tag: DashBoardViewModel().toString(),
                    builder: (controller) {
                      logs(
                          'controller.dashBoardHomeRoute=>${controller.dashBoardHomeRoute}');
                      if (controller.selectedBottomNaviIndex ==
                          BottomNavigationRoute.Home.index) {
                        return controller.dashBoardHomeRoute ==
                                DashBoardHomeRoute.StudentList.index
                            ? const StudentListScreen()
                            : const HomeTab();
                      }
                      if (controller.selectedBottomNaviIndex ==
                          BottomNavigationRoute.Notification.index) {
                        return NotificationTab();
                      }
                      if (controller.selectedBottomNaviIndex ==
                          BottomNavigationRoute.Event.index) {
                        // return ChatTab();
                        return const EventsList(
                          fromDashboard: true,
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  GetBuilder<AuthViewModel>(
                    tag: AuthViewModel().toString(),
                    builder: (controller) {
                      if (controller.logoutApiResponse.status ==
                          Status.LOADING) {
                        return postDataLoadingIndicator();
                      }
                      return const SizedBox();
                    },
                  )
                ],
              ),
              /* body: Stack(
                children: [
                  GetBuilder<DashBoardViewModel>(
                    tag: DashBoardViewModel().toString(),
                    builder: (controller) {
                      if (controller.selectedBottomNaviIndex ==
                          BottomNavigationRoute.Home.index) {
                        return controller.dashBoardHomeRoute ==
                                DashBoardHomeRoute.StudentList
                            ? const StudentListScreen()
                            : const HomeTab();
                      }
                      if (controller.selectedBottomNaviIndex ==
                          BottomNavigationRoute.Notification.index) {
                        return NotificationTab();
                      }
                      if (controller.selectedBottomNaviIndex ==
                          BottomNavigationRoute.Event.index) {
                        // return ChatTab();
                        return const EventsList(
                          fromDashboard: true,
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  GetBuilder<AuthViewModel>(
                    tag: AuthViewModel().toString(),
                    builder: (controller) {
                      if (controller.logoutApiResponse.status ==
                          Status.LOADING) {
                        return postDataLoadingIndicator();
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),*/
            );
          }),
    );
  }
}
