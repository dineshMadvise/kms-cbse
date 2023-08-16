import 'dart:convert';
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
import 'package:msp_educare_demo/logic/homework_logic.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/update_homework_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_homework_detail_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_homework_list_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/upload_file_repo.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/dateformat_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/validation_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/homework_viewmodel.dart';

class UpdateHomeWork extends StatefulWidget {
  UpdateHomeWork({Key? key}) : super(key: key);

  @override
  State<UpdateHomeWork> createState() => _UpdateHomeWorkState();
}

class _UpdateHomeWorkState extends State<UpdateHomeWork> {
  final formKey = GlobalKey<FormState>();

  HomeWorkViewModel viewModel = Get.find(tag: HomeWorkViewModel().toString());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: customAppbar(
          title: VariableUtils.editHomeWork,
        ),
        body: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return GetBuilder<HomeWorkViewModel>(
        tag: HomeWorkViewModel().toString(),
        initState: (_) async {
          logs('NORMAL REQ MODEL :==>${jsonEncode(Get.arguments)}');
          final homeWorkData =
              HomeWorkData.fromJson(Get.arguments as Map<String, dynamic>);

          viewModel.updateHomeworkApiResponse = ApiResponse.initial('INITIAL');
          viewModel.getHomeworkDetail(homeWorkData.id!);
        },
        builder: (con) {
          if (con.getHomeworkDetailApiResponse.status == Status.LOADING ||
              con.getHomeworkDetailApiResponse.status == Status.INITIAL) {
            return getDataLoadingIndicator();
          }
          if (con.getHomeworkDetailApiResponse.status == Status.ERROR) {
            return getDataErrorMsg();
          }
          GetHomeworkDetailResModel model =
              con.getHomeworkDetailApiResponse.data;
          if (model.status != VariableUtils.ok) {
            return getFieldIsEmptyMsg();
          }
          return Stack(
            children: [
              Container(
                height: Get.height,
                width: Get.width,
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                decoration: DecorationUtils.commonDecorationBox(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: formData(model.data!.first),
              ),
              if (con.updateHomeworkApiResponse.status == Status.LOADING)
                postDataLoadingIndicator()
            ],
          );
        });
  }

  Widget formData(HomeWorkData reqModel) {
    return Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomDateTimeTextField(
                // initialValue: DateTime.parse(reqModel.hDate!),
                hintText: DateFormatUtils.yyyyMMDDFormat(
                    DateTime.parse(reqModel.hDate!)),
                titleText: VariableUtils.date,

                isValidate: true,
                onChangeDateTime: (value) {
                  print('DATE :$value');
                  reqModel.hDate = DateFormatUtils.yyyyMMDDFormat(value);
                },
              ),
              SizeConfig.sH20,
              CustomDateTimeTextField(
                // initialValue: DateTime.parse("2023-05-02"),
                hintText: reqModel.completeDate,
                titleText: VariableUtils.completeDate,
                isValidate: true,
                onChangeDateTime: (value) {
                  print('DATE :$value');
                  reqModel.completeDate = DateFormatUtils.yyyyMMDDFormat(value);
                },
              ),
              SizeConfig.sH20,
              CommonTextField(
                initialValue: reqModel.title,
                titleText: VariableUtils.title,
                regularExpression: RegularExpression.addressValidationPattern,
                hintText: VariableUtils.title,
                onChange: (value) {
                  reqModel.title = value;
                },
                isValidate: true,
                validationMessage: ValidationMsg.isRequired,
              ),
              CommonTextField(
                initialValue: reqModel.description,
                titleText: VariableUtils.description,
                regularExpression: RegularExpression.addressValidationPattern,
                hintText: VariableUtils.description,
                onChange: (value) {
                  reqModel.description = value;
                },
                // isValidate: true,
                maxLine: 4,
                // validationMessage: ValidationMsg.isRequired,
              ),
              // SizeConfig.sH20,
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
                      return Text(
                          ConstUtils.kGetFileName(controller.selectedFile));
                    },
                  )),
                ],
              ),
              SizeConfig.sH20,
              CustomDropDown(
                titleText: VariableUtils.statusStr,
                value: ConstUtils.kOnlineClassInfoStatusOption
                        .contains(reqModel.status)
                    ? reqModel.status
                    : null,
                listData: ConstUtils.kOnlineClassInfoStatusOption,
                onChangeString: (value) {
                  reqModel.status = value as String;
                },
              ),
              SizeConfig.sH20,
              CustomBtn(
                onTap: () {
                  updateBtnOnTap(reqModel);
                },
                radius: 10,
                title: VariableUtils.update,
              ),
            ],
          ),
        ));
  }

  Future<void> updateBtnOnTap(HomeWorkData model) async {
    UpdateHomeworkReqModel reqModel =
        UpdateHomeworkReqModel.fromJson(model.toJson());
    reqModel.homeworkId = model.id;
    print('viewModel.selectedFil=>${viewModel.selectedFile}');
    logs('REQ MODEL :=>${jsonEncode(reqModel.toJson())}');

    // if (viewModel.selectedFile.isNotEmpty) {
    //   viewModel.updateHomeworkApiResponse = ApiResponse.loading('LOADING');
    //   viewModel.update();
    //   final response =
    //       await UploadFileRepo().uploadFile(viewModel.selectedFile);
    //   if (response.status == VariableUtils.ok) {
    //     reqModel.attachment = response.data;
    //   }
    // } else {
    //   reqModel.attachment = "";
    // }
    if (viewModel.selectedFile.isNotEmpty) {
      reqModel.attachment = convertFileToBase64(viewModel.selectedFile);
    } else {
      reqModel.attachment = "";
    }
    logs('FILE ==>--->${reqModel.attachment}');
    final status = await HomeWorkLogic.updateHomework(reqModel);
    if (status) {
      formKey.currentState!.reset();
      viewModel.selectedFile = "";
    }
  }
}
