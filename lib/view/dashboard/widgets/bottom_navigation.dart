import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/logic/auth_logic.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/stud_list_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/assets/icons_utils.dart';
import 'package:msp_educare_demo/utils/assets/images_utils.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/route_utils.dart';
import 'package:msp_educare_demo/utils/shared_preference_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/auth_viewmodel.dart';
import 'package:msp_educare_demo/viewModel/dashboard_viewmodel.dart';
import 'package:msp_educare_demo/viewModel/notification_viewmodel.dart';
import 'package:msp_educare_demo/viewModel/student_list_viewmodel.dart';

class BottomNavigation extends StatefulWidget {
  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final DashBoardViewModel _viewModel =
      Get.find(tag: DashBoardViewModel().toString());

  final NotificationViewModel _notificationViewModel =
      Get.find(tag: NotificationViewModel().toString());

  @override
  void initState() {
    _notificationViewModel.getNotificationCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 75,
      decoration: BoxDecoration(
          color: ColorUtils.white,
          boxShadow: [
            BoxShadow(
                color: ColorUtils.shadowGrey,
                blurRadius: 4,
                offset: const Offset(0.0, -5.0))
          ],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          simpleBottomItem(
              img: IconsWidgets.home, title: VariableUtils.home, index: 0),
          simpleBottomItem(
              img: IconsWidgets.notification,
              title: VariableUtils.notification,
              index: 1),
          // InkWell(onTap: onCircleTap, child: IconsWidgets.routeCircle),
          InkWell(onTap: onCircleTap, child: IconsWidgets.routeCircle),

          simpleBottomItem(
              img: ImagesWidgets.eventsStr,
              title: VariableUtils.events,
              index: 2),
          simpleBottomItem(
              img: IconsWidgets.logout, title: VariableUtils.logout, index: 3),
        ],
      ),
    );
  }

  Widget simpleBottomItem(
      {required String title, required String img, required int index}) {
    return InkWell(
      onTap: () async {
        _notificationViewModel.getNotificationCount();
        UserData userData = ConstUtils.getUserData();
        print('INDEX :$index');
        if (index == 3) {
          await LoginLogic.logOutClick();
          _viewModel.selectedBottomNaviIndex = 0;
          return;
        }
        if (index == 2 &&
            userData.usertype ==
                ConstUtils.kGetRoleIndex(VariableUtils.parent) &&
            _viewModel.dashBoardHomeRoute ==
                DashBoardHomeRoute.StudentList.index) {
          StudentListViewModel viewModel =
              Get.find(tag: StudentListViewModel().toString());
          if (viewModel.studentListApiResponse.status == Status.COMPLETE) {
            StudListResModel response = viewModel.studentListApiResponse.data;
            if (response.data!.isNotEmpty) {
              await PreferenceManagerUtils.setStudData(
                  jsonEncode(response.data!.first));
              Get.find<AuthViewModel>(tag: AuthViewModel().toString())
                  .setSelectedStudent(response.data!.first);
            }
          }
        }
        _viewModel.selectedBottomNaviIndex = index;
      },
      child: GetBuilder<DashBoardViewModel>(
        tag: DashBoardViewModel().toString(),
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset(
                    img,
                    scale: index == 2 ? 25 : 4,
                    color: controller.selectedBottomNaviIndex == index
                        ? ColorUtils.blue
                        : ColorUtils.grey,
                  ),
                  if (title == VariableUtils.notification) notiCountTxt()
                ],
              ),
              SizeConfig.sH5,
              Text(
                title,
                style: controller.selectedBottomNaviIndex == index
                    ? FontTextStyle.poppinsW512Purple
                    : FontTextStyle.poppinsW5S12Grey,
              )
            ],
          );
        },
      ),
    );
  }

  Widget notiCountTxt() {
    return GetBuilder<NotificationViewModel>(
      tag: NotificationViewModel().toString(),
      builder: (controller) {
        if (controller.getNotificationCountApiResponse.status ==
                Status.LOADING ||
            controller.getNotificationCountApiResponse.status ==
                Status.INITIAL ||
            controller.getNotificationCountApiResponse.status == Status.ERROR) {
          return const SizedBox();
        }
        CommonResModel model = controller.getNotificationCountApiResponse.data;
        if (model.status != VariableUtils.ok) {
          return const SizedBox();
        }

        return Positioned(
            right: -8,
            top: -8,
            child: Text(
              model.data ?? "",
              style: FontTextStyle.poppinsW7S16Red,
            ));
      },
    );
  }

  void onCircleTap() {
    final data = ConstUtils.getUserData();
    if (data.usertype == LoginType.Parent.index.toString() &&
        _viewModel.dashBoardHomeRoute == DashBoardHomeRoute.HomeTab.index) {
      RouteUtils.navigateRoute(RouteUtils.studentDetailScreen);
    } else if (data.usertype != LoginType.Parent.index.toString()) {
      RouteUtils.navigateRoute(RouteUtils.staffDetailScreen);
    }
  }
}
