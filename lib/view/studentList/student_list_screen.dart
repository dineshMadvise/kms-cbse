// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/add_or_forword_circle_box.dart';
import 'package:msp_educare_demo/common/commonWidgets/octo_image_network.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/stud_list_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/assets/images_utils.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/shared_preference_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/auth_viewmodel.dart';
import 'package:msp_educare_demo/viewModel/dashboard_viewmodel.dart';
import 'package:msp_educare_demo/viewModel/home_viewmodel.dart';
import 'package:msp_educare_demo/viewModel/student_list_viewmodel.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({Key? key}) : super(key: key);

  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  StudentListViewModel viewModel =
      Get.find(tag: StudentListViewModel().toString());

  @override
  void initState() {
    viewModel.getStudList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  Widget buildBody() => SafeArea(
        child: Material(
          color: ColorUtils.lightGrey2,
          child: SizedBox(
            height: Get.height,
            width: Get.width,
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: Get.height * 0.22,
                      width: Get.width,
                      color: ColorUtils.blue,
                      padding: const EdgeInsets.only(top: 40),
                      alignment: Alignment.topCenter,
                      child: Text(
                        VariableUtils.studentList,
                        style: FontTextStyle.poppinsW6S18white,
                      ),
                    ),
                    const Spacer(),
                    ImagesWidgets.loginBg
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
                  child: GetBuilder<StudentListViewModel>(
                    tag: StudentListViewModel().toString(),
                    builder: (controller) {
                      if (controller.studentListApiResponse.status ==
                              Status.LOADING ||
                          controller.studentListApiResponse.status ==
                              Status.INITIAL) {
                        return getDataLoadingIndicator();
                      }
                      if (controller.studentListApiResponse.status ==
                          Status.ERROR) {
                        return getDataErrorMsg();
                      }

                      StudListResModel response =
                          controller.studentListApiResponse.data;
                      if (response.status != VariableUtils.ok) {
                        return getFieldIsEmptyMsg();
                      }
                      return ListView.builder(
                        itemCount: response.data!.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final data = response.data![index];
                          return _SmallUserProfileBox(
                            data: data,
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      );
}

class _SmallUserProfileBox extends StatelessWidget {
  final StudentData data;

  const _SmallUserProfileBox({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Get.width,
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        decoration:
            DecorationUtils.commonDecorationBox(color: ColorUtils.white),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            ClipOval(
              child: OctoImageNetwork(
                url: data.profile,
                radius: 20,
                width: 40,
                height: 40,
              ),
            ),
            // data.profile!.isEmpty
            //     ? CircleAvatar(
            //         radius: 18,
            //         backgroundColor: ColorUtils.lightPurple,
            //         child: ImagesWidgets.eventPersonIcon,
            //       )
            //     : Container(
            //         height: 36,
            //         width: 36,
            //         decoration: BoxDecoration(
            //             color: ColorUtils.red,
            //             shape: BoxShape.circle,
            //             image: DecorationImage(
            //                 image: NetworkImage(data.profile!),
            //                 fit: BoxFit.cover)),
            //       ),
            SizeConfig.sW10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    data.name!,
                    style: FontTextStyle.poppinsW9S13Purple,
                  ),
                  SizeConfig.sH5,
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: DecorationUtils.borderDecorationBox(
                              radius: 30, color: ColorUtils.blue),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Center(
                            child: Text(
                              "${data.className!.toUpperCase()} ${data.sectionName}",
                              style: FontTextStyle.poppinsW6S13Purple,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: InkWell(
                          onTap: onTap,
                          child: const AddOrForwordCircleBox(
                            icon: ConstUtils.kForwordArrowIcon,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> onTap() async {
    HomeViewModel homeViewModel = Get.find(tag: HomeViewModel().toString());
    final AuthViewModel authViewModel =
        Get.find(tag: AuthViewModel().toString());
    DashBoardViewModel dashboardViewModel =
        Get.find(tag: DashBoardViewModel().toString());
    homeViewModel.getDashboardData(userId: data.id);
    print('STUDE ID FROM LIST :${data.id}');
    await PreferenceManagerUtils.setStudData(jsonEncode(data));
    authViewModel.setSelectedStudent(data);
    dashboardViewModel.dashBoardHomeRoute = DashBoardHomeRoute.HomeTab.index;
    authViewModel.studentDetail(data.id ?? "");
  }
}
