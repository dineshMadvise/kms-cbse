import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/get_file_picker.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_datetime_textfield.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_dropdown.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_text_field.dart';
import 'package:msp_educare_demo/common/commonWidgets/loading_dropdown.dart';
import 'package:msp_educare_demo/logic/homework_logic.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/add_homework_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_section_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_subject_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_teacher_class_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_teacher_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
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
import 'package:msp_educare_demo/viewModel/homework_viewmodel.dart';

class AddHomework extends StatefulWidget {
  @override
  State<AddHomework> createState() => _AddHomeworkState();
}

class _AddHomeworkState extends State<AddHomework> {
  final formKey = GlobalKey<FormState>();
  late UserData userData;

  HomeWorkViewModel viewModel = Get.find(tag: HomeWorkViewModel().toString());
  AddHomeworkReqModel reqModel = AddHomeworkReqModel();
  final DropdownOptionViewModel _optionViewModel =
      Get.find(tag: DropdownOptionViewModel().toString());

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    viewModel.clearSelectedSectionList();
    viewModel.initClearData();
    userData = ConstUtils.getUserData();
    if (userData.usertype == ConstUtils.kGetRoleIndex(VariableUtils.admin)) {
      _optionViewModel.getTeacherOption();
    }

    if (userData.usertype == ConstUtils.kGetRoleIndex(VariableUtils.teacher)) {
      reqModel.teacherId = userData.userid!;
      _optionViewModel.getTeacherClassOption(userData.userid!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: VariableUtils.addHomework,
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
      padding: const EdgeInsets.only(bottom: 5),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (userData.usertype ==
                ConstUtils.kGetRoleIndex(VariableUtils.admin))
              teacherDropdown(),
            SizeConfig.sH20,
            classDropDown(),
            // classDropdown(),
            SizeConfig.sH20,
            Text(VariableUtils.selectSection.toUpperCase(),
                style: FontTextStyle.poppinsW5S12Grey),
            SizeConfig.sH10,
            sectionListTile(),
            SizeConfig.sH20,
            // subjectDropdown(),
            subjectDropDown(),
            SizeConfig.sH20,
            CustomDateTimeTextField(
              titleText: VariableUtils.date,
              isValidate: true,
              onChangeDateTime: (value) {
                print('DATE :$value');
                reqModel.hDate = DateFormatUtils.yyyyMMDDFormat(value);
              },
            ),
            SizeConfig.sH20,
            CustomDateTimeTextField(
              titleText: VariableUtils.completeDate,
              isValidate: true,
              onChangeDateTime: (value) {
                print('DATE :$value');
                reqModel.completeDate = DateFormatUtils.yyyyMMDDFormat(value);
              },
            ),
            SizeConfig.sH20,
            CommonTextField(
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
            SizeConfig.sH20,
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
            GetBuilder<HomeWorkViewModel>(
              tag: HomeWorkViewModel().toString(),
              builder: (controller) {
                if (controller.addHomeworkApiResponse.status ==
                        Status.LOADING ||
                    controller.addHomeworkApiResponse.status ==
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
      String sectionList = '';
      viewModel.selectedSectionList.forEach((element) {
        sectionList = sectionList + ',' + element;
      });
      sectionList = sectionList.substring(1);
      reqModel.sectionId = sectionList;
      reqModel.attachment = convertFileToBase64(viewModel.selectedFile);
      final status = await HomeWorkLogic.addHomework(reqModel);
      if (status) {
        // await Future.delayed(Duration(seconds: 2));
        formKey.currentState!.reset();
        viewModel.selectedFile = "";
        viewModel.clearSelectedSectionList();
        _optionViewModel.selectedClass = "";
        _optionViewModel.selectedSubject = '';
        _optionViewModel.clearSectionOption();
      }
    }
  }

  GetBuilder<DropdownOptionViewModel> sectionListTile() {
    return GetBuilder<DropdownOptionViewModel>(
      tag: DropdownOptionViewModel().toString(),
      builder: (controller) {
        if (controller.getSectionOptionApiResponse.status == Status.COMPLETE) {
          GetSectionOptionResModel model =
              controller.getSectionOptionApiResponse.data;

          // List<dynamic> list = model.data!.map((e) => e.name).toList();
          return Container(
            decoration: DecorationUtils.borderDecorationBox(),
            height: Get.height * 0.2,
            child: ListView(
              children: model.data!
                  .map((e) => GetBuilder<HomeWorkViewModel>(
                        tag: HomeWorkViewModel().toString(),
                        builder: (con) {
                          return Container(
                            decoration: BoxDecoration(
                                color: con.selectedSectionList.contains(e.id)
                                    ? ColorUtils.blue
                                    : ColorUtils.transparent,
                                borderRadius: BorderRadius.circular(4)),
                            margin: EdgeInsets.only(
                                top: model.data!.indexOf(e) == 0 ? 0 : 5),
                            child: ListTile(
                              onTap: () {
                                viewModel.setSectionList(e.id!);
                              },
                              title: Text(
                                e.name ?? VariableUtils.none,
                                style: con.selectedSectionList.contains(e.id)
                                    ? FontTextStyle.poppinsW5S16White
                                    : FontTextStyle.poppinsW5S16Black,
                              ),
                            ),
                          );
                        },
                      ))
                  .toList(),
            ),
          );
        }
        return Container(
          decoration: DecorationUtils.borderDecorationBox(),
          height: Get.height * 0.2,
        );
      },
    );
  }

  Widget subjectDropDown() {
    return GetBuilder<DropdownOptionViewModel>(
      tag: DropdownOptionViewModel().toString(),
      builder: (controller) {
        if (controller.getSubjectOptionApiResponse.status == Status.COMPLETE) {
          GetSubjectOptionResModel model =
              controller.getSubjectOptionApiResponse.data;

          List<String?> data = model.data!.map((e) => e.name).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(VariableUtils.selectSubject.toUpperCase(),
                  style: FontTextStyle.poppinsW5S12Grey),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                items: data
                    .map((e) => DropdownMenuItem(
                          child: Text('$e'),
                          value: e,
                        ))
                    .toList(),
                value: controller.selectedSubject == ""
                    ? null
                    : controller.selectedSubject,
                icon: const Icon(
                  ConstUtils.kDownArrowIcon,
                  color: ColorUtils.grey,
                ),
                validator: ValidationMethod.validateIsRequired,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: FontTextStyle.poppinsW5S16Black,
                onChanged: (String? value) {
                  _optionViewModel.selectedSubject = value!;
                  reqModel.subjectId = model.data!
                      .firstWhere((element) => element.name == value)
                      .id;
                },
                hint: Text(
                  VariableUtils.select,
                  style: FontTextStyle.poppinsW5S12Grey,
                ),
                decoration: DecorationUtils.inputDecoration(),
              ),
            ],
          );
        }
        return const LoadingDropDown(
          title: VariableUtils.selectSubject,
        );
      },
    );
  }

  Widget classDropDown() {
    return GetBuilder<DropdownOptionViewModel>(
      tag: DropdownOptionViewModel().toString(),
      builder: (controller) {
        if (controller.getTeacherClassOptionApiResponse.status ==
            Status.COMPLETE) {
          GetTeacherClassOptionResModel model =
              controller.getTeacherClassOptionApiResponse.data;
          List<String?> list = model.data!.map((e) => e.name).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(VariableUtils.selectClass.toUpperCase(),
                  style: FontTextStyle.poppinsW5S12Grey),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                items: list
                    .map((e) => DropdownMenuItem(
                          child: Text('$e'),
                          value: e,
                        ))
                    .toList(),
                value: controller.selectedClass == ""
                    ? null
                    : controller.selectedClass,
                icon: const Icon(
                  ConstUtils.kDownArrowIcon,
                  color: ColorUtils.grey,
                ),
                validator: ValidationMethod.validateIsRequired,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: FontTextStyle.poppinsW5S16Black,
                onChanged: (String? value) {
                  _optionViewModel.selectedClass = value!;
                  reqModel.classId = model.data!
                      .firstWhere((element) => element.name == value)
                      .id;

                  _optionViewModel
                      .getSectionOption(reqModel.classId.toString());
                  _optionViewModel.getSubjectOption(
                      classId: reqModel.classId!,
                      teacherId: reqModel.teacherId!);
                  _optionViewModel.selectedSubject = '';
                  print('SELECTED CALUE =>$value');
                },
                hint: Text(
                  VariableUtils.select,
                  style: FontTextStyle.poppinsW5S12Grey,
                ),
                decoration: DecorationUtils.inputDecoration(),
              ),
            ],
          );
        }
        return const LoadingDropDown(
          title: VariableUtils.selectClass,
        );
      },
    );
  }

  // GetBuilder<DropdownOptionViewModel> subjectDropdown() {
  //   return GetBuilder<DropdownOptionViewModel>(
  //     tag: DropdownOptionViewModel().toString(),
  //     builder: (controller) {
  //       if (controller.getSubjectOptionApiResponse.status == Status.COMPLETE) {
  //         GetSubjectOptionResModel model =
  //             controller.getSubjectOptionApiResponse.data;
  //
  //         List<String?> data = model.data!.map((e) => e.name).toList();
  //         return CustomDropDown(
  //           titleText: VariableUtils.selectSubject,
  //           listData: ConstUtils.convertNullSafetyListToSimpleList(data),
  //           value: null,
  //           onChangeString: (value) {
  //             reqModel.subjectId =
  //                 model.data!.firstWhere((element) => element.name == value).id;
  //             print('SELECTED CALUE =>$value');
  //           },
  //         );
  //       }
  //       return loadingDropdown(
  //         VariableUtils.selectSubject,
  //       );
  //     },
  //   );
  // }

  // GetBuilder<DropdownOptionViewModel> classDropdown() {
  //   return GetBuilder<DropdownOptionViewModel>(
  //     tag: DropdownOptionViewModel().toString(),
  //     builder: (controller) {
  //       if (controller.getTeacherClassOptionApiResponse.status ==
  //           Status.COMPLETE) {
  //         GetTeacherClassOptionResModel model =
  //             controller.getTeacherClassOptionApiResponse.data;
  //         List<String?> list = model.data!.map((e) => e.name).toList();
  //         return CustomDropDown(
  //           titleText: VariableUtils.selectClass,
  //           listData: ConstUtils.convertNullSafetyListToSimpleList(list),
  //           value: null,
  //           onChangeString: (value) {
  //             reqModel.classId =
  //                 model.data!.firstWhere((element) => element.name == value).id;
  //
  //             _optionViewModel.getSectionOption(reqModel.classId.toString());
  //             _optionViewModel.getSubjectOption(
  //                 classId: reqModel.classId!, teacherId: reqModel.teacherId!);
  //             _optionViewModel.selectedSubject = '';
  //             print('SELECTED CALUE =>$value');
  //           },
  //         );
  //       }
  //       return loadingDropdown(VariableUtils.selectClass);
  //     },
  //   );
  // }

  GetBuilder<DropdownOptionViewModel> teacherDropdown() {
    return GetBuilder<DropdownOptionViewModel>(
      tag: DropdownOptionViewModel().toString(),
      builder: (controller) {
        if (controller.getTeacherOptionApiResponse.status == Status.COMPLETE) {
          GetTeacherOptionResModel model =
              controller.getTeacherOptionApiResponse.data;

          List<String?> list = model.data!.map((e) => e.name).toList();
          return CustomDropDown(
            titleText: VariableUtils.selectTeacher,
            listData: ConstUtils.convertNullSafetyListToSimpleList(list),
            onChangeString: (value) {
              reqModel.teacherId =
                  model.data!.firstWhere((element) => element.name == value).id;
              _optionViewModel
                  .getTeacherClassOption(reqModel.teacherId.toString());
              _optionViewModel.selectedClass = "";
              _optionViewModel.selectedSubject = "";
              print('SELECTED CALUE =>$value');
            },
          );
        }
        return const LoadingDropDown(
          title: VariableUtils.selectTeacher,
        );
      },
    );
  }
}
