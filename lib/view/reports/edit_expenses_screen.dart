// ignore_for_file: avoid_print, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/get_file_picker.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonMethods/toast_msg.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/loading_dropdown.dart';
import 'package:msp_educare_demo/logic/report_logic.dart';
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
import 'package:msp_educare_demo/viewModel/report_viewmodel.dart';
import '../../common/commonWidgets/custom_datetime_textfield.dart';
import '../../common/commonWidgets/custom_text_field.dart';
import '../../model/apiModel/requestModel/add_expenses_req_model.dart';
import '../../model/apiModel/responseModel/expenses_report_res_model.dart';
import '../../model/apiModel/responseModel/get_edit_expenses_status_res_model.dart';
import '../../model/apiModel/responseModel/get_edit_expenses_type_res_model.dart';

class EditExpensesScreen extends StatefulWidget {
  const EditExpensesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EditExpensesScreen> createState() => _EditExpensesScreenState();
}

class _EditExpensesScreenState extends State<EditExpensesScreen> {
  final formKey = GlobalKey<FormState>();

  final DropdownOptionViewModel _optionViewModel =
      Get.find(tag: DropdownOptionViewModel().toString());
  final ReportViewModel reportViewModel =
      Get.find<ReportViewModel>(tag: ReportViewModel().toString());

  EditExpensesReqModel reqModels = EditExpensesReqModel();

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    final arguments = Get.arguments;
    reportViewModel.initClearData();

    logs('arguments=>${arguments.runtimeType}');
    if (arguments is ExpensesData) {
      reqModels.expenseId = arguments.id;
      reqModels.attachment = arguments.attachment;
      reqModels.expenseType = arguments.expenseType;
      reqModels.paymentStatus = arguments.paymentStatus;
      reqModels.date =
          arguments.paymentDate != "" && arguments.paymentDate != null
              ? DateFormatUtils.ddMMYYYY2Format(
                  DateTime.parse(arguments.paymentDate!))
              : "";
      reqModels.amount = arguments.amount;
      reqModels.description = arguments.description;
      reqModels.actionType = 'UPDATE';

      print('arguments=>${jsonEncode(arguments.toJson())}');
      print(
          'Expense ID==>: ${reqModels.expenseId}, Expense attachment==>: ${reqModels.attachment}Expense status=========>: ${reqModels.paymentStatus}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: VariableUtils.editExpenses,
      ),
      body: buildBody(),
    );
  }

  Container buildBody() {
    // print('==================>:${reqModels.expenseId}');
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
            statusDropDown(),
            SizeConfig.sH20,
            expensesTypeDropDown(),
            SizeConfig.sH20,
            CustomDateTimeTextField(
              hintText: reqModels.date,
              titleText: VariableUtils.date,
              firstDate: DateTime(2000),
              onChangeDateTime: (value) {
                reqModels.date = DateFormatUtils.ddMMYYYY2Format(value);
                print('DATE :$value');
              },
            ),
            SizeConfig.sH20,
            CommonTextField(
              initialValue: reqModels.amount,
              titleText: VariableUtils.amount,
              regularExpression: RegularExpression.pricePattern,
              textInputType:
                  const TextInputType.numberWithOptions(decimal: true),
              hintText: VariableUtils.amount,
              onChange: (value) {
                reqModels.amount = value;
              },
            ),
            CommonTextField(
              initialValue: reqModels.description,
              titleText: VariableUtils.description,
              regularExpression: RegularExpression.addressValidationPattern,
              hintText: VariableUtils.description,
              onChange: (value) {
                reqModels.description = value;
              },
              // isValidate: true,
              maxLine: 4,
              // validationMessage: ValidationMsg.isRequired,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () async {
                    // File file = await getFile();
                    File file = await getFile();
                    if (file.path != '') {
                      reportViewModel.selectedFiles = file.path;
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
                    child: GetBuilder<ReportViewModel>(
                  tag: ReportViewModel().toString(),
                  builder: (controller) {
                    if (controller.selectedFiles == '') {
                      return const Text(VariableUtils.noFileChosen);
                    }
                    return Text(
                        ConstUtils.kGetFileName(controller.selectedFiles));
                  },
                )),
              ],
            ),
            SizeConfig.sH20,
            GetBuilder<ReportViewModel>(
              tag: ReportViewModel().toString(),
              builder: (controller) {
                if (controller.editExpensesReportApiResponse.status ==
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

  /// ====================  STATUS DROPDOWN  ==================== ///
  Widget statusDropDown() {
    return GetBuilder<DropdownOptionViewModel>(
      tag: DropdownOptionViewModel().toString(),
      builder: (controller) {
        if (controller.getStatusReportAPiResponse.status == Status.COMPLETE) {
          GetEditExpensesStatusResModel model =
              controller.getStatusReportAPiResponse.data;

          // List<String?> data = model.dATA?.map((e) => e.name).toList() ?? [];
          List<String> data = model.dATA?.map((e) => e).toList() ?? [];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(VariableUtils.status.toUpperCase(),
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
                // value: reqModels.paymentStatus == ""
                //     ? null
                //     : reqModels.paymentStatus,
                value: reqModels.paymentStatus,
                icon: const Icon(
                  ConstUtils.kDownArrowIcon,
                  color: ColorUtils.grey,
                ),
                validator: ValidationMethod.validateIsRequired,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: FontTextStyle.poppinsW5S16Black,
                onChanged: (String? value) {
                  reqModels.paymentStatus = value;
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
          title: VariableUtils.status,
        );
      },
    );
  }

  /// ====================  TYPE DROPDOWN  ==================== ///
  Widget expensesTypeDropDown() {
    print('reqModels.paymentStatus:=>${reqModels.expenseType}');
    return GetBuilder<DropdownOptionViewModel>(
      tag: DropdownOptionViewModel().toString(),
      builder: (controller) {
        if (controller.getTypeReportAPiResponse.status == Status.COMPLETE) {
          GetEditExpensesTypeResModel model =
              controller.getTypeReportAPiResponse.data;

          List<String?> data = model.dATA!.map((e) => e.name).toList();
          logs('STATUS ==>${data}');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(VariableUtils.expenseType.toUpperCase(),
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
                value: reqModels.expenseType,
                icon: const Icon(
                  ConstUtils.kDownArrowIcon,
                  color: ColorUtils.grey,
                ),
                validator: ValidationMethod.validateIsRequired,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: FontTextStyle.poppinsW5S16Black,
                onChanged: (String? value) {
                  reqModels.expenseType = value;
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
          title: VariableUtils.type,
        );
      },
    );
  }

  Future<void> saveBtn() async {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> tempReqModel = reqModels.toJson();
      logs('DATA ==>${jsonEncode(tempReqModel)}');
      tempReqModel.removeWhere((key, value) => key == "attachment");

      if (tempReqModel.values
              .toList()
              .indexWhere((element) => element == null || element == "") >
          -1) {
        showToast(msg: VariableUtils.allFieldsAreRequired);
        return;
      }
      reqModels = EditExpensesReqModel.fromJson(tempReqModel);
      if (reportViewModel.selectedFiles.isNotEmpty) {
        reqModels.attachment =
            convertFileToBase64(reportViewModel.selectedFiles ?? '');
      } else {
        reqModels.attachment = "";
      }
      GetEditExpensesTypeResModel getTypeReportOption =
          _optionViewModel.getTypeReportAPiResponse.data;
      logs('reqModels.expenseType=>${reqModels.expenseType}');
      reqModels.expenseType = getTypeReportOption.dATA!
          .firstWhere((element) => element.name == reqModels.expenseType)
          .id;
      logs('AFTER reqModels.expenseType=>${jsonEncode(reqModels.toJson())}');

      final status = await ReportLogic.saveExpenses(reqModels);
    }
  }
}
