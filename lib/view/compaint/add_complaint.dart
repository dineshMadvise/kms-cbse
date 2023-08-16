import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/get_file_picker.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_dropdown.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_text_field.dart';
import 'package:msp_educare_demo/logic/complaint_logic.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/add_complaint_req_model.dart';
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

class AddComplaint extends StatefulWidget {
  @override
  State<AddComplaint> createState() => _AddComplaintState();
}

class _AddComplaintState extends State<AddComplaint> {
  final formKey = GlobalKey<FormState>();

  AddComplaintReqModel reqModel = AddComplaintReqModel();

  ComplaintViewModel viewModel = Get.find(tag: ComplaintViewModel().toString());

  DropdownOptionViewModel _optionViewModel =
      Get.find(tag: DropdownOptionViewModel().toString());

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    _optionViewModel.getDepartmentOption();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      viewModel.selectedFile = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: VariableUtils.addComplaint,
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Stack(
      children: [
        Container(
          // height: Get.height,
          width: Get.width,
          margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
          decoration: DecorationUtils.commonDecorationBox(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: formData(),
        ),
        GetBuilder<ComplaintViewModel>(
          tag: ComplaintViewModel().toString(),
          builder: (controller) {
            if (controller.addComplaintListApiResponse.status ==
                Status.LOADING) {
              return postDataLoadingIndicator();
            }
            return SizedBox();
          },
        )
      ],
    );
  }

  SingleChildScrollView formData() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            deptDropdown(),
            SizeConfig.sH20,
            CommonTextField(
              titleText: VariableUtils.complaintSuggestion,
              regularExpression: RegularExpression.addressValidationPattern,
              hintText: VariableUtils.reason,
              onChange: (value) {
                reqModel.suggestion = value;
              },
              isValidate: true,
              maxLine: 4,
              validationMessage: ValidationMsg.isRequired,
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
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      VariableUtils.chooseFile,
                    ),
                  ),
                ),
                SizeConfig.sW10,
                Expanded(
                    child: GetBuilder<ComplaintViewModel>(
                  tag: ComplaintViewModel().toString(),
                  builder: (controller) {
                    if (controller.selectedFile == '') {
                      return Text(VariableUtils.noFileChosen);
                    }
                    return Text(
                        ConstUtils.kGetFileName(controller.selectedFile));
                  },
                )),
              ],
            ),
            SizeConfig.sH20,
            CustomBtn(
              onTap: saveBtn,
              radius: 10,
              title: VariableUtils.save,
            ),
          ],
        ),
      ),
    );
  }

  GetBuilder<DropdownOptionViewModel> deptDropdown() {
    return GetBuilder<DropdownOptionViewModel>(
      tag: DropdownOptionViewModel().toString(),
      builder: (controller) {
        if (controller.getDeptOptionApiResponse.status == Status.COMPLETE) {
          GetDepartmentOptionResModel model =
              controller.getDeptOptionApiResponse.data;
          List<String?> list = model.data!.map((e) => e.name).toList();
          return CustomDropDown(
            titleText: VariableUtils.selectDepartment,
            listData: ConstUtils.convertNullSafetyListToSimpleList(list),
            onChangeString: (value) {
              reqModel.departmentId =
                  model.data!.firstWhere((element) => element.name == value).id;
              print('SELECTED CALUE =>$value');
            },
          );
        }
        return CustomDropDown(
          titleText: VariableUtils.selectDepartment,
          listData: [],
          onChangeString: (value) {},
        );
      },
    );
  }

  Future<void> saveBtn() async {
    if (formKey.currentState!.validate()) {
      // if (viewModel.selectedFile == '') {
      //   showToast(msg: VariableUtils.pleaseSelectFile);
      //   return;
      // }
      // reqModel.attachment = convertFileToBase64(viewModel.selectedFile);
      if (viewModel.selectedFile != '') {
        reqModel.attachment = convertFileToBase64(viewModel.selectedFile);
      }
      final status = await ComplaintLogic.addComplaint(reqModel);
      if (status) {
        // await Future.delayed(Duration(seconds: 2));
        formKey.currentState!.reset();
        viewModel.selectedFile = "";
      }
    }
  }
}
