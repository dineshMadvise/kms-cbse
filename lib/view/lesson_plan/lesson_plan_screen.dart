// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/download_file.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/date_box.dart';
import 'package:msp_educare_demo/dialog/lesson_plan_dialog.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_lesson_plan_list.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/route_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/lesson_plan_viewmodel.dart';
import '../../model/apis/api_response.dart';

class LessonPlanScreen extends StatefulWidget {
  @override
  State<LessonPlanScreen> createState() => _LessonPlanScreenState();
}

class _LessonPlanScreenState extends State<LessonPlanScreen> {
  final lessonPlanViewModel =
      Get.find<LessonPlanViewModel>(tag: LessonPlanViewModel().toString());
  late UserData userData;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    lessonPlanViewModel.getLessonPlanList();
    userData = ConstUtils.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          title: VariableUtils.lessonPlan,
          centerTitle: true,
          actionVisible: userData.usertype ==
              ConstUtils.kGetRoleIndex(VariableUtils.teacher),
          onActionTap: () {
            RouteUtils.navigateRoute(RouteUtils.addLessonPlan);
          }),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return GetBuilder<LessonPlanViewModel>(
      tag: LessonPlanViewModel().toString(),
      builder: (controller) {
        if (controller.getLessonPlanListApiResponse.status == Status.LOADING ||
            controller.getLessonPlanListApiResponse.status == Status.INITIAL) {
          return getDataLoadingIndicator();
        }
        if (controller.getLessonPlanListApiResponse.status == Status.ERROR) {
          return getDataErrorMsg();
        }
        GetLessonPlanListResModel model =
            controller.getLessonPlanListApiResponse.data;
        if (model.status != VariableUtils.ok) {
          return getFieldIsEmptyMsg();
        }
        print('LENGTH:${model.data!.length}');
        return model.data!.isEmpty
            ? Center(child: getNotApplicableMsg(msg: model.msg))
            : Container(
                height: Get.height,
                width: Get.width,
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                decoration: DecorationUtils.commonDecorationBox(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final e = model.data![index];
                    return InkWell(

                        onTap: () {
                          if (userData.usertype ==
                              ConstUtils.kGetRoleIndex(VariableUtils.teacher)) {
                            RouteUtils.navigateRoute(RouteUtils.editLessonPlan,args: e);
                          } else {
                            // showLessonPlanDialog(e);
                          }
                        },



                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DateBox(
                                text: e.startDate! + " to " + e.endDate!,
                                textStyle: FontTextStyle.poppinsW6S13Grey,
                              ),
                              InkWell(
                                  onTap: () {
                                    downloadFile(e.file!, openFileStatus: true);
                                  },
                                  child: const Icon(ConstUtils.kDownloadIcon))
                            ],
                          ),
                          SizeConfig.sH10,
                          richText(
                              key: VariableUtils.teacherName + ' : ',
                              value: e.teacherName ?? VariableUtils.none),
                          SizeConfig.sH10,
                          richText(
                              key: VariableUtils.subjectName + ' : ',
                              value: e.subject ?? VariableUtils.none),
                          SizeConfig.sH10,
                          Row(
                            children: [
                              Expanded(
                                child: richText(
                                    key: VariableUtils.status,
                                    value: e.status ?? VariableUtils.none),
                              ),
                              Expanded(
                                child: richText(
                                    key: VariableUtils.progress + ' : ',
                                    value: e.progress ?? VariableUtils.none),
                              ),
                            ],
                          ),
                          SizeConfig.sH10,
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Divider(),
                    );
                  },
                  itemCount: model.data!.length,
                ),
              );
      },
    );
  }

  Text richText({required String key, required String value}) {
    return Text.rich(TextSpan(children: [
      TextSpan(text: key, style: FontTextStyle.poppinsW5S12Grey),
      TextSpan(
        text: value,
        style: FontTextStyle.poppinsW7S12DarkGrey,
      )
    ]));
  }
}
