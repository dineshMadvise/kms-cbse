import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/small_user_profile_box.dart';
import 'package:msp_educare_demo/logic/dashboard_logic.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/dashboard_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/dashboard_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/assets/images_utils.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/dashboard_viewmodel.dart';
import 'package:msp_educare_demo/viewModel/home_viewmodel.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
  static _HomeTabState? of(BuildContext context) {
    return context.findAncestorStateOfType<_HomeTabState>();
  }
}

class _HomeTabState extends State<HomeTab> {
  HomeViewModel viewModel = Get.find(tag: HomeViewModel().toString());
  DashBoardViewModel dashboardViewModel =
      Get.find(tag: DashBoardViewModel().toString());
  late UserData userData;

  @override
  void initState() {
    userData = ConstUtils.getUserData();
    if (userData.usertype != null) {
      if (userData.usertype != ConstUtils.kGetRoleIndex(VariableUtils.parent)) {
        viewModel.getDashboardData();
      }
    }

    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return WillPopScope(
      onWillPop: () {
        if (userData.usertype ==
            ConstUtils.kGetRoleIndex(VariableUtils.parent)) {
          dashboardViewModel.dashBoardHomeRoute =
              DashBoardHomeRoute.StudentList.index;
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: SafeArea(
          child: Container(
        // color: const Color(0xfff4f6fa),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizeConfig.sH20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    if (userData.usertype != null)
                      if (userData.usertype ==
                          ConstUtils.kGetRoleIndex(VariableUtils.parent))
                        InkResponse(
                          onTap: () {
                            if (userData.usertype ==
                                ConstUtils.kGetRoleIndex(
                                    VariableUtils.parent)) {
                              dashboardViewModel.dashBoardHomeRoute =
                                  DashBoardHomeRoute.StudentList.index;
                            }
                          },
                          child: const Icon(
                            ConstUtils.kBackArrowIcon,
                            color: ColorUtils.blue,
                          ),
                        ),
                    const Spacer(),
                    Text(
                      VariableUtils.dashBoard,
                      style: FontTextStyle.poppinsW6S14Black
                          .copyWith(letterSpacing: 0.8),
                    ),
                    const Spacer(),
                    if (userData.usertype ==
                        ConstUtils.kGetRoleIndex(VariableUtils.parent))
                      SizeConfig.sW10
                  ],
                ),
              ),
              SizeConfig.sH20,
              if (userData.usertype ==
                  ConstUtils.kGetRoleIndex(VariableUtils.parent))
                SmallUserProfileBox(
                  isLarge: true,
                ),
              GetBuilder<HomeViewModel>(
                tag: HomeViewModel().toString(),
                builder: (controller) {
                  if (controller.dashboardApiResponse.status ==
                          Status.LOADING ||
                      controller.dashboardApiResponse.status ==
                          Status.INITIAL) {
                    return Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.4),
                      child: getDataLoadingIndicator(),
                    );
                  }
                  if (controller.dashboardApiResponse.status == Status.ERROR) {
                    return getDataErrorMsg();
                  }
                  DashboardResModel model =
                      controller.dashboardApiResponse.data;
                  if (model.status != VariableUtils.ok) {
                    return getFieldIsEmptyMsg();
                  }

                  print('LENGTH:${model.allowedmodules}');
                  return GridView.count(
                    crossAxisCount: 2,
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    crossAxisSpacing: 20,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 20,
                    children: model.allowedmodules!
                        .map((e) => Material(
                              color: ColorUtils.transparent,
                              child: Ink(
                                decoration:
                                    DecorationUtils.commonDecorationBox(),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {
                                    DashboardLogic.onTap(e);
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.all(e ==
                                                  VariableUtils.academicYearPlan||e ==
                                                  VariableUtils.sms
                                              ? 0
                                              : 20),
                                          child: getImg(e),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            20,
                                            e.trim() == VariableUtils.transport
                                                ? 0
                                                : 15,
                                            20,
                                            15),
                                        child: Text(
                                          e,
                                          style:
                                              FontTextStyle.poppinsW6S14Black,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  );
                },
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget getImg(String str) {
    return ConstUtils.kDashBoardCatList
        .firstWhere(
          (element) => element.title == str.trim(),
          orElse: () => DashBoardModel(title: 'demo', img: SvgWidgets.homeWork),
        )
        .img;
  }
}
