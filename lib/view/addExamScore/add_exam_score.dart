import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonMethods/toast_msg.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/logic/exam_score_logic.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/get_exam_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/get_exam_score_by_subject_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/get_exam_subject_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/update_exam_score_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_exam_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_exam_score_by_subject_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_section_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_teacher_class_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/validation_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/dropdown_options_viewmodel.dart';
import 'package:msp_educare_demo/viewModel/exam_score_viewmodel.dart';

import '../../common/commonWidgets/loading_dropdown.dart';

class AddExamScore extends StatelessWidget {
  AddExamScore({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final DropdownOptionViewModel _optionViewModel =
      Get.find(tag: DropdownOptionViewModel().toString());
  late UserData userData;
  UpdateExamScoreReqModel reqModel = UpdateExamScoreReqModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: VariableUtils.updateExamScore,
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return GetBuilder<DropdownOptionViewModel>(
        tag: DropdownOptionViewModel().toString(),
        initState: (state) {
          userData = ConstUtils.getUserData();
          _optionViewModel.clearAddExamScore();
          _optionViewModel.getTeacherClassOption(userData.userid!);
        },
        builder: (con) {
          return Container(
            height: Get.height,
            width: Get.width,
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            decoration: DecorationUtils.commonDecorationBox(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Stack(
              children: [
                formData(),
                con.getTeacherClassOptionApiResponse.status == Status.LOADING ||
                        con.getSectionOptionApiResponse.status ==
                            Status.LOADING ||
                        con.getExamOptionApiResponse.status == Status.LOADING ||
                        con.getExamSubjectOptionApiResponse.status ==
                            Status.LOADING ||
                        con.getExamScoreBySubjectApiResponse.status ==
                            Status.LOADING
                    ? postDataLoadingIndicator(color: ColorUtils.transparent)
                    : const SizedBox(),
              ],
            ),
          );
        });
  }

  Widget formData() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 5),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            classDropDown(),
            SizeConfig.sH20,
            sectionDropDown(),
            SizeConfig.sH20,
            examDropDown(),
            SizeConfig.sH20,
            examSubjectDropDown(),
            SizeConfig.sH20,
            typeDropDown(),
            SizeConfig.sH20,
            examScoreTable(),
            SizeConfig.sH20,
            GetBuilder<ExamScoreViewModel>(
              tag: ExamScoreViewModel().toString(),
              builder: (controller) {
                if (controller.updateExamScoreApiResponse.status ==
                    Status.LOADING) {
                  return getDataLoadingIndicator();
                }
                return Visibility(
                  visible: _optionViewModel.examScore.isNotEmpty,
                  child: CustomBtn(
                    onTap: saveBtn,
                    radius: 10,
                    title: VariableUtils.save,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget examScoreTable() => GetBuilder<DropdownOptionViewModel>(
        tag: DropdownOptionViewModel().toString(),
        builder: (con) {
          if (con.getExamScoreBySubjectApiResponse.status != Status.COMPLETE) {
            return const SizedBox();
          }
          GetExamScoreBySubjectResModel subjectResModel =
              con.getExamScoreBySubjectApiResponse.data;
          return SizedBox(
            width: Get.width,
            child: Column(
              children: [
                Container(
                  color: ColorUtils.black2,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            VariableUtils.studentName,
                            style: FontTextStyle.poppinsW6S14White,
                            textAlign: TextAlign.center,
                          )),
                      Expanded(
                          flex: 1,
                          child: Text(
                            reqModel.scoreType == ExamScoreType.Marks.name
                                ? ExamScoreType.Marks.name
                                : ExamScoreType.Grade.name,
                            style: FontTextStyle.poppinsW6S14White,
                            textAlign: TextAlign.center,
                          ))
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorUtils.lightGrey)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: subjectResModel.data!
                        .map((e) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        e.studentName ?? VariableUtils.none,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: TextFormField(
                                            readOnly:
                                                subjectResModel.ediatble ==
                                                    Editable.No.name,
                                            enabled: subjectResModel.ediatble ==
                                                Editable.Yes.name,
                                            initialValue: e.mark ?? '',
                                            keyboardType: reqModel.scoreType ==
                                                    ExamScoreType.Marks.name
                                                ? const TextInputType
                                                        .numberWithOptions(
                                                    decimal: true)
                                                : TextInputType.text,
                                            onChanged: (value) {
                                              _optionViewModel.setExamScore(
                                                  ExamScore(
                                                      marks: value,
                                                      studId: e.studentId));
                                            },
                                            inputFormatters:
                                                reqModel.scoreType ==
                                                        ExamScoreType.Marks.name
                                                    ? [
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                RegularExpression
                                                                    .pricePattern))
                                                      ]
                                                    : [
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                RegularExpression
                                                                    .alphabetPlusPattern))
                                                      ],
                                            decoration: DecorationUtils
                                                .inputDecoration(),
                                          ),
                                        )),
                                  ],
                                ),
                                subjectResModel.data!.indexOf(e) <
                                        subjectResModel.data!.length - 1
                                    ? const Divider()
                                    : SizeConfig.sH5,
                              ],
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          );
        },
      );

  Future<void> saveBtn() async {
    if (formKey.currentState!.validate()) {
      if (_optionViewModel.examScore.isEmpty) {
        showToast(
          msg: VariableUtils.pleaseFirstUpdateMark,
        );
        return;
      }
      log('MARK :=>${_optionViewModel.examScore.map((e) => e.toJson()).toList()}');

      reqModel.score = _optionViewModel.examScore;

      log('REQ :=>${reqModel.toJson()}');

      final status = await ExamScoreLogic.updateExamScore(reqModel);
      log('UPDATE EXAM SCORE STATUS :=>$status');
      if (status) {
        _optionViewModel.clearExamScore();
      }
    }
  }

  /// CLASS DROPDOWN OPTION....................
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
                icon: Icon(
                  ConstUtils.kDownArrowIcon,
                  color: list.isEmpty ? ColorUtils.lightGrey : ColorUtils.grey,
                ),
                validator: ValidationMethod.validateIsRequired,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: FontTextStyle.poppinsW5S16Black,
                onChanged: (String? value) {
                  _optionViewModel.selectedClass = value!;
                  reqModel.classId = model.data!
                      .firstWhere((element) => element.name == value)
                      .id;

                  _optionViewModel.clearAddExamScoreOnClassChange();
                  _optionViewModel
                      .getSectionOption(reqModel.classId.toString());
                  print('SELECTED CLASS =>$value');
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

  /// SECTION DROPDOWN OPTION....................
  Widget sectionDropDown() {
    return GetBuilder<DropdownOptionViewModel>(
      tag: DropdownOptionViewModel().toString(),
      builder: (controller) {
        if (controller.getSectionOptionApiResponse.status == Status.COMPLETE) {
          GetSectionOptionResModel model =
              controller.getSectionOptionApiResponse.data;
          List<String?> list = model.data!.map((e) => e.name).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(VariableUtils.selectSection.toUpperCase(),
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
                value: controller.selectedSection == ""
                    ? null
                    : controller.selectedSection,
                icon: Icon(
                  ConstUtils.kDownArrowIcon,
                  color: list.isEmpty ? ColorUtils.lightGrey : ColorUtils.grey,
                ),
                validator: ValidationMethod.validateIsRequired,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: FontTextStyle.poppinsW5S16Black,
                onChanged: (String? value) {
                  _optionViewModel.selectedSection = value!;
                  reqModel.sectionId = model.data!
                      .firstWhere((element) => element.name == value)
                      .id;
                  _optionViewModel.clearAddExamScoreOnSectionChange();
                  _optionViewModel.getExamOption(GetExamOptionReqModel(
                      classId: reqModel.classId,
                      sectionId: reqModel.sectionId));
                  print('SELECTED SECTION =>$value');
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
          title: VariableUtils.selectSection,
        );
      },
    );
  }

  /// EXAM DROPDOWN OPTION....................
  Widget examDropDown() {
    return GetBuilder<DropdownOptionViewModel>(
      tag: DropdownOptionViewModel().toString(),
      builder: (controller) {
        if (controller.getExamOptionApiResponse.status == Status.COMPLETE) {
          GetExamOptionResModel model =
              controller.getExamOptionApiResponse.data;
          List<String?> list = model.data!.map((e) => e.name).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(VariableUtils.selectExam.toUpperCase(),
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
                value: controller.selectedExam == ""
                    ? null
                    : controller.selectedExam,
                icon: Icon(
                  ConstUtils.kDownArrowIcon,
                  color: list.isEmpty ? ColorUtils.lightGrey : ColorUtils.grey,
                ),
                validator: ValidationMethod.validateIsRequired,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: FontTextStyle.poppinsW5S16Black,
                onChanged: (String? value) {
                  _optionViewModel.selectedExam = value!;
                  reqModel.examId = model.data!
                      .firstWhere((element) => element.name == value)
                      .id;

                  _optionViewModel.clearAddExamScoreOnExamChange();
                  _optionViewModel.getExamSubjectOption(
                      GetExamSubjectOptionReqModel(
                          classId: reqModel.classId,
                          sectionId: reqModel.sectionId,
                          examId: reqModel.examId));

                  print('SELECTED EXAM =>$value');
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
          title: VariableUtils.selectExam,
        );
      },
    );
  }

  /// EXAM SUBJECT DROPDOWN OPTION....................
  Widget examSubjectDropDown() {
    return GetBuilder<DropdownOptionViewModel>(
      tag: DropdownOptionViewModel().toString(),
      builder: (controller) {
        if (controller.getExamSubjectOptionApiResponse.status ==
            Status.COMPLETE) {
          GetExamOptionResModel model =
              controller.getExamSubjectOptionApiResponse.data;
          List<String?> list = model.data!.map((e) => e.name).toList();
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
                items: list
                    .map((e) => DropdownMenuItem(
                          child: Text('$e'),
                          value: e,
                        ))
                    .toList(),
                value: controller.selectedExamSubject == ""
                    ? null
                    : controller.selectedExamSubject,
                icon: Icon(
                  ConstUtils.kDownArrowIcon,
                  color: list.isEmpty ? ColorUtils.lightGrey : ColorUtils.grey,
                ),
                validator: ValidationMethod.validateIsRequired,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: FontTextStyle.poppinsW5S16Black,
                onChanged: (String? value) {
                  _optionViewModel.selectedExamSubject = value!;
                  reqModel.subjectId = model.data!
                      .firstWhere((element) => element.name == value)
                      .id;

                  print('SELECTED EXAM SUBJECT=>$value');
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

  /// TYPE DROPDOWN OPTION....................
  Widget typeDropDown() {
    return GetBuilder<DropdownOptionViewModel>(
      tag: DropdownOptionViewModel().toString(),
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(VariableUtils.selectType.toUpperCase(),
                style: FontTextStyle.poppinsW5S12Grey),
            const SizedBox(
              height: 10,
            ),
            DropdownButtonFormField<String>(
              items: controller.selectedClass.isEmpty ||
                      controller.selectedSection.isEmpty ||
                      controller.selectedExam.isEmpty ||
                      controller.selectedExamSubject.isEmpty
                  ? []
                  : [ExamScoreType.Grade.name, ExamScoreType.Marks.name]
                      .map((e) => DropdownMenuItem(
                            child: Text('$e'),
                            value: e,
                          ))
                      .toList(),
              value: controller.selectedType == ""
                  ? null
                  : controller.selectedType,
              icon: Icon(
                ConstUtils.kDownArrowIcon,
                color: controller.selectedClass.isEmpty ||
                        controller.selectedSection.isEmpty ||
                        controller.selectedExam.isEmpty ||
                        controller.selectedExamSubject.isEmpty
                    ? ColorUtils.lightGrey
                    : ColorUtils.grey,
              ),
              validator: ValidationMethod.validateIsRequired,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: FontTextStyle.poppinsW5S16Black,
              onChanged: (String? value) {
                _optionViewModel.selectedType = value!;
                reqModel.scoreType = value;
                _optionViewModel.getExamScoreBySubject(
                    GetExamScoreBySubjectReqModel(
                        classId: reqModel.classId,
                        sectionId: reqModel.sectionId,
                        examId: reqModel.examId,
                        subjectId: reqModel.subjectId,
                        scoreType: value));
                print('SELECTED TYPE=>$value');
              },
              hint: Text(
                VariableUtils.select,
                style: FontTextStyle.poppinsW5S12Grey,
              ),
              decoration: DecorationUtils.inputDecoration(),
            ),
          ],
        );
      },
    );
  }
}
