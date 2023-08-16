import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/add_or_forword_circle_box.dart';
import 'package:msp_educare_demo/common/commonWidgets/small_user_profile_box.dart';
import 'package:msp_educare_demo/dialog/class_timetable_dialog.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_class_timetable_list_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/class_timetable_viewmodel.dart';

class ClassTimeTable extends StatefulWidget {
  @override
  State<ClassTimeTable> createState() => _ClassTimeTableState();
}

class _ClassTimeTableState extends State<ClassTimeTable> {
  ClassTimeTableViewModel viewModel =
      Get.find(tag: ClassTimeTableViewModel().toString());
  late UserData userData;
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    viewModel.getClassTimeTableList();
    userData = ConstUtils.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: VariableUtils.classTimetable,
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
            // height: Get.height,
            width: Get.width,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
            decoration: DecorationUtils.commonDecorationBox(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  VariableUtils.classTimetable,
                  style: FontTextStyle.poppinsW7S14DarkGrey,
                ),
                SizeConfig.sH5,
                Divider(),
                Expanded(
                    child: GetBuilder<ClassTimeTableViewModel>(
                  tag: ClassTimeTableViewModel().toString(),
                  builder: (controller) {
                    if (controller.getClassTimeTableListApiResponse.status ==
                            Status.LOADING ||
                        controller.getClassTimeTableListApiResponse.status ==
                            Status.INITIAL) {
                      return getDataLoadingIndicator();
                    }
                    if (controller.getClassTimeTableListApiResponse.status ==
                        Status.ERROR) {
                      return getDataErrorMsg();
                    }
                    GetClassTimetableListResModel model =
                        controller.getClassTimeTableListApiResponse.data;
                    if (model.status != VariableUtils.ok) {
                      return getFieldIsEmptyMsg();
                    }
                    print('LENGTH:${model.data!.length}');
                    return model.data!.isEmpty
                        ? getNotApplicableMsg(msg: model.msg)
                        : ListView.separated(
                            itemCount: model.data!.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  showClassTimetableDialog(model.data![index]);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            model.data![index].day ??
                                                VariableUtils.none,
                                            style:
                                                FontTextStyle.poppinsW6S14Grey,
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
                                                model.data![index].time ??
                                                    VariableUtils.none,
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
                                        showClassTimetableDialog(
                                            model.data![index]);
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
                ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
