import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/add_or_forword_circle_box.dart';
import 'package:msp_educare_demo/common/commonWidgets/date_box.dart';
import 'package:msp_educare_demo/common/commonWidgets/small_user_profile_box.dart';
import 'package:msp_educare_demo/dialog/exam_timetable_dialog.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_exam_timetable_list_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/exam_timetable_viewmodel.dart';

import '../../model/apis/api_response.dart';

class ExamTimetable extends StatefulWidget {
  @override
  State<ExamTimetable> createState() => _ExamTimetableState();
}

class _ExamTimetableState extends State<ExamTimetable> {
  ExamTimetableViewModel viewModel =
      Get.find(tag: ExamTimetableViewModel().toString());
  late UserData userData;

  // late StudentData studentData;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    viewModel.getExamTimeTableList();
    userData = ConstUtils.getUserData();
    // studentData = ConstUtils.getStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: VariableUtils.examTimeTable,
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
            height: Get.height,
            width: Get.width,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
            decoration: DecorationUtils.commonDecorationBox(),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    VariableUtils.examTimeTable,
                    style: FontTextStyle.poppinsW7S14DarkGrey,
                  ),
                ),
                SizeConfig.sH5,
                Divider(),
                SizeConfig.sH5,
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GetBuilder<ExamTimetableViewModel>(
                        tag: ExamTimetableViewModel().toString(),
                        builder: (controller) {
                          if (controller
                                      .getExamTimeTableListApiResponse.status ==
                                  Status.LOADING ||
                              controller
                                      .getExamTimeTableListApiResponse.status ==
                                  Status.INITIAL) {
                            return getDataLoadingIndicator();
                          }
                          if (controller
                                  .getExamTimeTableListApiResponse.status ==
                              Status.ERROR) {
                            return getDataErrorMsg();
                          }
                          GetExamTimetableListResModel model =
                              controller.getExamTimeTableListApiResponse.data;
                          if (model.status != VariableUtils.ok) {
                            return getFieldIsEmptyMsg();
                          }
                          print('LENGTH:${model.data!.length}');
                          return model.data!.isEmpty
                              ? getNotApplicableMsg(msg: model.msg)
                              : ListView.separated(
                                  itemCount: model.data!.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        showExamTimetableDialog(
                                            model.data![index]);
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                DateBox(
                                                  text: model.data![index]
                                                          .examDate ??
                                                      VariableUtils.none,
                                                  textStyle: FontTextStyle
                                                      .poppinsW6S13Grey,
                                                ),
                                                SizeConfig.sH10,
                                                Text(model.data![index]
                                                        .examType ??
                                                    VariableUtils.none),
                                                SizeConfig.sH10,
                                                richText(
                                                    key: VariableUtils.classStr,
                                                    value: model.data![index]
                                                            .classStr ??
                                                        VariableUtils.none),
                                                SizeConfig.sH10,
                                                richText(
                                                    key: VariableUtils.section,
                                                    value: model.data![index]
                                                            .section ??
                                                        VariableUtils.none),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              showExamTimetableDialog(
                                                  model.data![index]);
                                            },
                                            child: const AddOrForwordCircleBox(
                                              icon:
                                                  ConstUtils.kForwordArrowIcon,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Divider(),
                                    );
                                  },
                                );
                        },
                      )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Text richText({required String key, required String value}) {
    return Text.rich(TextSpan(children: [
      TextSpan(text: key + " : ", style: FontTextStyle.poppinsW5S12Grey),
      TextSpan(
        text: value,
        style: FontTextStyle.poppinsW7S12DarkGrey,
      )
    ]));
  }
}
