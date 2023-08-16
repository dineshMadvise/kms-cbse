import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/get_file_picker.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonMethods/toast_msg.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_text_field.dart';
import 'package:msp_educare_demo/common/commonWidgets/dialog_close_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/dialog_title_des_column.dart';
import 'package:msp_educare_demo/common/commonWidgets/show_attachment_box.dart';
import 'package:msp_educare_demo/logic/homework_logic.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/save_h_w_remark_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/submit_homework_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_homework_list_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/route_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/validation_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/homework_viewmodel.dart';

import '../model/apiModel/responseModel/login_res_model.dart';

void showHomeworkDialog(HomeWorkData data, int index,
    {SubmissionList? submissionData, bool isReport = false}) {
  HomeWorkViewModel viewModel = Get.find(tag: HomeWorkViewModel().toString());
  UserData userData = ConstUtils.getUserData();
  GlobalKey<FormState> _formKey = GlobalKey();
  SaveHWRemarkReqModel reqModel = SaveHWRemarkReqModel();
  viewModel.selectedFile = '';
  print('submissionData:=>$submissionData');
  Get.dialog(Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    child: Container(
      decoration: DecorationUtils.dialogDecorationBox(),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
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
                      VariableUtils.homeWork.toUpperCase(),
                      style: FontTextStyle.poppinsW6S13Grey,
                    ),
                    const DialogCloseBtn(),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(
                      radius: 5,
                      backgroundColor: ColorUtils.lightRed,
                    ),
                    SizeConfig.sW10,
                    Expanded(
                      child: Text(
                        data.title ?? VariableUtils.none,
                        style: FontTextStyle.poppinsW7S13DarkGrey,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      data.subjectName ?? VariableUtils.none,
                      style: FontTextStyle.poppinsW5S10Grey,
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: DialogTitleDesColumn(
                              title: VariableUtils.teacherName,
                              value: data.teacherName ?? VariableUtils.none),
                        ),
                        if (userData.usertype ==
                                ConstUtils.kGetRoleIndex(
                                    VariableUtils.teacher) &&
                            (data.submissionFile == null ||
                                data.submissionFile == ""))
                          IconButton(
                              onPressed: () {
                                Get.back();
                                RouteUtils.navigateRoute(
                                    RouteUtils.updateHomeWork,
                                    args: data.toJson());
                              },
                              icon: const Icon(Icons.edit))
                      ],
                    ),
                    SizeConfig.sH20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DialogTitleDesColumn(
                            title: VariableUtils.startDate,
                            value: data.hDate ?? VariableUtils.none),
                        const SizedBox(
                          width: 20,
                        ),
                        DialogTitleDesColumn(
                            title: VariableUtils.endDate,
                            value: data.completeDate ?? VariableUtils.none),
                      ],
                    ),
                    SizeConfig.sH5,
                    const Divider(),
                    DialogTitleDesColumn(
                        title: VariableUtils.description,
                        value: data.description ?? VariableUtils.none),
                    SizeConfig.sH5,
                    const Divider(),
                    (data.attachment != null && data.attachment != "") ||
                            (data.attachment != null && data.attachment != "")
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                VariableUtils.attachment,
                                style: FontTextStyle.poppinsW6S12Grey,
                              ),
                              ShowAttachmentBox(link: data.attachment ?? '')
                            ],
                          )
                        : SizeConfig.sH10,
                    if (userData.usertype ==
                            LoginType.Parent.index.toString() &&
                        data.submissionFile != null &&
                        data.submissionFile != "")
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            VariableUtils.attachedHomework,
                            style: FontTextStyle.poppinsW6S12Grey,
                          ),
                          ShowAttachmentBox(link: data.submissionFile ?? '')
                        ],
                      ),
                    submissionData?.attachment == '' ||
                            submissionData?.attachment == null
                        ? SizeConfig.sH10
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                VariableUtils.attachedHomework,
                                style: FontTextStyle.poppinsW6S12Grey,
                              ),
                              ShowAttachmentBox(
                                  link: submissionData?.attachment ?? ''),
                            ],
                          ),
                    if (userData.usertype ==
                        ConstUtils.kGetRoleIndex(VariableUtils.parent))
                      Text(
                        VariableUtils.attachHomework,
                        style: FontTextStyle.poppinsW5S12DarkGrey,
                      ),
                    if (userData.usertype ==
                            ConstUtils.kGetRoleIndex(VariableUtils.parent) &&
                        !isReport)
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () async {
                                File file = await getFile();
                                if (file.path != '') {
                                  viewModel.selectedFile = file.path;
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: ColorUtils.lightGrey,
                                    border: Border.all(color: ColorUtils.grey)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: const Text(VariableUtils.chooseFile),
                              ),
                            ),
                            SizeConfig.sW10,
                            Expanded(
                                child: GetBuilder<HomeWorkViewModel>(
                              tag: HomeWorkViewModel().toString(),
                              builder: (controller) {
                                if (controller.selectedFile == '') {
                                  return const Text(VariableUtils.noFileChosen);
                                }
                                return Text(ConstUtils.kGetFileName(
                                    controller.selectedFile));
                              },
                            )),
                          ],
                        ),
                      ),
                    isReport
                        ? const SizedBox()
                        : userData.usertype !=
                                ConstUtils.kGetRoleIndex(VariableUtils.parent)
                            ? data.submissionList!.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: CommonTextField(
                                      titleText: VariableUtils.remark,
                                      regularExpression: RegularExpression
                                          .addressValidationPattern,
                                      hintText: VariableUtils.reason,
                                      initialValue:
                                          data.submissionList?.first.remark,
                                      maxLine: 2,
                                      onChange: (value) {
                                        reqModel.remark = value;
                                      },
                                    ),
                                  )
                            : DialogTitleDesColumn(
                                title: VariableUtils.remark,
                                value: data.remark ?? VariableUtils.none),
                    SizeConfig.sH10,
                    if ((userData.usertype ==
                                ConstUtils.kGetRoleIndex(
                                    VariableUtils.parent) ||
                            data.submissionList!.isNotEmpty) &&
                        !isReport)
                      GetBuilder<HomeWorkViewModel>(
                        tag: HomeWorkViewModel().toString(),
                        builder: (controller) {
                          if (controller.submitHomeworkApiResponse.status ==
                                  Status.LOADING ||
                              controller.saveHomeworkReviewApiResponse.status ==
                                  Status.LOADING) {
                            return getDataLoadingIndicator();
                          }
                          return CustomBtn(
                            onTap: () async {
                              if (userData.usertype ==
                                  ConstUtils.kGetRoleIndex(
                                      VariableUtils.parent)) {
                                SubmitHomeworkReqModel reqModel =
                                    SubmitHomeworkReqModel();
                                if (viewModel.selectedFile == '') {
                                  showToast(
                                      msg: VariableUtils.pleaseSelectFile);
                                  return;
                                }
                                reqModel.attachment =
                                    convertFileToBase64(viewModel.selectedFile);
                                reqModel.homeworkId = data.id;
                                final status =
                                    await HomeWorkLogic.submitHomeWork(
                                        reqModel);
                                // if (status) {
                                //   await Future.delayed(const Duration(seconds: 4));
                                //   Get.back();
                                // }
                              } else {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  reqModel.homeworkId =
                                      data.submissionList![index].homeworkId;
                                  reqModel.studentId =
                                      data.submissionList![index].studentId;
                                  reqModel.parentId =
                                      data.submissionList![index].parentId;
                                  final status =
                                      await HomeWorkLogic.saveHomeWorkRemark(
                                          reqModel);
                                  if (status) {
                                    await Future.delayed(
                                        const Duration(seconds: 4));
                                    Get.back();
                                  }
                                }
                              }
                            },
                            radius: 10,
                            title: VariableUtils.save,
                          );
                        },
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ));
}
