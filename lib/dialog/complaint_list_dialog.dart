// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_dropdown.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_text_field.dart';
import 'package:msp_educare_demo/common/commonWidgets/dialog_close_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/show_attachment_box.dart';
import 'package:msp_educare_demo/logic/complaint_logic.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_compaint_list_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_department_option_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/validation_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/complaint_viewmodel.dart';
import 'package:msp_educare_demo/viewModel/dropdown_options_viewmodel.dart';
import '../model/apiModel/responseModel/login_res_model.dart';

void showComplaintListDialog(ComplainData data, {bool isFeedback = false}) {
  UserData userData = ConstUtils.getUserData();
  ComplaintViewModel _viewModel =
      Get.find(tag: ComplaintViewModel().toString());
  String feedback = '';
  String deptId;
  GlobalKey<FormState> _formKey = GlobalKey();
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
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      ConstUtils.kStarIcon,
                      color: ColorUtils.darkGrey,
                      size: 20,
                    ),
                    SizeConfig.sW10,
                    Text(
                      VariableUtils.complaintFeedback.toUpperCase(),
                      style: FontTextStyle.poppinsW6S13Grey,
                    ),
                    const Spacer(),
                    const DialogCloseBtn(),
                  ],
                ),
              ),
              SizeConfig.sH10,
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: AbsorbPointer(
                  absorbing: true,
                  child: GetBuilder<DropdownOptionViewModel>(
                    tag: DropdownOptionViewModel().toString(),
                    builder: (controller) {
                      if (controller.getDeptOptionApiResponse.status ==
                          Status.COMPLETE) {
                        GetDepartmentOptionResModel model =
                            controller.getDeptOptionApiResponse.data;
                        List l = [];
                        for (var element in model.data!) {
                          print(
                              'elem :${element.name} leg :${element.name!.length}');
                          print(
                              'trime elem :${element.name!.trimLeft()} leg :${element.name!.trimLeft().length}');
                          l.add(element.name!.trimLeft());
                        }
                        List<String?> list =
                            model.data!.map((e) => e.name).toList();
                        print('LIST DROP DOW :${list[1]!.length}');
                        print('LIST DROP DOW :${list[1]}');
                        print('LIST DROP DOW :${list}');
                        print('LIST DROP DOW :$l');
                        print('DEPT :${data.departmentName}');
                        return CustomDropDown(
                          titleText: VariableUtils.selectDepartment,
                          value: data.departmentName,
                          listData:
                              ConstUtils.convertNullSafetyListToSimpleList(
                                  list),
                          onChangeString: (value) {
                            deptId = model.data!
                                .firstWhere((element) => element.name == value)
                                .id!;
                            print('SELECTED CALUE =>$value');
                          },
                        );
                      }
                      return CustomDropDown(
                        titleText: VariableUtils.selectDepartment,
                        listData: const [],
                        onChangeString: (value) {},
                      );
                    },
                  ),
                ),
              ),
              SizeConfig.sH10,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: CommonTextField(
                  titleText: VariableUtils.complaintSuggestion,
                  regularExpression: RegularExpression.addressValidationPattern,
                  hintText: VariableUtils.complaintSuggestion,
                  initialValue: data.suggestion,
                  readOnly: true,
                  onChange: (value) {},
                  maxLine: 4,
                ),
              ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              //   child: Text(VariableUtils.attachment,
              //       style: FontTextStyle.poppinsW5S12Grey),
              // ),
              SizeConfig.sH5,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text(
                  '${VariableUtils.attachment.capitalizeFirst}',
                  style: FontTextStyle.poppinsW6S12Grey,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: ShowAttachmentBox(
                  link: data.attachment!,
                ),
                // child: DialogTitleDesColumn(
                //     title: VariableUtils.attachment,
                //     value: data.attachment!,
                //     isAttachment: true),
              ),
              SizeConfig.sH10,
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: CommonTextField(
                  titleText: VariableUtils.feedback,
                  regularExpression: RegularExpression.addressValidationPattern,
                  hintText: VariableUtils.feedback,
                  initialValue: data.feedback,
                  readOnly: userData.usertype ==
                          ConstUtils.kGetRoleIndex(VariableUtils.admin)
                      ? false
                      : true,
                  onChange: (value) {
                    feedback = value;
                  },
                  isValidate: true,
                  maxLine: 4,
                  validationMessage: ValidationMsg.isRequired,
                ),
              ),
              if (userData.usertype ==
                  ConstUtils.kGetRoleIndex(VariableUtils.admin))
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GetBuilder<ComplaintViewModel>(
                    tag: ComplaintViewModel().toString(),
                    builder: (controller) {
                      if (controller.saveComplaintFBApiResponse.status ==
                              Status.LOADING ||
                          controller.saveComplaintFBApiResponse.status ==
                              Status.LOADING) {
                        return getDataLoadingIndicator();
                      }
                      return CustomBtn(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            final status = await ComplaintLogic.saveComplaintFb(
                                feedback: feedback,
                                complaintId: data.id!,
                                isFeedback: isFeedback);
                            if (status) {
                              await Future.delayed(const Duration(seconds: 4));
                              // formKey.currentState!.reset();
                              Get.back();
                            }
                          }
                        },
                        radius: 10,
                        title: VariableUtils.save,
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ));
}
