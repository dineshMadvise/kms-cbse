

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_datetime_textfield.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_text_field.dart';
import 'package:msp_educare_demo/common/commonWidgets/loading_dropdown.dart';
import 'package:msp_educare_demo/logic/lesson_plan_logic.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/add_lesson_plan_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_subject_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_teacher_class_option_res_model.dart';
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
import 'package:msp_educare_demo/viewModel/lesson_plan_viewmodel.dart';

class AddLessonPlane extends StatefulWidget {
  const AddLessonPlane({Key? key}) : super(key: key);

  @override
  State<AddLessonPlane> createState() => _AddLessonPlaneState();
}

class _AddLessonPlaneState extends State<AddLessonPlane> {
  final formKey = GlobalKey<FormState>();
  late UserData userData;

  LessonPlanViewModel viewmodel =
      Get.find(tag: LessonPlanViewModel().toString());
  AddLessonPlanReqModel reqmodel = AddLessonPlanReqModel();
  final DropdownOptionViewModel _optionViewModel =
      Get.find(tag: DropdownOptionViewModel().toString());

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    userData = ConstUtils.getUserData();
    _optionViewModel.getTeacherClassOption(userData.userid!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: VariableUtils.addLessonePlan),
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
                ConstUtils.kGetRoleIndex(VariableUtils.teacher))
              classDropDown(),
            // classDropdown(),
            SizeConfig.sH20,

            // subjectDropdown(),
            subjectDropDown(),
            SizeConfig.sH20,
            CustomDateTimeTextField(
              titleText: VariableUtils.startDate,
              isValidate: true,
              onChangeDateTime: (value) {
                print('DATE :$value');
                reqmodel.startDate = DateFormatUtils.yyyyMMDDFormat(value);
                setState(() {});
              },
            ),
            SizeConfig.sH20,
            CustomDateTimeTextField(
              titleText: VariableUtils.completeDate,
              isValidate: true,
              initialDateShowPicker: reqmodel.startDate == null
                  ? null
                  : DateTime.parse(reqmodel.startDate.toString())
                      .add(Duration(days: 8)),
              onChangeDateTime: (value) {
                print('DATE :$value');
                reqmodel.endDate = DateFormatUtils.yyyyMMDDFormat(value);
              },
            ),
            SizeConfig.sH10,
            CommonTextField(
              titleText: VariableUtils.objective,
              regularExpression: RegularExpression.addressValidationPattern,
              hintText: VariableUtils.objective,
              onChange: (value) {
                reqmodel.objectives = value;
              },
              // isValidate: true,
              maxLine: 4,
              // validationMessage: ValidationMsg.isRequired,
            ),
            CommonTextField(
              titleText: VariableUtils.aids,
              regularExpression: RegularExpression.addressValidationPattern,
              hintText: VariableUtils.aid,
              onChange: (value) {
                reqmodel.aids = value;
              },
              // isValidate: true,
              maxLine: 4,
              // validationMessage: ValidationMsg.isRequired,
            ),
            CommonTextField(
              titleText: VariableUtils.assignmen,
              regularExpression: RegularExpression.addressValidationPattern,
              hintText: VariableUtils.assignmen,
              onChange: (value) {
                reqmodel.assignment = value;
              },
              // isValidate: true,
              maxLine: 4,
              // validationMessage: ValidationMsg.isRequired,
            ),
            CommonTextField(
              titleText: VariableUtils.evaluatio,
              regularExpression: RegularExpression.addressValidationPattern,
              hintText: VariableUtils.evaluatio,
              onChange: (value) {
                reqmodel.evaluation = value;
              },
              maxLine: 4,
              // validationMessage: ValidationMsg.isRequired,
            ),
            SizeConfig.sH20,
            GetBuilder<LessonPlanViewModel>(
              tag: LessonPlanViewModel().toString(),
              builder: (controller) {
                if (controller.addLessonPlanListApiResponse.status ==
                        Status.LOADING ||
                    controller.addLessonPlanListApiResponse.status ==
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

      reqmodel.actionType="ADD";
      reqmodel.lessonPlanId="0";
      final status = await LessonPlanLogic.addLessonPlanStatus(reqmodel);
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

          List<String?> data = model.data!.map((e) => e.name).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(VariableUtils.selectSubject.toUpperCase(),
                  style: FontTextStyle.poppinsW6S12Grey),
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
                  reqmodel.subjectId = model.data!
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
                  style: FontTextStyle.poppinsW6S12Grey),
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
                  reqmodel.classId = model.data!
                      .firstWhere((element) => element.name == value)
                      .id;

                  _optionViewModel.getSubjectOption(
                      classId: reqmodel.classId!, teacherId: userData.userid!);
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
