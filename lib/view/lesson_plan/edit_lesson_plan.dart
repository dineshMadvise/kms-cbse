import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_datetime_textfield.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_text_field.dart';
import 'package:msp_educare_demo/common/commonWidgets/loading_dropdown.dart';
import 'package:msp_educare_demo/dialog/lesson_plan_dialog.dart';
import 'package:msp_educare_demo/logic/lesson_plan_logic.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/add_lesson_plan_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_lesson_plan_list.dart';

import 'package:msp_educare_demo/model/apiModel/responseModel/get_subject_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_teacher_class_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/lesson_plan_repo.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/dateformat_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/validation_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/dropdown_options_viewmodel.dart';
import 'package:msp_educare_demo/viewModel/lesson_plan_viewmodel.dart';

class EditLessonPlan extends StatefulWidget {
  const EditLessonPlan({Key? key}) : super(key: key);

  @override
  State<EditLessonPlan> createState() => _EditLessonPlanState();
}

class _EditLessonPlanState extends State<EditLessonPlan> {
  final formKey = GlobalKey<FormState>();
  late UserData userData;
  bool isLoading = true;
  LessonPlanViewModel viewmodel =
      Get.find(tag: LessonPlanViewModel().toString());
  AddLessonPlanReqModel reqModel = AddLessonPlanReqModel();
  final DropdownOptionViewModel _optionViewModel =
      Get.find(tag: DropdownOptionViewModel().toString());
  late LessonPlanData lessonPlanData;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    try {
      userData = ConstUtils.getUserData();
      _optionViewModel.getTeacherClassOption(userData.userid!);
      logs('ARG==>${Get.arguments}');

      lessonPlanData = Get.arguments;
      print('======>${Get.arguments}');
      final lessonPlanInfo = await LessonPlanRepo()
          .getLessonPlanInfoRepo(lessonPlanData.id.toString());

      reqModel.classId = lessonPlanInfo.data!.first.classId;
      reqModel.subjectId = lessonPlanInfo.data!.first.subjectId;
      reqModel.startDate = lessonPlanInfo.data!.first.startDate;
      reqModel.endDate = lessonPlanInfo.data!.first.endDate;
      reqModel.objectives = lessonPlanInfo.data!.first.objectives;
      reqModel.aids = lessonPlanInfo.data!.first.aids;
      reqModel.assignment = lessonPlanInfo.data!.first.assignment;
      reqModel.evaluation = lessonPlanInfo.data!.first.evaluation;
      reqModel.lessonPlanId = lessonPlanInfo.data!.first.id;
      await _optionViewModel.getSubjectOption(
          classId: reqModel.classId!, teacherId: userData.userid!);
    } catch (e) {
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: VariableUtils.editLessonPlan),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Stack(
      children: [
        Container(
          height: Get.height,
          width: Get.width,
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          decoration: DecorationUtils.commonDecorationBox(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: isLoading ? getDataLoadingIndicator() : formData(),
        ),
        GetBuilder<LessonPlanViewModel>(
          tag: LessonPlanViewModel().toString(),
          builder: (controller) {
            if (controller.deleteLessonPlanApiResponse.status ==
                    Status.LOADING ||
                controller.deleteLessonPlanApiResponse.status ==
                    Status.LOADING ||
                controller.addLessonPlanListApiResponse.status ==
                    Status.LOADING ||
                controller.addLessonPlanListApiResponse.status ==
                    Status.LOADING) {
              return postDataLoadingIndicator();
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }

  Widget formData() {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 5),
        child: Form(
            key: formKey,
            child: AbsorbPointer(
              absorbing: lessonPlanData.status!.toLowerCase() == 'completed' ||
                  userData.usertype !=
                      ConstUtils.kGetRoleIndex(VariableUtils.teacher),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  classDropDown(),
                  SizeConfig.sH20,
                  subjectDropDown(),
                  SizeConfig.sH20,
                  CustomDateTimeTextField(
                    titleText: VariableUtils.startDate,
                    isValidate: true,
                    initialValue: DateTime.parse(reqModel.startDate.toString()),
                    onChangeDateTime: (value) {
                      print('DATE :$value');
                      reqModel.startDate =
                          DateFormatUtils.yyyyMMDDFormat(value);
                      setState(() {});
                    },
                  ),
                  SizeConfig.sH20,
                  CustomDateTimeTextField(
                    titleText: VariableUtils.completeDate,
                    isValidate: true,
                     initialValue: DateTime.parse(reqModel.endDate.toString()),
                    initialDateShowPicker: reqModel.endDate == null
                        ? null
                        : DateTime.parse(reqModel.endDate.toString())
                            .add(const Duration(days: 8)),
                    onChangeDateTime: (value) {
                      print('DATE :$value');
                      reqModel.endDate = DateFormatUtils.yyyyMMDDFormat(value);
                    },
                  ),
                  SizeConfig.sH10,
                  CommonTextField(
                    titleText: VariableUtils.objective,
                    regularExpression:
                        RegularExpression.addressValidationPattern,
                    hintText: VariableUtils.objective,
                    onChange: (value) {
                      reqModel.objectives = value;
                    },
                    initialValue: reqModel.objectives,
                    // isValidate: true,
                    maxLine: 4,
                    // validationMessage: ValidationMsg.isRequired,
                  ),
                  CommonTextField(
                    titleText: VariableUtils.aids,
                    regularExpression:
                        RegularExpression.addressValidationPattern,
                    hintText: VariableUtils.aid,
                    onChange: (value) {
                      reqModel.aids = value;
                    },
                    initialValue: reqModel.aids,
                    // isValidate: true,
                    maxLine: 4,
                    // validationMessage: ValidationMsg.isRequired,
                  ),
                  CommonTextField(
                    titleText: VariableUtils.assignmen,
                    regularExpression:
                        RegularExpression.addressValidationPattern,
                    hintText: VariableUtils.assignmen,
                    onChange: (value) {
                      reqModel.assignment = value;
                    },
                    initialValue: reqModel.assignment,
                    // isValidate: true,
                    maxLine: 4,
                    // validationMessage: ValidationMsg.isRequired,
                  ),
                  CommonTextField(
                    titleText: VariableUtils.evaluatio,
                    regularExpression:
                        RegularExpression.addressValidationPattern,
                    hintText: VariableUtils.evaluatio,
                    onChange: (value) {
                      reqModel.evaluation = value;
                    },
                    maxLine: 4,
                    initialValue: reqModel.evaluation,
                    // validationMessage: ValidationMsg.isRequired,
                  ),
                  SizeConfig.sH20,
                  if (lessonPlanData.status!.toLowerCase() != 'completed' &&
                      userData.usertype ==
                          ConstUtils.kGetRoleIndex(VariableUtils.teacher))
                    CustomBtn(
                      onTap: saveBtn,
                      radius: 10,
                      title: VariableUtils.update,
                    ),
                  SizeConfig.sH20,
                  if (lessonPlanData.status!.toLowerCase() != 'completed' &&
                      userData.usertype ==
                          ConstUtils.kGetRoleIndex(VariableUtils.teacher))
                    CustomBtn(
                      onTap: () async {
                        final status =
                            await LessonPlanLogic.deleteLessonPlan(reqModel);
                      },
                      radius: 10,
                      title: VariableUtils.delete,
                    ),
                  SizeConfig.sH20,
                  if (lessonPlanData.status!.toLowerCase() != 'completed' &&
                      userData.usertype ==
                          ConstUtils.kGetRoleIndex(VariableUtils.teacher))
                    CustomBtn(
                      onTap: () {
                        showLessonPlanDialog(lessonPlanData);
                      },
                      radius: 10,
                      title: VariableUtils.progress,
                    )
                ],
              ),
            )));
  }

  Future<void> saveBtn() async {
    if (formKey.currentState!.validate()) {
      // if (viewModel.selectedFile == '') {
      //   showToast(msg: VariableUtils.pleaseSelectFile);
      //   return;
      // }

      reqModel.actionType = "Edit";
      final status = await LessonPlanLogic.addLessonPlanStatus(reqModel);
      if (true) {
        // await Future.delayed(Duration(seconds: 2));
        formKey.currentState!.reset();
        _optionViewModel.selectedClass = "";
        _optionViewModel.selectedSubject = '';
        _optionViewModel.clearSectionOption();
      }
    }
  }

  Widget subjectDropDown() {
    return GetBuilder<DropdownOptionViewModel>(
      tag: DropdownOptionViewModel().toString(),
      builder: (controller) {
        if (controller.getSubjectOptionApiResponse.status == Status.COMPLETE) {
          GetSubjectOptionResModel model =
              controller.getSubjectOptionApiResponse.data;

          // List<String?> data = model.data!.map((e) => e.id).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(VariableUtils.selectSubject.toUpperCase(),
                  style: FontTextStyle.poppinsW6S12Grey),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField(
                items: model.data!
                    .map((e) => DropdownMenuItem(
                          child: Text('${e.name}'),
                          value: e.id,
                        ))
                    .toList(),
                value: reqModel.subjectId,
                icon: const Icon(
                  ConstUtils.kDownArrowIcon,
                  color: ColorUtils.grey,
                ),
                validator: ValidationMethod.validateIsRequired,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: FontTextStyle.poppinsW5S16Black,
                onChanged: (String? value) {
                  _optionViewModel.selectedSubject = value!;
                  reqModel.subjectId = value;
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
          // List<String?> list = model.data!.map((e) => e.id).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(VariableUtils.selectClass.toUpperCase(),
                  style: FontTextStyle.poppinsW6S12Grey),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField(
                items: model.data!
                    .map((e) => DropdownMenuItem(
                          child: Text('${e.name}'),
                          value: e.id,
                        ))
                    .toList(),
                value: reqModel.classId,
                icon: const Icon(
                  ConstUtils.kDownArrowIcon,
                  color: ColorUtils.grey,
                ),
                validator: ValidationMethod.validateIsRequired,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: FontTextStyle.poppinsW5S16Black,
                onChanged: (String? value) {
                  _optionViewModel.selectedClass = value!;
                  reqModel.classId = value;

                  _optionViewModel.getSubjectOption(
                      classId: reqModel.classId!, teacherId: userData.userid!);
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
}
