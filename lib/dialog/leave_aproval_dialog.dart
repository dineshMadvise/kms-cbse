import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_dropdown.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_text_field.dart';
import 'package:msp_educare_demo/common/commonWidgets/dialog_close_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/dialog_title_des_column.dart';
import 'package:msp_educare_demo/common/commonWidgets/show_attachment_box.dart';
import 'package:msp_educare_demo/logic/leave_logic.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/save_leave_approval_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_leave_approval_list_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/validation_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/leave_viewmodel.dart';

void showLeaveApprovalDialog(Data data) {
  SaveLeaveApprovalReqModel reqModel = SaveLeaveApprovalReqModel();
  GlobalKey<FormState> _formKey = GlobalKey();
  Get.dialog(Dialog(
    insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    child: Container(
      decoration: DecorationUtils.dialogDecorationBox(),
      padding: EdgeInsets.symmetric(vertical: 20),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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
                    Icon(
                      ConstUtils.kStarIcon,
                      color: ColorUtils.darkGrey,
                      size: 20,
                    ),
                    SizeConfig.sW10,
                    Text(
                      VariableUtils.casualLeave.toUpperCase(),
                      style: FontTextStyle.poppinsW6S13Grey,
                    ),
                    Spacer(),
                    DialogCloseBtn(),
                  ],
                ),
              ),
              SizeConfig.sH10,
              Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: DialogTitleDesColumn(
                    title: VariableUtils.description + ' : ',
                    value: data.reason ?? VariableUtils.none),
              ),
              Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  '${VariableUtils.attachment.capitalizeFirst}',
                  style: FontTextStyle.poppinsW6S12Grey,
                ),
              ),
              if (data.attachment != null && data.attachment != "")
                Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: ShowAttachmentBox(
                      link: data.attachment!,
                    )
                    // InkWell(
                    //   onTap: () {
                    //     if (data.attachment != "" && data.attachment != null) {
                    //       RouteUtils.navigateRoute(RouteUtils.webViewScreen,
                    //           args: data.attachment);
                    //     }
                    //   },
                    //   child: Text(
                    //     ConstUtils.kGetFileName(data.attachment!),
                    //     style: FontTextStyle.poppinsW5S12Grey,
                    //   ),
                    // ),
                    ),
              Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: AbsorbPointer(
                  absorbing: data.status != VariableUtils.pending,
                  child: CustomDropDown(
                    titleText: VariableUtils.selectStatus,
                    listData: data.status == VariableUtils.pending
                        ? [VariableUtils.approved, VariableUtils.rejected]
                        : [data.status!],
                    value: data.status == VariableUtils.pending
                        ? null
                        : data.status,
                    onChangeString: (value) {
                      reqModel.status = value;
                    },
                  ),
                ),
              ),
              SizeConfig.sH10,
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: CommonTextField(
                  titleText: VariableUtils.reason,
                  regularExpression: RegularExpression.addressValidationPattern,
                  hintText: VariableUtils.reason,
                  initialValue: data.approvedReason,
                  readOnly: data.status == VariableUtils.pending ? false : true,
                  onChange: (value) {
                    reqModel.approvedReason = value;
                  },
                  isValidate: true,
                  maxLine: 4,
                  validationMessage: ValidationMsg.isRequired,
                ),
              ),
              if (data.status == VariableUtils.pending)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: GetBuilder<LeaveViewModel>(
                    tag: LeaveViewModel().toString(),
                    builder: (controller) {
                      if (controller.saveLeaveApprovalApiResponse.status ==
                          Status.LOADING) {
                        return getDataLoadingIndicator();
                      }
                      return CustomBtn(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            reqModel.leaveId = data.id;
                            LeaveLogic.saveLeaveApproval(reqModel);
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
