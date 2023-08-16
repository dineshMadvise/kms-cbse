// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonMethods/toast_msg.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_datetime_textfield.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_text_field.dart';
import 'package:msp_educare_demo/common/commonWidgets/loading_dropdown.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/apply_payment_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_class_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_multiple_class_section_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_multiple_class_stud_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_payment_mode_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_student_pending_fee_res_model.dart';
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
import 'package:msp_educare_demo/viewModel/payment_viewmodel.dart';

class ApplyPayment extends StatefulWidget {
  const ApplyPayment({Key? key}) : super(key: key);

  @override
  State<ApplyPayment> createState() => _ApplyPaymentState();
}

class _ApplyPaymentState extends State<ApplyPayment> {
  final formKey = GlobalKey<FormState>();

  final DropdownOptionViewModel _optionViewModel =
      Get.find(tag: DropdownOptionViewModel().toString());
  final PaymentViewModel paymentViewModel =
      Get.find<PaymentViewModel>(tag: PaymentViewModel().toString());

  final ApplyPaymentReqModel reqModel = ApplyPaymentReqModel();

  FeesData feesData = FeesData();

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    _optionViewModel.getClassOption();
    _optionViewModel.getPaymentModeOption();
    _optionViewModel.getGetBankAccount();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _optionViewModel.clearApplyPaymentOption();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: VariableUtils.applyPayment,
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
            studentDropDown(),
            SizeConfig.sH20,
            feesTypeDropDown(),
            SizeConfig.sH20,
            bankAccountDropDown(),
            SizeConfig.sH20,
            CustomDateTimeTextField(
              titleText: VariableUtils.paymentDate,
              firstDate: DateTime(2000),
              onChangeDateTime: (value) {
                reqModel.paymentDate = DateFormatUtils.ddMMYYYY2Format(value);
                print('DATE :$value');
              },
            ),
            SizeConfig.sH20,
            CommonTextField(
              titleText: VariableUtils.amount,
              regularExpression: RegularExpression.pricePattern,
              hintText: VariableUtils.amount,
              validationMessage: ValidationMsg.isRequired,
              isValidate: true,
              textInputType:
                  const TextInputType.numberWithOptions(decimal: true),
              onChange: (str) {
                reqModel.paidAmount = str;
              },
            ),
            // SizeConfig.sH20,
            paymentModeDropDown(),
            SizeConfig.sH20,
            Builder(
              key: ValueKey(feesData.feeType),
              builder: (context) => CommonTextField(
                initialValue: feesData.feeType ?? "",
                titleText: VariableUtils.remark,
                regularExpression: RegularExpression.addressValidationPattern,
                hintText: VariableUtils.remark,
                onChange: (value) {
                  reqModel.remark = value;
                },
                // isValidate: true,
                // validationMessage: ValidationMsg.isRequired,
              ),
            ),

            SizeConfig.sH20,
            GetBuilder<PaymentViewModel>(
              tag: PaymentViewModel().toString(),
              builder: (controller) {
                if (controller.saveApplyPaymentApiResponse.status ==
                    Status.LOADING) {
                  return getDataLoadingIndicator();
                }
                return CustomBtn(
                  onTap: onTap,
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

  /// ====================  SAVE BUTTON ON TAP  ==================== ///
  Future<void> onTap() async {
    if (formKey.currentState!.validate()) {
      logs('REQ =>${jsonEncode(reqModel.toJson())}');
      FocusScope.of(context).unfocus();
      if (double.parse(reqModel.paidAmount ?? "0") >
          (feesData.balAmount ?? 0)) {
        showToast(msg: VariableUtils.pleaseEnterValidAmount);
        return;
      }
      await paymentViewModel.saveApplyPayment(reqModel);
      if (paymentViewModel.saveApplyPaymentApiResponse.status ==
          Status.COMPLETE) {
        paymentViewModel.getPaymentList();
        Get.back();
        showToast(msg: VariableUtils.paymentAppliedSuccess, success: true);
        // formKey.currentState!.reset();

        feesData = FeesData();
        setState(() {});
      }
    }
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
                  _optionViewModel.getStudOptionBasedOnClassSectionApiResponse =
                      ApiResponse.initial('INITIAL');
                  _optionViewModel.getStudentPendingFeesOptionApiResponse =
                      ApiResponse.initial('INITIAL');
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
                  // _optionViewModel.selectedSection = value!;
                  reqModel.sectionId = model.data!
                      .firstWhere((element) => element.name == value)
                      .id;
                  _optionViewModel.getStudBasedOnClassSectionOption(
                      classId: reqModel.classId!,
                      sectionId: reqModel.sectionId!);
                  _optionViewModel.getStudentPendingFeesOptionApiResponse =
                      ApiResponse.initial('INITIAL');
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
                  // model.data!
                  // .firstWhere((element) => element.name == value)
                  // .id;
                  _optionViewModel
                      .getStudentPendingFeesOption(reqModel.studentId!);
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

  /// ====================  FEES TYPE DROPDOWN  ==================== ///
  Widget feesTypeDropDown() {
    return GetBuilder<DropdownOptionViewModel>(
      tag: DropdownOptionViewModel().toString(),
      builder: (controller) {
        if (controller.getStudentPendingFeesOptionApiResponse.status ==
            Status.COMPLETE) {
          GetStudentPendingFeeResModel model =
              controller.getStudentPendingFeesOptionApiResponse.data;

          // List<String?> data = model.data!.map((e) => e.name).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(VariableUtils.selectFeesType.toUpperCase(),
                  style: FontTextStyle.poppinsW5S12Grey),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                isExpanded: true,
                items: model.data!
                    .map((e) => DropdownMenuItem(
                          child: Text(
                            '${e.feeType}',
                          ),
                          value: e.feeId,
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
                  reqModel.feeId = value;
                  // model.data!
                  // .firstWhere((element) => element.name == value)
                  // .feeId;
                  feesData = model.data!
                      .firstWhere((element) => element.feeId == value);
                  reqModel.feeAmount = feesData.feeAmount.toString();
                  reqModel.dueDate = feesData.dueDate;
                  reqModel.remark = feesData.feeType;

                  setState(() {});
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
          title: VariableUtils.selectFeesType,
        );
      },
    );
  }

  /// ====================  BANK ACCOUNT DROPDOWN  ==================== ///
  Widget bankAccountDropDown() {
    return GetBuilder<DropdownOptionViewModel>(
      tag: DropdownOptionViewModel().toString(),
      builder: (controller) {
        if (controller.getGetBankAccountOptionApiResponse.status ==
            Status.COMPLETE) {
          GetMultipleClassStudOptionResModel model =
              controller.getGetBankAccountOptionApiResponse.data;
          List<String?> data = model.data!.map((e) => e.name).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(VariableUtils.selectBankAccount.toUpperCase(),
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
                icon: const Icon(
                  ConstUtils.kDownArrowIcon,
                  color: ColorUtils.grey,
                ),
                validator: ValidationMethod.validateIsRequired,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: FontTextStyle.poppinsW5S16Black,
                onChanged: (String? value) {
                  reqModel.bankId = model.data!
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
          title: VariableUtils.selectBankAccount,
        );
      },
    );
  }

  /// ==================== PAYMENT MODE DROPDOWN  ==================== ///
  Widget paymentModeDropDown() {
    return GetBuilder<DropdownOptionViewModel>(
      tag: DropdownOptionViewModel().toString(),
      builder: (controller) {
        if (controller.getPaymentModeOptionApiResponse.status ==
            Status.COMPLETE) {
          GetPaymentModeResModel model =
              controller.getPaymentModeOptionApiResponse.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(VariableUtils.paymentMode.toUpperCase(),
                  style: FontTextStyle.poppinsW5S12Grey),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                isExpanded: true,
                items: model.data!
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
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
                  reqModel.paymentMode = value;
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
          title: VariableUtils.paymentMode,
        );
      },
    );
  }
}
