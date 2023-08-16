import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonWidgets/add_or_forword_circle_box.dart';
import 'package:msp_educare_demo/common/commonWidgets/date_box.dart';
import 'package:msp_educare_demo/common/commonWidgets/small_user_profile_box.dart';
import 'package:msp_educare_demo/dialog/online_classes_dialog.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_online_class_list_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/online_classes_viewmodel.dart';

import '../../common/commonMethods/loading_indicator.dart';

class OnlineClasses extends StatefulWidget {
  @override
  State<OnlineClasses> createState() => _OnlineClassesState();
}

class _OnlineClassesState extends State<OnlineClasses> {
  OnlineClassesViewModel viewModel =
      Get.find(tag: OnlineClassesViewModel().toString());
  late UserData userData;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    viewModel.getOnlineClassList();
    userData = ConstUtils.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: VariableUtils.onlineClasses,
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        if (userData.usertype == ConstUtils.kGetRoleIndex(VariableUtils.parent))
          SmallUserProfileBox(),
        Expanded(
          child: Container(
            width: Get.width,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
            decoration: DecorationUtils.commonDecorationBox(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  VariableUtils.scheduledClasses,
                  style: FontTextStyle.poppinsW6S18Black,
                ),
                SizeConfig.sH10,
                Divider(),
                SizeConfig.sH5,
                Expanded(
                  child: GetBuilder<OnlineClassesViewModel>(
                    tag: OnlineClassesViewModel().toString(),
                    builder: (controller) {
                      if (controller.getOnlineCLassListApiResponse.status ==
                              Status.LOADING ||
                          controller.getOnlineCLassListApiResponse.status ==
                              Status.INITIAL) {
                        return getDataLoadingIndicator();
                      }
                      if (controller.getOnlineCLassListApiResponse.status ==
                          Status.ERROR) {
                        return getDataErrorMsg();
                      }
                      GetOnlineClassListResModel model =
                          controller.getOnlineCLassListApiResponse.data;
                      if (model.status != VariableUtils.ok) {
                        return getFieldIsEmptyMsg();
                      }
                      print('LENGTH:${model.data!.length}');
                      return model.data!.isEmpty
                          ? getNotApplicableMsg(msg: model.msg)
                          : ListView.separated(
                              itemCount: model.data!.length,
                              itemBuilder: (context, index) {
                                final data = model.data![index];
                                return InkWell(
                                  onTap: () {
                                    showOnlineClassesDialog(data);
                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            DateBox(
                                              text: data.dateDay ??
                                                  VariableUtils.none,
                                              textStyle: FontTextStyle
                                                  .poppinsW6S13Grey,
                                            ),
                                            SizeConfig.sH10,
                                            Text(
                                              '${data.className ?? VariableUtils.none} ${data.subjectName ?? VariableUtils.none}',
                                              style: FontTextStyle
                                                  .poppinsW5S12Black,
                                            ),
                                            SizeConfig.sH5,
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  ConstUtils.kWatchIcon,
                                                  color: ColorUtils.blue,
                                                  size: 18,
                                                ),
                                                SizeConfig.sW5,
                                                Text(
                                                  '${data.startTime} - ${data.endTime}',
                                                  style: FontTextStyle
                                                      .poppinsW5S10Grey,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showOnlineClassesDialog(data);
                                        },
                                        child: AddOrForwordCircleBox(
                                          icon: ConstUtils.kForwordArrowIcon,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Divider(),
                                );
                              },
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
