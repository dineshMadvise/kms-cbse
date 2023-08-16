import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_dropdown.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_text_field.dart';
import 'package:msp_educare_demo/common/commonWidgets/dialog_close_btn.dart';
import 'package:msp_educare_demo/logic/lesson_plan_logic.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/update_lesson_plan_status_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_lesson_plan_list.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/validation_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/lesson_plan_viewmodel.dart';

void showLessonPlanDialog(LessonPlanData data) {
  UpdateLessonPlanStatusReqModel reqModel = UpdateLessonPlanStatusReqModel(
      status: data.status,
      lessonPlanId: data.id,
      progress: data.progress,
      remark: "");
  Get.find<LessonPlanViewModel>(tag: LessonPlanViewModel().toString()).init();
  Get.dialog(Dialog(
    insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    child: Container(
      decoration: DecorationUtils.dialogDecorationBox(),
      padding: EdgeInsets.symmetric(vertical: 20),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    VariableUtils.updateLessonPlanStatus,
                    style: FontTextStyle.poppinsW6S13Grey,
                  ),
                  DialogCloseBtn(),
                ],
              ),
            ),
            SizeConfig.sH10,
            Divider(),
            SizeConfig.sH5,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomDropDown(
                listData: [
                  LessonPlanStatus.Pending.name,
                  LessonPlanStatus.Processing.name,
                  LessonPlanStatus.Completed.name
                ],
                value: reqModel.status,
                onChangeString: (value) {
                  reqModel.status = value;
                },
                titleText: VariableUtils.statusLesson,
              ),
            ),
            SizeConfig.sH5,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CommonTextField(
                titleText: VariableUtils.progress,
                regularExpression: RegularExpression.digitsPattern,
                textInputType: TextInputType.phone,
                initialValue: reqModel.progress,
                onChange: (str) {
                  reqModel.progress = str;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CommonTextField(
                titleText: VariableUtils.remarkSyllabus.toLowerCase(),
                regularExpression: RegularExpression.addressValidationPattern,
                textInputType: TextInputType.text,
                maxLine: 4,
                onChange: (str) {
                  reqModel.remark = str;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: Get.width * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GetBuilder<LessonPlanViewModel>(
                      tag: LessonPlanViewModel().toString(),
                      builder: (con) {
                        if (con.updateLessonPlanListApiResponse.status ==
                            Status.LOADING) {
                          return CircularProgressIndicator();
                        }
                        return TextButton(
                            onPressed: () async {
                              final status =
                                  await LessonPlanLogic.updateLessonPlanStatus(
                                      reqModel);
                              if (status) {
                                Get.back();
                              }
                            },
                            child: Text(VariableUtils.save));
                      }),
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(VariableUtils.close))
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ));
}
