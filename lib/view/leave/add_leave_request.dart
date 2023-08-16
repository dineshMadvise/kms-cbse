import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/get_file_picker.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_datetime_textfield.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_dropdown.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_text_field.dart';
import 'package:msp_educare_demo/logic/leave_logic.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/add_leave_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_leave_type_option_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/dateformat_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/validation_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/dropdown_options_viewmodel.dart';
import 'package:msp_educare_demo/viewModel/leave_viewmodel.dart';

class AddLeaveRequest extends StatefulWidget {
  @override
  State<AddLeaveRequest> createState() => _AddLeaveRequestState();
}

class _AddLeaveRequestState extends State<AddLeaveRequest> {
  final formKey = GlobalKey<FormState>();
  AddLeaveReqModel reqModel = AddLeaveReqModel();
  LeaveViewModel viewModel = Get.find(tag: LeaveViewModel().toString());
  final DropdownOptionViewModel _optionViewModel =
      Get.find(tag: DropdownOptionViewModel().toString());

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    _optionViewModel.getLeaveTypeOption();
    viewModel.resetAddLeaveReq();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: VariableUtils.addLeaveRequest,
      ),
      body: buildBody(),
    );
  }

  Container buildBody() {
    return Container(
      height: Get.height,
      width: Get.width,
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      decoration: DecorationUtils.commonDecorationBox(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: formData(),
    );
  }

  SingleChildScrollView formData() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            leaveTypeDropdown(),
            SizeConfig.sH20,
            CustomDateTimeTextField(
              titleText: VariableUtils.fromDate,
              isValidate: true,
              onChangeDateTime: (value) {
                print('FROM DATE :$value');
                reqModel.fromDate = DateFormatUtils.yyyyMMDDFormat(value);
              },
            ),
            SizeConfig.sH20,
            CustomDateTimeTextField(
              titleText: VariableUtils.toDate,
              isValidate: true,
              onChangeDateTime: (value) {
                reqModel.toDate = DateFormatUtils.yyyyMMDDFormat(value);
                print('TO DATE :$value');
              },
            ),
            SizeConfig.sH20,
            CommonTextField(
              titleText: VariableUtils.reason,
              regularExpression: RegularExpression.addressValidationPattern,
              hintText: VariableUtils.reason,
              onChange: (value) {
                reqModel.reason = value;
              },
              // isValidate: true,
              maxLine: 4,
              // validationMessage: ValidationMsg.isRequired,
            ),
            Text(VariableUtils.attachment.toUpperCase(),
                style: FontTextStyle.poppinsW6S12Grey),
            SizeConfig.sH10,
            Row(
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
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: const Text(VariableUtils.chooseFile),
                  ),
                ),
                SizeConfig.sW10,
                Expanded(
                    child: GetBuilder<LeaveViewModel>(
                  tag: LeaveViewModel().toString(),
                  builder: (controller) {
                    if (controller.selectedFile == '') {
                      return const Text(VariableUtils.noFileChosen);
                    }
                    return Text(
                        ConstUtils.kGetFileName(controller.selectedFile));
                  },
                )),
              ],
            ),
            SizeConfig.sH20,
            GetBuilder<LeaveViewModel>(
              tag: LeaveViewModel().toString(),
              builder: (controller) {
                if (controller.addLeaveReqListApiResponse.status ==
                        Status.LOADING ||
                    controller.addLeaveReqListApiResponse.status ==
                        Status.LOADING) {
                  return getDataLoadingIndicator();
                }
                return CustomBtn(
                  onTap: saveBtn,
                  radius: 10,
                  title: VariableUtils.save,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveBtn() async {
    if (formKey.currentState!.validate()) {
      // if (viewModel.selectedFile == '') {
      //   showToast(msg: VariableUtils.pleaseSelectFile);
      //   return;
      // }
      if (viewModel.selectedFile != '') {
        reqModel.attachment = convertFileToBase64(viewModel.selectedFile);
      }

      final status = await LeaveLogic.addLeaveRequest(reqModel);
      if (status) {
        // await Future.delayed(const Duration(seconds: 2));
        formKey.currentState!.reset();
        viewModel.selectedFile = "";
      }
    }
  }

  GetBuilder<DropdownOptionViewModel> leaveTypeDropdown() {
    return GetBuilder<DropdownOptionViewModel>(
      tag: DropdownOptionViewModel().toString(),
      builder: (controller) {
        if (controller.getLeaveTypeOptionApiResponse.status ==
            Status.COMPLETE) {
          GetLeaveTypeOptionResModel model =
              controller.getLeaveTypeOptionApiResponse.data;
          List<String?> list = model.data!.map((e) => e.name).toList();
          return CustomDropDown(
            titleText: VariableUtils.selectLeaveType,
            listData: ConstUtils.convertNullSafetyListToSimpleList(list),
            value: null,
            onChangeString: (value) {
              reqModel.leaveType =
                  model.data!.firstWhere((element) => element.name == value).id;
              print('SELECTED CALUE =>$value');
            },
          );
        }
        return loadingDropdown(VariableUtils.selectLeaveType);
      },
    );
  }

  CustomDropDown loadingDropdown(String title) {
    return CustomDropDown(
      titleText: title,
      listData: [],
      value: null,
      onChangeString: (value) {},
    );
  }
}
