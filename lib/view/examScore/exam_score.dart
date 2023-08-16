// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/add_or_forword_circle_box.dart';
import 'package:msp_educare_demo/common/commonWidgets/date_box.dart';
import 'package:msp_educare_demo/common/commonWidgets/small_user_profile_box.dart';
import 'package:msp_educare_demo/dialog/exam_score_dialog.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_exam_score_list_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/exam_score_viewmodel.dart';

class ExamScore extends StatefulWidget {
  @override
  State<ExamScore> createState() => _ExamScoreState();
}

class _ExamScoreState extends State<ExamScore> {
  ExamScoreViewModel viewModel = Get.find(tag: ExamScoreViewModel().toString());
  late UserData userData;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    viewModel.getExamScoreListList();
    userData = ConstUtils.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: VariableUtils.examScore,
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
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            decoration: DecorationUtils.commonDecorationBox(),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    VariableUtils.examScore,
                    style: FontTextStyle.poppinsW7S14DarkGrey,
                  ),
                ),
                SizeConfig.sH5,
                const Divider(),
                SizeConfig.sH5,
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GetBuilder<ExamScoreViewModel>(
                        tag: ExamScoreViewModel().toString(),
                        builder: (controller) {
                          if (controller.getExamScoreListApiResponse.status ==
                                  Status.LOADING ||
                              controller.getExamScoreListApiResponse.status ==
                                  Status.INITIAL) {
                            return getDataLoadingIndicator();
                          }
                          if (controller.getExamScoreListApiResponse.status ==
                              Status.ERROR) {
                            return getDataErrorMsg();
                          }
                          GetExamScoreListResModel model =
                              controller.getExamScoreListApiResponse.data;
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
                                        showExamScoreDialog(model.data![index]);
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
                                                          .startDate ??
                                                      VariableUtils.none,
                                                  textStyle: FontTextStyle
                                                      .poppinsW6S13Grey,
                                                ),
                                                SizeConfig.sH10,
                                                Text(
                                                  model.data![index].examType ??
                                                      VariableUtils.none,
                                                )
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              showExamScoreDialog(
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
                                    return const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
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
}
