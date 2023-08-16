import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonMethods/toast_msg.dart';
import 'package:msp_educare_demo/common/commonWidgets/add_or_forword_circle_box.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/date_box.dart';
import 'package:msp_educare_demo/common/commonWidgets/loading_dropdown.dart';
import 'package:msp_educare_demo/common/commonWidgets/octo_image_network.dart';
import 'package:msp_educare_demo/dialog/exam_score_dialog.dart';
import 'package:msp_educare_demo/dialog/homework_dialog.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/exam_score_report_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/get_exam_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/homework_report_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/exam_score_report_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_class_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_exam_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_exam_score_list_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_homework_list_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_multiple_class_section_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_multiple_class_stud_option_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/dateformat_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/validation_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/view/reports/exam_score_report.dart';
import 'package:msp_educare_demo/viewModel/dropdown_options_viewmodel.dart';
import 'package:msp_educare_demo/viewModel/report_viewmodel.dart';

import '../../common/commonWidgets/custom_datetime_textfield.dart';

class ExamScoreReport extends StatefulWidget {
  ExamScoreReport({Key? key}) : super(key: key);

  @override
  State<ExamScoreReport> createState() => _ExamScoreReportState();
}

class _ExamScoreReportState extends State<ExamScoreReport> {
  final formKey = GlobalKey<FormState>();

  final DropdownOptionViewModel _optionViewModel =
      Get.find(tag: DropdownOptionViewModel().toString());
  final ReportViewModel reportViewModel =
      Get.find<ReportViewModel>(tag: ReportViewModel().toString());
  ExamScoreReportReqModel reqModel = ExamScoreReportReqModel();

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    _optionViewModel.getClassOption();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _optionViewModel.clearApplyPaymentOption();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: VariableUtils.examScoreReport,
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

  /// ====================  FORM DATA  ==================== ///

  SingleChildScrollView formData() {
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
            studentDropDown(),
            SizeConfig.sH20,
            GetBuilder<ReportViewModel>(
              tag: ReportViewModel().toString(),
              builder: (controller) {
                if (controller.examScoreReportApiResponse.status ==
                    Status.LOADING) {
                  return getDataLoadingIndicator();
                }
                return CustomBtn(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    logs('REQ==>${reqModel.toJson()}');
                    if (reqModel.toJson().values.toList().indexWhere(
                            (element) => element == null || element == "") >
                        -1) {
                      showToast(msg: VariableUtils.allFieldsAreRequired);
                      return;
                    }
                    reportViewModel.examScoreReportsAttendance(reqModel);
                  },
                  radius: 10,
                  title: VariableUtils.apply,
                );
              },
            ),
            SizeConfig.sH5,
            const Divider(),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: GetBuilder<ReportViewModel>(
                  tag: ReportViewModel().toString(),
                  builder: (controller) {
                    if (controller.examScoreReportApiResponse.status ==
                            Status.LOADING ||
                        controller.examScoreReportApiResponse.status ==
                            Status.INITIAL) {
                      return const SizedBox();
                    }
                    if (controller.examScoreReportApiResponse.status ==
                        Status.ERROR) {
                      return getDataErrorMsg();
                    }
                    ExamScoreReportResModel model =
                        controller.examScoreReportApiResponse.data;
                    if (model.status != VariableUtils.ok) {
                      return emptyMsg();
                    }
                    print('LENGTH:${model.data!.length}');
                    return model.data!.isEmpty
                        ? getNotApplicableMsg(msg: model.msg)
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: model.data!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  showExamScoreDialog(ExamScoreData.fromJson(
                                      model.data![index].toJson()));
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          DateBox(
                                            text:
                                                model.data![index].startDate ??
                                                    VariableUtils.none,
                                            textStyle:
                                                FontTextStyle.poppinsW6S13Grey,
                                          ),
                                          SizeConfig.sH10,
                                          Text(
                                            model.data![index].examType ??
                                                VariableUtils.none,
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showExamScoreDialog(
                                            ExamScoreData.fromJson(
                                                model.data![index].toJson()));
                                      },
                                      child: const AddOrForwordCircleBox(
                                        icon: ConstUtils.kForwordArrowIcon,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Divider(),
                              );
                            },
                          );
                  },
                )),
          ],
        ),
      ),
    );
  }

  /// ====================  CLASS DROPDOWN  ==================== ///
  Widget classDropDown() {
    return GetBuilder<DropdownOptionViewModel>(
      tag: DropdownOptionViewModel().toString(),
      builder: (controller) {
        if (controller.getCLassOptionApiResponse.status == Status.COMPLETE) {
          GetClassOptionResModel model =
              controller.getCLassOptionApiResponse.data;

          List<String?> data = model.data!.map((e) => e.name).toList();

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
                isExpanded: true,
                items: data
                    .map((e) => DropdownMenuItem(
                          child: Text('$e'),
                          value: e,
                        ))
                    .toList(),
                // value: controller.selectedSubject == ""
                //     ? null
                //     : controller.selectedSubject,
                icon: const Icon(
                  ConstUtils.kDownArrowIcon,
                  color: ColorUtils.grey,
                ),
                validator: ValidationMethod.validateIsRequired,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: FontTextStyle.poppinsW5S16Black,
                onChanged: (String? value) {
                  reqModel.classId = model.data!
                      .firstWhere((element) => element.name == value)
                      .id;
                  _optionViewModel
                      .getMultiClassSectionOption(reqModel.classId ?? "");
                  reqModel.sectionId = "";
                  reqModel.examId = "";
                  reqModel.studentId = "";
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

  /// ====================  SECTION DROPDOWN  ==================== ///
  Widget sectionDropDown() {
    return GetBuilder<DropdownOptionViewModel>(
      tag: DropdownOptionViewModel().toString(),
      builder: (controller) {
        if (controller.getMultipleClassSectionOptionApiResponse.status ==
            Status.COMPLETE) {
          GetMultipleClassSectionOptionResModel model =
              controller.getMultipleClassSectionOptionApiResponse.data;

          List<String?> data = model.data!.map((e) => e.name).toList();

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
                isExpanded: true,
                items: data
                    .map((e) => DropdownMenuItem(
                          child: Text('$e'),
                          value: e,
                        ))
                    .toList(),
                // value: controller.selectedSubject == ""
                //     ? null
                //     : controller.selectedSubject,
                icon: const Icon(
                  ConstUtils.kDownArrowIcon,
                  color: ColorUtils.grey,
                ),
                validator: ValidationMethod.validateIsRequired,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: FontTextStyle.poppinsW5S16Black,
                onChanged: (String? value) {
                  reqModel.sectionId = model.data!
                      .firstWhere((element) => element.name == value)
                      .id;
                  reqModel.examId = "";
                  reqModel.studentId = "";
                  _optionViewModel.getExamOption(GetExamOptionReqModel(
                      classId: reqModel.classId,
                      sectionId: reqModel.sectionId));
                  _optionViewModel.getStudBasedOnClassSectionOption(
                      classId: reqModel.classId!,
                      sectionId: reqModel.sectionId!);
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

  /// ====================  EXAM DROPDOWN  ==================== ///

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
                icon: Icon(
                  ConstUtils.kDownArrowIcon,
                  color: list.isEmpty ? ColorUtils.lightGrey : ColorUtils.grey,
                ),
                validator: ValidationMethod.validateIsRequired,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: FontTextStyle.poppinsW5S16Black,
                onChanged: (String? value) {
                  reqModel.examId = model.data!
                      .firstWhere((element) => element.name == value)
                      .id;
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

  /// ====================  STUDENT DROPDOWN  ==================== ///
  Widget studentDropDown() {
    return GetBuilder<DropdownOptionViewModel>(
      tag: DropdownOptionViewModel().toString(),
      builder: (controller) {
        if (controller.getStudOptionBasedOnClassSectionApiResponse.status ==
            Status.COMPLETE) {
          GetMultipleClassStudOptionResModel model =
              controller.getStudOptionBasedOnClassSectionApiResponse.data;

          // List<String?> data = model.data!.map((e) => e.name).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(VariableUtils.selectStud.toUpperCase(),
                  style: FontTextStyle.poppinsW5S12Grey),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                isExpanded: true,
                items: model.data!
                    .map((e) => DropdownMenuItem(
                          child: Text('${e.name}'),
                          value: e.id,
                        ))
                    .toList(),
                // value: controller.selectedSubject == ""
                //     ? null
                //     : controller.selectedSubject,
                icon: const Icon(
                  ConstUtils.kDownArrowIcon,
                  color: ColorUtils.grey,
                ),
                validator: ValidationMethod.validateIsRequired,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: FontTextStyle.poppinsW5S16Black,
                onChanged: (String? value) {
                  reqModel.studentId = value;
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
          title: VariableUtils.selectStud,
        );
      },
    );
  }
}
